import 'package:flutter/cupertino.dart';
import 'package:flutter_templat/core/data/repositories/user_repository.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:flutter_templat/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignInController  extends BaseControoler{
  TextEditingController emailController=TextEditingController();
  TextEditingController password =TextEditingController();
  
  void login({required String email,required String password}) {
    runFullLoadingFunction(
      function: UserRepository()
          .login(
          
            email: email,
            password: password,
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
                storage.setTokenInfo(r);
                Get.to(MainView());
              },
            ),
          ),
    );
  }
}