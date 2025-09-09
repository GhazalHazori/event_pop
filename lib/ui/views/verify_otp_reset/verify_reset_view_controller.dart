import 'package:flutter/widgets.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/ui/views/change_password_view/change_password_view.dart';
import 'package:flutter_templat/ui/views/reset_password_view/reset_password_view.dart';
import 'package:get/get.dart';

import '../../../core/data/repositories/user_repository.dart';
import '../../shared/custom_widgets/custom_toast.dart';

class VerifyResetViewController extends BaseControoler{
  String email='';
  VerifyResetViewController(String email){
    this.email=email;
  }RxInt activeColor = 0.obs;
  TextEditingController controllerCode = TextEditingController();
   OnChangedCode(String value) {
    if (value == controllerCode.text) {
      print("Verification successful");
    } else {
      print("Verification failed");
    }

    print(value);
  }
  void verfiy({required String code,required String email}) {
    runFullLoadingFunction(
      function: UserRepository()
          .verifyOtpReset(
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
              Get.to(ChangePasswordView(proof: r,email: email,));
              },
            ),
          ),
    );
  }
   void requestReset({required String email}) {
    runFullLoadingFunction(
      function: UserRepository()
          .sendOtpToEmail(
          
            email: email,
         
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
                  message: "Succed",
                );
                // Get.to(VerifyOtpResetView(email: email,));
              },
            ),
          ),
    );
  }

}