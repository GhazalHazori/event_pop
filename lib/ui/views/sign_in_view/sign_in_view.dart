import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/core/data/models/apis/token_info.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/textform.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/reset_password_view/reset_password_view.dart';
import 'package:flutter_templat/ui/views/sign_in_view/sign_in_controller.dart';
import 'package:flutter_templat/ui/views/sign_up_view/sign_up_view.dart';
import 'package:get/get.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  bool _isPasswordHidden = true; // للتحكم في إخفاء/إظهار الباسورد
  bool _rememberMe = false;   bool _isLoading = false;
  Widget build(BuildContext context) {
    SignInController controller=Get.put(SignInController());
     bool isButtonEnabled = true; 
    return  Scaffold(backgroundColor: AppColors.whitecolor,
      resizeToAvoidBottomInset: false,
      body: Column(children: [screenHeight(20).ph,
      SvgPicture.asset("assets/images/signin_event.svg"),screenHeight(40).ph,
      SizedBox(width: screenWidth(1.11),
        child: Text("Sign in",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20),fontWeight: FontWeight.w500))),
        screenHeight(90).ph,
      TextForm(
        hinttext: "abc@email.com", textfieldhintcolor: AppColors.secondryWhite, texteditingcontroller: controller.emailController,prefixIcon: Icon(Icons.email,color: AppColors.secondryWhite,),),
      screenHeight(20).ph,
    Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
              child: TextFormField(
                controller: controller.password,
                obscureText: _isPasswordHidden,
                decoration: InputDecoration(
                  hintText: "Your password",hintStyle: TextStyle(color: AppColors.greycolor.withOpacity(0.5),fontSize: screenWidth(25),),
                  prefixIcon: Icon(Icons.lock_outlined, color: AppColors.secondryWhite),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.secondryWhite,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: AppColors.whitecolor,
                 border: OutlineInputBorder(
            
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.greySign.withOpacity(0.5))),
        
                ),
              ),
            ),
      screenHeight(20).ph,
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: screenWidth(30)),
        child: Row(children: [
              Switch(
               value: _rememberMe,
                activeColor: AppColors.bluecolor,
                inactiveThumbColor: AppColors.greySign,
                onChanged: (value) {
                   setState(() {
                        _rememberMe = value ?? false;
                      });
                },
              ),
              Text(" Remember Me",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(25))),
              screenWidth(4).pw,
             InkWell(onTap: (){
             Get.to(ResetPasswordView());
             },
               child: Text(
                 "Forgot password?",
                 style: TextStyle(
                   color: AppColors.bluecolor,
                   decoration: TextDecoration.underline,decorationColor: AppColors.bluecolor,decorationThickness:2,
                   fontWeight: FontWeight.w500,
                   height:1, // ⬅️ هذا بيعمل مسافة إضافية بين السطر والنص
                 ),
               ),
             ),
    ],),
      ),
      screenHeight(20).ph,
  _isLoading
      ? Column(
          children: [
            // لودر Lottie (إذا عندك ملف JSON)
          SizedBox(
              height: screenHeight(15),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "wait ...",
              style: TextStyle(color: Colors.grey),
            )
          ],
        )
      : CustomMainButton(
          text: "Sign In",
        onpressed: (){
      controller.login(email: controller.emailController.text, password: controller.password.text,fcmToken: storage.getFcmToken(),);
      if (_rememberMe) {
    // مثال: تخزين البيانات باستخدام GetStorage
  
  } else {
    // إذا المستخدم ما بده Remember Me نمسح البيانات
   storage.setTokenInfo(TokenInfo(accessToken: null));
  }
        },
          svgname: "circle_arrow",
          backgroundcolor: AppColors.bluecolor,
          width: screenWidth(1.11),
          hight: screenHeight(15),
        ),
      screenHeight(20).ph,
      Text("OR",style: TextStyle(fontSize: screenWidth(20),color: AppColors.greySign),),screenHeight(20).ph,
    
      InkWell(onTap: (){
        controller.loginWithGoogle();
      },
        child: SvgPicture.asset("assets/images/google.svg")),
      screenHeight(20).ph,
      SizedBox(width: screenWidth(1.6),
        child: Expanded(
          child: Row(children: [
            Text("Don’t have an account?  ",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20))),
            InkWell(
              onTap: (){
                Get.to(SignUpView());
              },
              child: Text("Sign UP",style: TextStyle(color: AppColors.bluecolor,fontSize: screenWidth(20))))
          ],),
        ),
      )
    ],),);
  }
  
}