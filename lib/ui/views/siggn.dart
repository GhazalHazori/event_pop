import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_interest.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/sign_in_view/sign_in_view.dart';
import 'package:flutter_templat/ui/views/sign_up_secondry/sign_up_secondary_view_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Siggn extends StatefulWidget {
  const Siggn({super.key});

  @override
  State<Siggn> createState() => _SiggnState();
}

class _SiggnState extends State<Siggn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
   late SignUpSecondaryViewController controller;

 
 @override
  void initState() {
    controller = Get.put(SignUpSecondaryViewController('','','',''));

    super.initState();
  }

  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
      
        children: [
          screenHeight(20).ph,
        Align(alignment: AlignmentDirectional.topStart,
          child: SizedBox(   width: screenWidth(6),child: SvgPicture.asset("assets/images/back.svg",))),
        screenHeight(40).ph,
        SizedBox(
          width: screenWidth(1.11),
          child: Text(
            "Sign UP",
            style: TextStyle(
              color: AppColors.blacktext,
              fontSize: screenWidth(15),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        screenHeight(30).ph,
       SizedBox(
          width: screenWidth(1.11),
          child: Text(
            "add your interests",
            style: TextStyle(
              color: AppColors.greySign,
              fontSize: screenWidth(15),
              fontWeight: FontWeight.w400,
            ),
          ),
        ), screenHeight(30).ph,
        SizedBox(
          height: screenHeight(5),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.intrestList.length,
            padding: EdgeInsets.only(bottom: screenHeight(20)),
            itemBuilder: (BuildContext context, int index) {
              final item = controller.intrestList[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(20),
               
                ),
                child: InkWell(
                  onTap: () {
                    controller.toggleInterest(item.name!);
                  },
                  child: CustomInterest(
                    svgname: item.logo!,
                    interestname: item.name!,
                  ),
                ),
              );
            },
          ),
        ),  screenHeight(30).ph,      SizedBox(
            width: screenWidth(1.11),
            child: Text(
              "Add Location",
              style: TextStyle(
                color: AppColors.greySign,
                fontSize: screenWidth(15),
                fontWeight: FontWeight.w400,
              ),
            ),

          ), screenHeight(50).ph,
        Container(height: screenHeight(15),
        
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),border: Border.all(color: AppColors.greySign.withOpacity(0.5))),
          child: SizedBox(
              width: screenWidth(1.11),
            height: screenHeight(20), // ضبط الارتفاع حسب الحاجة
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.blue), // استخدم AppColors.bluecolor
                isExpanded: true,
                hint: Text("  New Yourk, USA"),
                value: null, // لا حاجة لقيمة هنا للاختيار المتعدد
                items: controller.locations.map((location) {
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Obx(() {
                      return Row(
                        children: [
                          Checkbox(
                            value: controller.selectedLocations.contains(location),
                            onChanged: (bool? value) {
                              controller.toggleSelection(location);
                            },
                          ),
                          Text(
                            location,
                            style: TextStyle(fontSize: 18), // ضبط حجم الخط حسب الحاجة
                          ),
                        ],
                      );
                    }),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // لا حاجة لتنفيذ إجراء هنا للاختيار المتعدد
                },
              ),
            ),
          ),
        ), screenHeight(20).ph,
                                CustomMainButton(text: "Sign Up", onpressed: (){
                               
    },svgname: "circle_arrow",backgroundcolor: AppColors.bluecolor, width: screenWidth(1.3), hight: screenHeight(15),),
          screenHeight(30).ph,
    Text("OR",style: TextStyle(fontSize: screenWidth(20),color: AppColors.greySign),),screenHeight(20).ph,
    
    SvgPicture.asset("assets/images/google.svg"),
    screenHeight(20).ph,
    Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Text("Already have an account?",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20))),
      InkWell(onTap: () {
        Get.to(SignInView());
      },
        child: Text("Sign In",style: TextStyle(color: AppColors.bluecolor,fontSize: screenWidth(20))))
    ],)
      ]),
    );
  }
}