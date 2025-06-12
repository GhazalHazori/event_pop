import 'package:flutter_templat/core/data/network/network_config.dart';

class UserEndPoints {
  static String register = NetworkConfig.getFullApiRoute('auth/register');
  static String verify = NetworkConfig.getFullApiRoute('auth/verify');
  static String login = NetworkConfig.getFullApiRoute('auth/login');
}
