// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart' as CustomFullScreenDialog;
// import 'package:flutter_templat/ui/views/main_view/explore_view/explore_view_controller.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';


// class LoginController extends GetxController {
//   ExploreViewController homeController = Get.find<ExploreViewController>();
//   @override
//   void onInit() async {
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {}

//   void login() async {
//     CustomFullScreenDialog.showDialog();
//     GoogleSignInAccount? googleSignInAccount =
//         await homeController.googleSign.signIn();
//     if (googleSignInAccount == null) {
//       CustomFullScreenDialog.cancelDialog();
//     } else {
//       GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;
//       OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken);
//       await homeController.firebaseAuth.signInWithCredential(oAuthCredential);
//       CustomFullScreenDialog.cancelDialog();
//     }
//   }
// }