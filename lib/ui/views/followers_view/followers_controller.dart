import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:get/get.dart';

class FollowersController extends BaseControoler {
  final RxList<Map<String, String>> allFollowers = <Map<String, String>>[
    {"name": "John Doe", "subtitle": "Following you"},
    {"name": "Jane Smith", "subtitle": "Following you"},
    {"name": "Ali Hassan", "subtitle": "New follower"},
    {"name": "Fatima Noor", "subtitle": "Following you"},
  ].obs;

  RxString searchText = ''.obs;

  RxList<Map<String, String>> get filteredFollowers {
    if (searchText.value.isEmpty) {
      return allFollowers;
    } else {
      return allFollowers
          .where((f) =>
              f["name"]!.toLowerCase().contains(searchText.value.toLowerCase()))
          .toList()
          .obs;
    }
  }

  void updateSearchText(String value) {
    searchText.value = value;
  }
}
