import 'package:flutter_templat/core/data/network/network_config.dart';

class EventEndpoints {
  static String getAllevent = NetworkConfig.getFullApiRoute('event');
  static String getUpcomingevent =
      NetworkConfig.getFullApiRoute('event/upcomingEvent');
  static String getPastEvent = NetworkConfig.getFullApiRoute('event/pastEvent');
  static String nearlyEvent =
      NetworkConfig.getFullApiRoute('event/userLocation');
  static String geteventbyid = NetworkConfig.getFullApiRoute('event/oneEvent/');
  static String saveEvent = NetworkConfig.getFullApiRoute('profile/save/');
  static String getSavedEvent =
      NetworkConfig.getFullApiRoute('profile/savedEvents/');
  static String getmapevent = NetworkConfig.getFullApiRoute('event/map');
}
