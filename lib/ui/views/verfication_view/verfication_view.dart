import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart' show AppColors;
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart';
import 'package:flutter_templat/ui/shared/utlis.dart' show screenHeight, screenWidth;
import 'package:flutter_templat/ui/views/main_view/main_view.dart';
import 'package:flutter_templat/ui/views/verfication_view/verfication_view_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerficationView extends StatefulWidget {
  const VerficationView({super.key, required this.email});
final String email;
  @override
  State<VerficationView> createState() => _VerficationViewState();
}

class _VerficationViewState extends State<VerficationView> {
  @override
  late VerficationViewController controller;
  
  @override
  void initState() {
    controller = Get.put(VerficationViewController(widget.email));

    super.initState();
  }


  Widget build(BuildContext context) { 
    return SafeArea(
  child: Scaffold(
    resizeToAvoidBottomInset: false,
    body: SingleChildScrollView( // إضافة تمرير لتجنب overflow
      child: Column(
        children: [
          screenHeight(40).ph,
          SizedBox(width: screenWidth(1.2),
            child: Text(
              "Verification",
              style: TextStyle(
                color: AppColors.blacktext,
                fontWeight: FontWeight.w400,
                fontSize: screenWidth(15)
              ),
            ),
          ),
          screenHeight(40).ph,
          SizedBox(
            width: screenWidth(1.2),
            child: Text(
              "We’ve sent you the verification\n code on +1 2620 0323 7631",
              style: TextStyle(
                color: AppColors.blacktext,
                fontSize: screenWidth(20),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          screenHeight(10).ph,
          SizedBox(   width: screenWidth(1.2),
            child: PinCodeTextField(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              appContext: context,
              length: 4,
              obscureText: true,
              obscuringCharacter: '*',
              animationType: AnimationType.slide,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
               shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(20),
                selectedFillColor: AppColors.bluecolor,
                inactiveFillColor: AppColors.whitecolor,
                fieldHeight: screenWidth(5),
                fieldWidth: screenWidth(5.5),
                activeFillColor: AppColors.bluecolor,
                activeColor: AppColors.bluecolor,
                inactiveColor: AppColors.greySign.withOpacity(0.5),
                selectedColor: AppColors.bluecolor,
                borderWidth: screenWidth(40),
                inactiveBorderWidth:1
              ),
              cursorColor: AppColors.bluecolor,
              hintCharacter: '*',
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              controller: controller.controllerCode,
              onChanged: controller.OnChangedCode,
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                return true;
              },
            ),
          ),
          screenHeight(10).ph,
          
      
          CustomMainButton(
            text: "CONTINUE",
            onpressed: () {
            controller.verfiy(code: controller.controllerCode.text, email: widget.email);
              // controller.verfiy(code: controller.controllerCode.text);
              // Get.to(SubsicribView());
            },
            backgroundcolor: AppColors.bluecolor, width: screenWidth(1.5), hight: screenHeight(15),
          ),
          screenHeight(10).ph,Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // controller.resendCode();
                },
                child: Text(
                  "Re-send code in",
                  style: TextStyle(
                    color: AppColors.blacktext,
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth(20)
                  ),
                ),
              ),
              Text(
                "  0:20 ",
                style: TextStyle(
                  color: AppColors.bluecolor,
                  fontSize: screenWidth(20),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);

  }
}