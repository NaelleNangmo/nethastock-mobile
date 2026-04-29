import '../../../core/network/api_client.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/storage/secure_storage.dart';
import '../models/auth_model.dart'; // exporte aussi SiteModel

class AuthService {
  AuthService._();

  static final _dio = ApiClient.instance;

  // ── Login ────────────────────────────────────────────────────
  static Future<AuthResponse> login(LoginRequest req) async {
    final res = await _dio.post(ApiConstants.login, data: req.toJson());
    final data = res.data['data'] as Map<String, dynamic>;
    final auth = AuthResponse.fromJson(data);

    await Future.wait([
      SecureStorage.saveAccessToken(auth.accessToken),
      SecureStorage.saveRefreshToken(auth.refreshToken),
      SecureStorage.saveUser(auth.user.toJson()),
    ]);

    return auth;
  }

  // ── Logout ───────────────────────────────────────────────────
  static Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
    } catch (_) {
      // On efface le storage même si l'appel échoue
    } finally {
      await SecureStorage.clearAuth();
    }
  }

  // ── Refresh ──────────────────────────────────────────────────
  static Future<String?> refreshToken() async {
    final rt = await SecureStorage.getRefreshToken();
    if (rt == null) return null;
    try {
      final res = await _dio.post(ApiConstants.refresh, data: {'refreshToken': rt});
      final token = res.data['data']['accessToken'] as String;
      await SecureStorage.saveAccessToken(token);
      return token;
    } catch (_) {
      await SecureStorage.clearAuth();
      return null;
    }
  }

  // ── Vérifier si connecté ─────────────────────────────────────
  static Future<bool> isLoggedIn() async {
    final token = await SecureStorage.getAccessToken();
    return token != null;
  }

  // ── Récupérer l'utilisateur stocké ───────────────────────────
  static Future<Map<String, dynamic>?> getStoredUser() =>
      SecureStorage.getUser();

  // ── Sites (public – pour le dropdown login) ──────────────────
  static Future<List<SiteModel>> getSites() async {
    final res = await _dio.get(ApiConstants.sites);
    final list = res.data['data'] as List<dynamic>;
    return list
        .map((e) => SiteModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
