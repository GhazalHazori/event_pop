import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart' show CustomMainButton;
import 'package:flutter_templat/ui/shared/custom_widgets/textform.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/change_password_view/change_password_view.dart';
import 'package:flutter_templat/ui/views/reset_password_view/reset_password_view_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResetPasswordViewController controller=Get.put(ResetPasswordViewController());
    return  Scaffold(body: Column(children: [
      screenHeight(20).ph,
    
        Align(alignment: AlignmentDirectional.topStart,
          child: SizedBox(   width: screenWidth(6),child: SvgPicture.asset("assets/images/back.svg",))),
        screenHeight(40).ph,
      SizedBox(width: screenWidth(1.11),
        child: Text("Resset Password",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(15),fontWeight: FontWeight.w400))),
        screenHeight(30).ph,
         SizedBox(width: screenWidth(1.11),
        child: Text("Please enter your email address to request a password reset",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20),fontWeight: FontWeight.w400))),
        screenHeight(30).ph,
         
      TextForm(hinttext: "abc@email.com", textfieldhintcolor: AppColors.secondryWhite, texteditingcontroller: controller.email,prefixIcon: Icon(Icons.email,color: AppColors.secondryWhite,),),
      screenHeight(10).ph,
         CustomMainButton(text: "SEND", onpressed: (){
    Get.to(ChangePasswordView());
      },svgname: "circle_arrow",backgroundcolor: AppColors.bluecolor, width: screenWidth(2), hight: screenHeight(13),),
    ],),);
  }
}