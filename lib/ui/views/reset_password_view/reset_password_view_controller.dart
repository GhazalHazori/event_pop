import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_templat/core/data/repositories/user_repository.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:flutter_templat/ui/views/verify_otp_reset/verify_otp_reset_view.dart';
import 'package:get/get.dart';

class ResetPasswordViewController extends BaseControoler{
  TextEditingController emailController=TextEditingController();
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
                Get.to(VerifyOtpResetView(email: email,));
              },
            ),
          ),
    );
  }


}