import 'package:flutter_templat/core/data/network/network_config.dart';

class EventEndpoints {
  static String getAllevent = NetworkConfig.getFullApiRoute('event');
  static String getUpcomingevent = NetworkConfig.getFullApiRoute('event/upcomingEvent');
  static String getPastEvent = NetworkConfig.getFullApiRoute('event/pastEvent');
  
}
