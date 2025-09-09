import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/change_password_view/change_password_view.dart';
import 'package:flutter_templat/ui/views/verify_otp_reset/verify_reset_view_controller.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpResetView extends StatefulWidget {
  final String email;
  const VerifyOtpResetView({super.key, required this.email});

  @override
  State<VerifyOtpResetView> createState() => _VerifyOtpResetViewState();
}

class _VerifyOtpResetViewState extends State<VerifyOtpResetView> {
  late VerifyResetViewController controller;
  Timer? _timer;
  int _start = 30;

  @override
  void initState() {
    controller = Get.put(VerifyResetViewController(widget.email));
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    _start = 60;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        controller.requestReset(email: widget.email); // هنا يرجع يطلب OTP من جديد
        _startTimer(); // يعيد العداد من 30 ثانية
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            screenHeight(20).ph,
            SizedBox(
              width: screenWidth(1.2),
              child: Text(
                "Verification",
                style: TextStyle(
                  color: AppColors.blacktext,
                  fontWeight: FontWeight.w400,
                  fontSize: screenWidth(15),
                ),
              ),
            ),
            screenHeight(40).ph,
            SizedBox(
              width: screenWidth(1.2),
              child: Text(
                "We’ve sent you the verification\n code on your email",
                style: TextStyle(
                  color: AppColors.blacktext,
                  fontSize: screenWidth(20),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            screenHeight(10).ph,
            SizedBox(
              width: screenWidth(1.2),
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
                  selectedFillColor: AppColors.bluecolor.withOpacity(0.3),
                  inactiveFillColor: AppColors.whitecolor,
                  fieldHeight: screenWidth(5),
                  fieldWidth: screenWidth(5.5),
                  activeFillColor: AppColors.bluecolor.withOpacity(0.3),
                  activeColor: AppColors.bluecolor,
                  inactiveColor: AppColors.greySign.withOpacity(0.5),
                  selectedColor: AppColors.bluecolor.withOpacity(0.3),
                  borderWidth: screenWidth(40),
                  inactiveBorderWidth: 1,
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
                // Get.to(ChangePasswordView(email: widget.email, proof:'3'));
                controller.verfiy(
                    code: controller.controllerCode.text,
                    email: widget.email);
              }, 
              backgroundcolor: AppColors.bluecolor,
              width: screenWidth(1.5),
              hight: screenHeight(15),
            ),

            screenHeight(10).ph,

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Re-send code in",
                  style: TextStyle(
                    color: AppColors.blacktext,
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth(20),
                  ),
                ),
                Text(
                  "  0:${_start.toString().padLeft(2, '0')} ",
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
    );
  }
}
