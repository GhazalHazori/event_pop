import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_templat/core/data/models/apis/token_info.dart';
import 'package:flutter_templat/core/data/repositories/user_repository.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:flutter_templat/ui/views/main_view/main_view.dart';
import 'package:flutter_templat/ui/views/verify_otp_reset/verify_otp_reset_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../../core/data/models/event_details_model.dart' hide User;

class SignInController extends BaseControoler {
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void onInit() {
//  loginn();
    super.onInit();
  }

  void login(
      {required String email,
      required String password,
      required String fcmToken}) {
    runFullLoadingFunction(
      function: UserRepository()
          .login(email: email, password: password, fcmToken: fcmToken)
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
                print(storage.setTokenInfo(r));
                Get.to(MainView());
              },
            ),
          ),
    );
  }

  final googleSignIn = GoogleSignIn.instance;

  Future<void> loginWithGoogle() async {
    await googleSignIn.initialize(
      clientId:
          "489480264988-d4km0ppqd8k4nh7jl82naon86jq1077b.apps.googleusercontent.com",
    );

    final account = await googleSignIn.authenticate(scopeHint: ['email']);
    if (account == null) return;

    final auth = await account.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: auth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    storage.setTokenInfo(TokenInfo(accessToken: auth.idToken));
    Get.to(MainView());
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.back(); // navigate to your wanted page after logout.
  }

  Future<void> loginn() async {
    try {
      final response = await http.post(
        Uri.parse('https://tasstore.onrender.com/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'email': "semayali2381@gmail.com", 'password': "Sema225??"}),
      );
      print(
        '*response.statusCode: ${response.statusCode}, email: ${emailController.text}',
      );
      print('Response body: ${response.body}'); // طباعة محتوى الاستجابة

      if (response.statusCode == 200) {
        Get.snackbar('نجاح', 'تم تسجيل الدخول بنجاح');
        // Get.offAll(() => HomeView());
      } else {
        Get.snackbar('خطأ', 'بيانات الدخول غير صحيحة');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء الاتصال');
      print('EEEEEERRROOORR: $e');
    } finally {}
  }
}
