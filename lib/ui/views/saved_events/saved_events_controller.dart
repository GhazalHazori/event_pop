import 'package:flutter_templat/core/data/models/saved_event_model.dart';
import 'package:flutter_templat/core/data/repositories/event_repository.dart';
import 'package:flutter_templat/core/enums/operation_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class SavedEventsViewController extends BaseControoler{
   RxList<SavedEventModel> eventsList = <SavedEventModel>[].obs;
   RxBool isloading = true.obs;
     @override
  void onInit() {
 getAllEvent(id: storage.getUserId());
   
    super.onInit();
  }

  Future<void> getAllEvent({required String id}
  ) async {
    runLoadingFutureFunction(
        type: OperationType.UPCOMING,
        function: EventRepository()
            .getSavedEvent(id:id
             )
            .then((value) {
          value.fold((l) {
            // CustomToast.showMessage(
            //     message: l, messagetype: MessagType.REJECTED);
          }, (r) {
            // CustomToast.showMessage(
            //     message: "succed", messagetype: MessagType.SUCCSESS);
            isloading.value = false;
         
            eventsList.addAll(r);

            //  print(stateName);
          });
        }));
  }
}