import 'package:flutter_templat/core/data/network/network_config.dart';

class ProfileEndPoints {
  static String getProfile = NetworkConfig.getFullApiRoute('profile/');
  static String editAboutme = NetworkConfig.getFullApiRoute('profile/edit/');
  static String geteventforuser =
      NetworkConfig.getFullApiRoute('event/userEvent/');
}
