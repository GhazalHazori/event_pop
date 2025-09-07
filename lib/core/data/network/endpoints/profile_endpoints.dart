import 'package:flutter_templat/core/data/network/network_config.dart';

class ProfileEndPoints {
  static String getProfile = NetworkConfig.getFullApiRoute('profile/');
  static String editAboutme = NetworkConfig.getFullApiRoute('profile/edit/');
  static String geteventforuser =
      NetworkConfig.getFullApiRoute('event/userEvent/');
  static String getinterestforuser =
      NetworkConfig.getFullApiRoute('profile/interests/');
  static String updateinterestforuser =
      NetworkConfig.getFullApiRoute('profile/edit/interests/');
  static String getallinterests = NetworkConfig.getFullApiRoute('interest');
  static String getallfollowings =
      NetworkConfig.getFullApiRoute('profile/followings/');
  static String getallfollowers =
      NetworkConfig.getFullApiRoute('profile/followers/');
}
