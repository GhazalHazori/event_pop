import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:get/get.dart';

class FollowingController extends BaseControoler {
  final RxList<Map<String, String>> allFollowing = <Map<String, String>>[
    {"name": "Nour Alwan", "subtitle": "Artist"},
    {"name": "David Ali", "subtitle": "Tech Blogger"},
    {"name": "Hala Sami", "subtitle": "UI Designer"},
    {"name": "Mohamed Zain", "subtitle": "Traveler"},
  ].obs;

  RxString searchText = ''.obs;

  RxList<Map<String, String>> get filteredFollowing {
    if (searchText.value.isEmpty) {
      return allFollowing;
    } else {
      return allFollowing
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
