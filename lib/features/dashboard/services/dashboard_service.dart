import '../../../core/network/api_client.dart';
import '../../../core/constants/api_constants.dart';
import '../../../shared/models/movement_model.dart';
import '../models/dashboard_model.dart';

class DashboardService {
  DashboardService._();

  static final _dio = ApiClient.instance;

  static Future<DashboardStats> getDashboard({int? siteId}) async {
    final res = await _dio.get(
      ApiConstants.reportDashboard,
      queryParameters: siteId != null ? {'site_id': siteId} : null,
    );
    return DashboardStats.fromJson(res.data['data'] as Map<String, dynamic>);
  }

  static Future<List<AlertProduct>> getAlerts({int? siteId}) async {
    final res = await _dio.get(
      ApiConstants.reportAlerts,
      queryParameters: siteId != null ? {'site_id': siteId} : null,
    );
    final list = res.data['data'] as List<dynamic>;
    return list
        .map((e) => AlertProduct.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<List<MovementModel>> getRecentMovements({int? siteId}) async {
    final res = await _dio.get(
      ApiConstants.movements,
      queryParameters: {
        'limit': 5,
        'page':  1,
        if (siteId != null) 'site_id': siteId,
      },
    );
    final list = res.data['data'] as List<dynamic>;
    return list
        .map((e) => MovementModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<List<SiteStockSummary>> getSitesStock() async {
    final res = await _dio.get('/reports/sites/stock');
    final list = res.data['data'] as List<dynamic>;
    return list
        .map((e) => SiteStockSummary.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
