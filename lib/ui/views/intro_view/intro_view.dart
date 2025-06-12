
import 'dart:ui';

import 'package:dots_indicator/dots_indicator.dart' show DotsDecorator, DotsIndicator;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custombutton_ger.dart' show CustomButtonGer;
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/intro_view/intro_view_controller.dart';
import 'package:flutter_templat/ui/views/sign_in_view/sign_in_view.dart';
import 'package:flutter_templat/ui/views/splash_screen/splash_screen_view.dart';

import 'package:get/get.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final IntroController controller = Get.put(IntroController());

  List<String> descriptionList = [
    " Explore Upcoming and Nearby\n Events ",
    " Web Have Modern Events \n Calendar Featur",
    "  To Look Up More Events or \n Activities Nearby By Map"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
            alignment: AlignmentDirectional.bottomEnd,
        children: [
         
  Align(alignment: Alignment(0, -0.8),
    child: Image.asset( 'assets/images/intro2.png',
        height: screenHeight(1.5),
      
          fit: BoxFit.cover,),
  ),
     
          Stack(
            children: [
              Obx(() {
                if (controller.currentIndex.value == 0) {
                  return Container(
                    width: double.infinity,
                    height: screenHeight(3.5),
                    decoration: ShapeDecoration(
color: AppColors.bluecolor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only( topLeft:  Radius.circular(50),topRight: Radius.circular(50) ),
                      ),
                    ),
                  );
                } else if (controller.currentIndex.value == 1) {
                  return Container(

                    width: double.infinity,
                height: screenHeight(3.5),
                    decoration: ShapeDecoration(
                   color: AppColors.bluecolor,
                   
                      shape: RoundedRectangleBorder(     borderRadius:
                            BorderRadius.only( topLeft:  Radius.circular(50),topRight: Radius.circular(50) ),),
                    ),
                  );
                } else if (controller.currentIndex.value == 2) {
                  return Container(
                    width: double.infinity,
                  height: screenHeight(3),
                    decoration: ShapeDecoration(
                     color: AppColors.bluecolor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topLeft:  Radius.circular(50),topRight: Radius.circular(50) ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              Positioned(
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    60.ph,
                 Obx(()=>   Text(descriptionList[controller.currentIndex.value],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: screenWidth(15), color: Colors.white,fontFamily: "Building Better Work")),)
                         , 50.ph,
                         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                            InkWell(
                              onTap: (){
                                  Get.back();
                              },
                              child: Text("SKip",style: TextStyle(color: AppColors.secondryWhite,fontSize: screenWidth(20)),))
,                             Obx(
                                         () => DotsIndicator(
                                           dotsCount: 3,
                                           position: controller.currentIndex.value.toDouble(),
                                           decorator: DotsDecorator(
                                               size: Size(10, 10),
                                               activeSize: Size(10, 10),
                                               color: AppColors.secondryWhite,
                                               activeColor: AppColors.whitecolor),
                                         ),
                                       ), InkWell(onTap:(){
                                            if (!controller.isLastIndex()) {
                                      controller.incrementIndex();
                                    } else {
                                      Get.to(SignInView());
                                    }
                                       }, child: Text("Next",style: TextStyle(color: AppColors.whitecolor,fontSize: screenWidth(20))))
                           ],
                         ),
            
                  
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}