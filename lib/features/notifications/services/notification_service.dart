import '../../../core/network/api_client.dart';
import '../../../core/constants/api_constants.dart';
import '../../../shared/models/notification_model.dart';

class NotificationService {
  NotificationService._();

  static final _dio = ApiClient.instance;

  static Future<List<NotificationModel>> getNotifications({
    bool? read,
    int page = 1,
  }) async {
    final res = await _dio.get(
      ApiConstants.notifications,
      queryParameters: {
        'page': page,
        if (read != null) 'read': read,
      },
    );
    final list = res.data['data'] as List<dynamic>;
    return list
        .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<int> getUnreadCount() async {
    final res = await _dio.get(
      ApiConstants.notifications,
      queryParameters: {'read': false, 'limit': 1},
    );
    return res.data['data']?['unread_count'] as int? ?? 0;
  }

  static Future<void> markRead(int id) async {
    await _dio.patch(ApiConstants.notificationRead(id));
  }

  static Future<void> markAllRead() async {
    await _dio.patch(ApiConstants.notificationsReadAll);
  }

  static Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.notificationById(id));
  }

  static Future<void> saveFcmToken(String token) async {
    await _dio.post(ApiConstants.notificationsFcm, data: {'fcm_token': token});
  }
}
