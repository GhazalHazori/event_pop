import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/textform.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
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
  Widget build(BuildContext context) {
    SignInController controller=Get.put(SignInController());
     bool isButtonEnabled = true; 
    return  SafeArea(child: Scaffold(resizeToAvoidBottomInset: false,
      body: Column(children: [screenHeight(30).ph,
      SvgPicture.asset("assets/images/signin_event.svg"),screenHeight(40).ph,
      SizedBox(width: screenWidth(1.11),
        child: Text("Sign in",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20),fontWeight: FontWeight.w500))),
        screenHeight(90).ph,
      TextForm(hinttext: "abc@email.com", textfieldhintcolor: AppColors.secondryWhite, texteditingcontroller: controller.emailController,prefixIcon: Icon(Icons.email,color: AppColors.secondryWhite,),),
      screenHeight(20).ph,TextForm(hinttext: "Your password", textfieldhintcolor: AppColors.secondryWhite, texteditingcontroller: controller.password,prefixIcon: Icon(Icons.lock_outline,color: AppColors.secondryWhite,),
      suffixIcon: Icon(Icons.visibility_off,color: AppColors.secondryWhite,),),
      screenHeight(20).ph,
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: screenWidth(30)),
        child: Row(children: [
              Switch(
                value: isButtonEnabled,
                activeColor: AppColors.bluecolor,
                
                onChanged: (value) {
                  setState(() {
                    isButtonEnabled = value; // Toggle button state
                  });
                },
              ),
              Text(" Remember Me",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(25))),
              screenWidth(5).pw,
               Text("Forgot password?",style: TextStyle(color: AppColors.blacktext,)),
        ],),
      ),
      screenHeight(20).ph,
      CustomMainButton(text: "Sign In", onpressed: (){
controller.login(email: controller.emailController.text, password: controller.password.text,fcmToken: storage.getFcmToken(),);
      },svgname: "circle_arrow",backgroundcolor: AppColors.bluecolor, width: screenWidth(1.11), hight: screenHeight(15),),
      screenHeight(20).ph,
      Text("OR",style: TextStyle(fontSize: screenWidth(20),color: AppColors.greySign),),screenHeight(20).ph,

      SvgPicture.asset("assets/images/google.svg"),
      screenHeight(20).ph,
      SizedBox(width: screenWidth(1.6),
        child: Row(children: [
          Text("Don’t have an account?  ",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20))),
          InkWell(
            onTap: (){
              Get.to(SignUpView());
            },
            child: Text("Sign UP",style: TextStyle(color: AppColors.bluecolor,fontSize: screenWidth(20))))
        ],),
      )
    ],),),);
  }
  
}