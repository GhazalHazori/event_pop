import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/main_view/explore_view/explore_view_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_templat/ui/views/sign_up_secondry/sign_up_secondary_view_controller.dart';

class CustomInterestExplore extends StatelessWidget {
  const CustomInterestExplore({
    super.key,
    required this.svgname,
    required this.interestname, required this.colorintrest,
  });

  final String svgname;
  final Color colorintrest;
  
  final String interestname;

  @override
  Widget build(BuildContext context) {
   ExploreViewController controller=Get.put(ExploreViewController());

    return Obx(() {
      final isSelected = controller.isSelected(interestname);

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: screenWidth(4),
      
        decoration: BoxDecoration(
          color: colorintrest,
        borderRadius: BorderRadius.circular(50)
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            screenWidth(50).pw,
            SvgPicture.asset(
              "assets/images/$svgname.svg",
              width:screenWidth(40) ,
              height:screenHeight(40),
              color: Colors.white
            ),
            screenWidth(30).pw, Center(child: Text("${interestname}",
            style: TextStyle(color: AppColors.whitecolor,fontSize: screenWidth(25),
            
            fontWeight: FontWeight.w400)))
          ],
        ),
      );
    });
  }
}