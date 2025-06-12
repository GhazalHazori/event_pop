import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/textform.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/sign_in_view/sign_in_controller.dart';
import 'package:flutter_templat/ui/views/sign_up_secondry/sign_up_secondry_view.dart';
import 'package:flutter_templat/ui/views/sign_up_view/sign_up_view_controller.dart' show SignUpViewController;
import 'package:flutter_templat/ui/views/verfication_view/verfication_view.dart';
import 'package:get/get.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    SignUpViewController controller=Get.put(SignUpViewController());
     bool isButtonEnabled = true; 
    return  SafeArea(child: Scaffold(body: ListView(children: [screenHeight(30).ph,
   Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
      child: SvgPicture.asset("assets/images/back.svg"),
    ),
    SizedBox(height: screenHeight(40)),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
      child: Text(
        "Sign UP",
        style: TextStyle(
          color: AppColors.blacktext,
          fontSize: screenWidth(20),
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ],
), screenHeight(90).ph,
      TextForm(hinttext: "Full name", textfieldhintcolor: AppColors.secondryWhite, texteditingcontroller: controller.fullName,prefixIcon: Icon(Icons.person,color: AppColors.secondryWhite,),),screenHeight(20).ph,
            TextForm(hinttext: "abc@email.com", textfieldhintcolor: AppColors.secondryWhite, texteditingcontroller: controller.emailController,prefixIcon: Icon(Icons.email,color: AppColors.secondryWhite,),),
      screenHeight(20).ph,TextForm(hinttext: "Your password", textfieldhintcolor: AppColors.secondryWhite, texteditingcontroller: controller.password,prefixIcon: Icon(Icons.lock_outline,color: AppColors.secondryWhite,),
      suffixIcon: Icon(Icons.visibility_off,color: AppColors.secondryWhite,),),
       screenHeight(20).ph,TextForm(hinttext: "Confirm password", textfieldhintcolor: AppColors.secondryWhite, texteditingcontroller: controller.confirmpassword,prefixIcon: Icon(Icons.lock_outline,color: AppColors.secondryWhite,),
      suffixIcon: Icon(Icons.visibility_off,color: AppColors.secondryWhite,),),
       screenHeight(20).ph,TextForm(hinttext: "your phone number", textfieldhintcolor: AppColors.secondryWhite, texteditingcontroller: controller.phone,prefixIcon: Icon(Icons.phone,color: AppColors.secondryWhite,),
      ),
      screenHeight(20).ph,
     
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: screenWidth(4)),
        child: CustomMainButton(text: "NEXT", onpressed: (){
        Get.to(SignUpSecondryView(name: controller.fullName.text,phoneNumber: controller.phone.text, password: controller.password.text, email: controller.emailController.text,));
        },svgname: "circle_arrow",backgroundcolor: AppColors.bluecolor, width: screenWidth(50), hight: screenHeight(15),),
      ),
      screenHeight(30).ph,
      Center(child: Text("OR",style: TextStyle(fontSize: screenWidth(20),color: AppColors.greySign),)),screenHeight(20).ph,

      SvgPicture.asset("assets/images/google.svg"),
      screenHeight(30).ph,
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text("Already have an account?",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20))),
        Text("Sign In",style: TextStyle(color: AppColors.bluecolor,fontSize: screenWidth(20)))
      ],)
    ],),),);
  }
}