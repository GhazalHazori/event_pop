import 'package:flutter/widgets.dart';
import 'package:flutter_templat/core/data/repositories/user_repository.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:flutter_templat/ui/views/sign_in_view/sign_in_view.dart';
import 'package:get/get.dart';

class ChangePasswordViewController extends BaseControoler {
  String proof = '';
  String email = '';
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  ChangePasswordViewController(String proof, String email) {
    this.proof = proof;
    this.email = email;
  }

  void resetPassword(
      {required String newpassword,
      required String email,
      required String id}) {
    runFullLoadingFunction(
      function: UserRepository()
          .resetPassword(email: email, id: id, newpassword: newpassword)
          .then(
            (value) => value.fold((l) {
              CustomToast.showMessage(
                messageType: MessagType.REJECTED,
                message: l,
              );
            }, (r) {
              CustomToast.showMessage(
                messageType: MessagType.SUCCSESS,
                message: r,
              );
              Get.to(SignInView());
            }),
          ),
    );
  }
}
