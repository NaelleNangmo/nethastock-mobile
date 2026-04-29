import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';

class ApiClient {
  ApiClient._();

  static final Dio _dio = Dio(BaseOptions(
    baseUrl:        ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
    headers: {'Content-Type': 'application/json'},
  ));

  static bool _interceptorAdded = false;

  static Dio get instance {
    if (!_interceptorAdded) {
      _dio.interceptors.add(_AuthInterceptor(_dio));
      _interceptorAdded = true;
    }
    return _dio;
  }
}

class _AuthInterceptor extends Interceptor {
  final Dio _dio;
  bool _isRefreshing = false;

  _AuthInterceptor(this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        final refreshToken = await SecureStorage.getRefreshToken();
        if (refreshToken == null) {
          await SecureStorage.clearAuth();
          handler.next(err);
          return;
        }

        // Appel refresh sans intercepteur pour éviter la boucle
        final refreshDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
        final res = await refreshDio.post(
          ApiConstants.refresh,
          data: {'refreshToken': refreshToken},
        );

        final newToken = res.data['data']['accessToken'] as String;
        await SecureStorage.saveAccessToken(newToken);

        // Retry la requête originale avec le nouveau token
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $newToken';
        final retryRes = await _dio.fetch(opts);
        handler.resolve(retryRes);
      } catch (_) {
        await SecureStorage.clearAuth();
        handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      handler.next(err);
    }
  }
}
