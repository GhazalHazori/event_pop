import 'package:flutter_templat/core/data/network/network_config.dart';

class NotificationEndPoints {
  static String notification =
      NetworkConfig.getFullApiRoute('/notification/all/{userId}');

  static String getNotificationUrl(String userId) {
    return NetworkConfig.getFullApiRoute('notification/all/$userId');
  }

  // Follow endpoints
  static String follow = NetworkConfig.getFullApiRoute('follow');
  static String notificationaccept =
      NetworkConfig.getFullApiRoute('follow/accepte/');
  static String notificationreject =
      NetworkConfig.getFullApiRoute('follow/reject/');
}
