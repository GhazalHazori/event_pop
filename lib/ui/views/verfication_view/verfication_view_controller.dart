import 'package:flutter/material.dart' show TextEditingController;
import 'package:flutter_templat/core/data/repositories/user_repository.dart' show UserRepository;
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart' show CustomToast;
import 'package:flutter_templat/ui/views/sign_in_view/sign_in_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart' show RxInt, IntExtension;

class VerficationViewController  extends BaseControoler{ RxInt activeColor = 0.obs;
  TextEditingController controllerCode = TextEditingController();
  String email='';
  VerficationViewController(email){
email=email;
  }
  OnChangedCode(String value) {
    if (value == controllerCode.text) {
      print("Verification successful");
    } else {
      print("Verification failed");
    }

    print(value);
  }
//  void resendCode() {
//     runFullLoadingFunction(
//       function: ResendCodeRepository().getCode
//           (
           
//           )
//           .then(
//             (value) => value.fold(
//               (l) {
//                 CustomToast.showMessage(
//                   messagetype: MessagType.REJECTED,
//                   message: l,
//                 );
//               },
//               (r) {
//                 CustomToast.showMessage(
//                   messagetype: MessagType.SUCCSESS,
//                   message: r,
//                 );
              
//               },
//             ),
//           ),
//     );
//   }

void verfiy({required String code,required String email}) {
    runFullLoadingFunction(
      function: UserRepository()
          .verify(
            otpNum: code, email: email
          )
          .then(
            (value) => value.fold(
              (l) {
                CustomToast.showMessage(
                  messageType: MessagType.REJECTED,
                  message: l,
                );
              },
              (r) {
                CustomToast.showMessage(
                  messageType: MessagType.SUCCSESS,
                  message: r,
                );
              Get.to(SignInView());
              },
            ),
          ),
    );
  }
}