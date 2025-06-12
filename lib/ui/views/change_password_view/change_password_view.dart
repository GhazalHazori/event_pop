import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/textform.dart';
import 'package:flutter_templat/ui/shared/utlis.dart' show screenWidth, screenHeight;
import 'package:flutter_templat/ui/views/change_password_view/changE_password_view_controller.dart';
import 'package:get/get.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    ChangePasswordViewController controller=Get.put(ChangePasswordViewController());
    return  SafeArea(child: Scaffold(body: Column(children: [  SizedBox(width: screenWidth(1.11),child: SvgPicture.asset("assets/images/back.svg")),screenHeight(40).ph,
      SizedBox(width: screenWidth(1.11),
        child: Text("Resset Password",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20),fontWeight: FontWeight.bold))),
        screenHeight(90).ph,
          SizedBox(width: screenWidth(1.11),
        child: Text("Enter your new password ",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20),))),
        screenHeight(50).ph,
          TextForm(hinttext: "your password", textfieldhintcolor: AppColors.secondryWhite, texteditingcontroller: controller.password,prefixIcon: Icon(Icons.lock_outline,color: AppColors.secondryWhite,),suffixIcon: Icon(Icons.visibility_off),),
      screenHeight(20).ph,
       TextForm(suffixIcon: Icon(Icons.visibility_off),
        hinttext: "confirm password", textfieldhintcolor: AppColors.secondryWhite, texteditingcontroller: controller.password,prefixIcon: Icon(Icons.lock_outline,color: AppColors.secondryWhite,),),
      screenHeight(20).ph,
       CustomMainButton(text: "RESET", onpressed: (){

      },svgname: "circle_arrow",backgroundcolor: AppColors.bluecolor, width: 0, hight: 0,),
      screenHeight(20).ph,
        ],
        ),
        ),);
  }
}