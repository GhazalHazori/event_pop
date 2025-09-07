import 'package:flutter_templat/core/data/models/event_details_model.dart';
import 'package:flutter_templat/core/data/repositories/event_repository.dart';
import 'package:flutter_templat/core/enums/operation_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:get/get.dart';

class EventdetailsControllre extends BaseControoler{
  String idEvent='';
  EventdetailsControllre(String id){
idEvent=id;
  }
   @override
  void onInit() {
getDetailsEvent(id:idEvent );
    super.onInit();
  }

   Rx<Eventdetailsmodel> eventdetails = Eventdetailsmodel().obs;
   RxBool isloading = true.obs;
  Future<void> getDetailsEvent({required String id}
  ) async {
    runLoadingFutureFunction(
        type: OperationType.UPCOMING,
        function: EventRepository()
            .geteventById(id: id
             )
            .then((value) {
          value.fold((l) {
            // CustomToast.showMessage(
            //     message: l, messagetype: MessagType.REJECTED);
          }, (r) {
            // CustomToast.showMessage(
            //     message: "succed", messagetype: MessagType.SUCCSESS);
            isloading.value = false;
         
            eventdetails.value=r;

            //  print(stateName);
          });
        }));
  }
}