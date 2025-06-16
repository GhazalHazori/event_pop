import 'package:flutter_templat/core/data/models/category_model.dart';
import 'package:flutter_templat/core/data/models/up_coming_event.dart';
import 'package:flutter_templat/core/data/repositories/event_repository.dart';
import 'package:flutter_templat/core/enums/operation_type.dart' show OperationType;
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:get/get.dart';

class ExploreViewController extends BaseControoler{
  List<String>location=[];
   List<CategoryModel>intrestList=[CategoryModel(id:1,name: "Sports",logo: "sports"),
  CategoryModel(id: 2,name: "Arts",logo: "arts"),CategoryModel(id: 3,name: "Music",logo: "music")];
    var selectedInterests = <String>{}.obs;@override
  void onInit() {
  getUpComingEvent();
    super.onInit();
  }
    RxString selectedTime = ''.obs;

  void selectTime(String time) {
    selectedTime.value = time;
  }

  void toggleInterest(String name) {
    if (selectedInterests.contains(name)) {
      selectedInterests.remove(name);
    } else {
      selectedInterests.add(name);
    }
  }  final minPrice = 20.0.obs;
  final maxPrice = 120.0.obs;
final isPressed = false.obs;
  RxBool isActive = false.obs;
  
  void toggleButton() {
    isPressed.toggle();
    // يمكنك إضافة أي منطق إضافي هنا عند الضغط
  }
  void setPriceRange(double min, double max) {
    minPrice.value = min;
    maxPrice.value = max;
  }
    List<CategoryModel>intrestListFilter=[CategoryModel(id:1,name: "Sports",logo: "sports"),
  CategoryModel(id: 2,name: "Arts",logo: "arts"),CategoryModel(id: 3,name: "Music",logo: "music")];
    var selectedInterestsFilter = <String>['sport'].obs;
    void toggleInterestFilter(String name) {
    if (selectedInterests.contains(name)) {
      selectedInterestsFilter.remove(name);
    } else {
      selectedInterestsFilter.add(name);
    }
  }List<String> selectedTimes = []; // بدلاً من String?
  var selectedLocations = <String>[].obs;
 final List<String> locations = ["Homs", "Aleppo", "Damascus"];
  void toggleSelection(String location) {
    if (selectedLocations.contains(location)) {
      selectedLocations.remove(location);
    } else {
      selectedLocations.add(location);
    }
  } RxBool isloading = true.obs;
   RxList<UpComingEventModel> eventUpcominList = <UpComingEventModel>[].obs;
  Future<void> getUpComingEvent(
  ) async {
    runLoadingFutureFunction(
        type: OperationType.UPCOMING,
        function: EventRepository()
            .getUpComingEvent(
             )
            .then((value) {
          value.fold((l) {
            // CustomToast.showMessage(
            //     message: l, messagetype: MessagType.REJECTED);
          }, (r) {
            // CustomToast.showMessage(
            //     message: "succed", messagetype: MessagType.SUCCSESS);
            isloading.value = false;
         
            eventUpcominList.addAll(r);

            //  print(stateName);
          });
        }));
  }

  bool isSelected(String name) => selectedInterests.contains(name);
}