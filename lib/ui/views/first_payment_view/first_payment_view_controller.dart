import 'package:flutter/widgets.dart';
import 'package:flutter_templat/core/data/models/client_model.dart';
import 'package:flutter_templat/core/data/repositories/payment_repository.dart';
import 'package:flutter_templat/core/enums/operation_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../card_payment_view/card_payment_view.dart';

class FirstPaymentViewController  extends BaseControoler{
  String idEvent='';
  FirstPaymentViewController(String id){
idEvent=id;
  }
  TextEditingController seatscontroller =TextEditingController();
 Rx<Clientmodel> clientPayment = Clientmodel().obs;
   RxBool isloading = true.obs;
  Future<void> creatPayment({required String id,required String seats}
  ) async {
    runLoadingFutureFunction(
        type: OperationType.UPCOMING,
        function: PaymentRepository()
            .creatPayment(eventId: id,seats: seats
             )
            .then((value) {
          value.fold((l) {
            // CustomToast.showMessage(
            //     message: l, messagetype: MessagType.REJECTED);
          }, (r) {
            // CustomToast.showMessage(
            //     message: "succed", messagetype: MessagType.SUCCSESS);
            isloading.value = false;
         
            clientPayment.value=r;
            storage.setpayment(clientPayment.value.clientSecret??'');
  Get.to(PaymentScreen());
            //  print(stateName);
          });
        }));
  }
}