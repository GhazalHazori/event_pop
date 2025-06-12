import 'package:flutter_templat/core/data/models/category_model.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:get/get.dart';

class ExploreViewController extends BaseControoler{
  List<String>location=[];
   List<CategoryModel>intrestList=[CategoryModel(id:1,name: "Sports",logo: "sports"),
  CategoryModel(id: 2,name: "Arts",logo: "arts"),CategoryModel(id: 3,name: "Music",logo: "music")];
    var selectedInterests = <String>{}.obs;

  void toggleInterest(String name) {
    if (selectedInterests.contains(name)) {
      selectedInterests.remove(name);
    } else {
      selectedInterests.add(name);
    }
  }

  bool isSelected(String name) => selectedInterests.contains(name);
}