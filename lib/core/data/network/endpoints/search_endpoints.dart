import 'package:flutter_templat/core/data/network/network_config.dart';

class SearchEndpoints {
  static String search = NetworkConfig.getFullApiRoute('search/name');
static String filter = NetworkConfig.getFullApiRoute('search/filter');
  
}
