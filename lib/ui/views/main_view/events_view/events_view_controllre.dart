import 'package:flutter_templat/core/data/models/category_model.dart';
import 'package:flutter_templat/core/data/models/past_event_model.dart';
import 'package:flutter_templat/core/data/models/up_coming_event.dart';
import 'package:flutter_templat/core/data/repositories/event_repository.dart';
import 'package:flutter_templat/core/enums/operation_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:get/get.dart';

class EventsViewControllre  extends BaseControoler{
  var currentTab = 0.obs;
  var upcomingEvents = <Event>[].obs;
  var pastEvents = <Event>[].obs;
  var isLoadingUpcoming = false.obs;
  var isLoadingPast = false.obs;

  @override
  void onInit() {
    fetchUpcomingEvents();
    // getUpComingEvent();
    getPastEvent();
    super.onInit();
  }

  void changeTab(int index) {
    currentTab.value = index;
    if (index == 0 && upcomingEvents.isEmpty) {
      fetchUpcomingEvents();
    } else if (index == 1 && pastEvents.isEmpty) {
      fetchPastEvents();
    }
  }

  void fetchUpcomingEvents() async {
    isLoadingUpcoming.value = true;
    await Future.delayed(Duration(seconds: 1)); // محاكاة طلب API
    upcomingEvents.assignAll([
      Event("Event 1", "2023-12-01"),
      Event("Event 2", "2023-12-15"),
    ]);
    isLoadingUpcoming.value = false;
  }


  void fetchPastEvents() async {
    isLoadingPast.value = true;
    await Future.delayed(Duration(seconds: 1)); // محاكاة طلب API
    pastEvents.assignAll([
      Event("Past Event 1", "2023-11-10"),
      Event("Past Event 2", "2023-10-20"),
    ]);
    isLoadingPast.value = false;
  }
     List<CategoryModel>intrestList=[CategoryModel(id:1,name: "Sports",logo: "sports"),
  CategoryModel(id: 2,name: "Arts",logo: "arts"),CategoryModel(id: 3,name: "Music",logo: "music")];
    var selectedInterests = <String>{}.obs;@override
     void toggleInterest(String name) {
    if (selectedInterests.contains(name)) {
      selectedInterests.remove(name);
    } else {
      selectedInterests.add(name);
    }
  } 
RxBool isloading = true.obs;
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
  RxList<PastEventModel> eventPastList = <PastEventModel>[].obs;
  Future<void> getPastEvent(
  ) async {
    runLoadingFutureFunction(
        type: OperationType.UPCOMING,
        function: EventRepository()
            .getPastEvent(
             )
            .then((value) {
          value.fold((l) {
            // CustomToast.showMessage(
            //     message: l, messagetype: MessagType.REJECTED);
          }, (r) {
            // CustomToast.showMessage(
            //     message: "succed", messagetype: MessagType.SUCCSESS);
            isloading.value = false;
         
            eventPastList.addAll(r);

            //  print(stateName);
          });
        }));
  }

}
class Event {
  final String title;
  final String date;

  Event(this.title, this.date);
}