import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/splash_screen/splash_screen_controller.dart';
import 'package:lottie/lottie.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  SplashScreenController controller = Get.put(SplashScreenController());
  //late BuildContext mycontext;
  @override
  // void initState() {
  //   Future.delayed(Duration(seconds: 5)).then((value) {
  //     if (SharedPrefrenceRepository.getFirstLunch()) {
  //       Get.off(IntroView);
  //     } else {
  //       return SharedPrefrenceRepository.getLogeedIn()
  //           ? Get.off(MainView)
  //           : Get.off(LandingView);
  //     }

  //     SharedPrefrenceRepository.setFirstLunch(false);
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //mycontext = context;
    return SafeArea(
        child: Scaffold(
      body: Column(
   mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Center(
             child: Image.asset(
               'assets/images/animationgif.gif',
               width: 200,
               height: 200,
               fit: BoxFit.contain,
             ),
           )
        ],
      ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          // child: Container(
          //   margin: EdgeInsets.only(bottom: size.width * 0.40),
          //   width: size.width * 0.1,
          //   height: size.width * 0.1,
          //   child: CircularProgressIndicator(
          //     color: AppColors.mainorangecolor,
          //   ),
          // ),

          // )
       
        
      ),
    );
  }
}
