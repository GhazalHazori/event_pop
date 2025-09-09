import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart';
import 'package:flutter_templat/ui/shared/utlis.dart'
    show screenWidth, screenHeight;
import 'package:flutter_templat/ui/views/change_password_view/changE_password_view_controller.dart';
import 'package:get/get.dart';

class ChangePasswordView extends StatefulWidget {
  final String proof;
  final String email;
  const ChangePasswordView({
    super.key,
    required this.email,
    required this.proof,
  });

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late ChangePasswordViewController controller;

  // للتحكم في إظهار/إخفاء كلمة المرور
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    controller =
        Get.put(ChangePasswordViewController(widget.proof, widget.email));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      body: Column(
        children: [
          screenHeight(20).ph,
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: SizedBox(
                width: screenWidth(6),
                child: SvgPicture.asset("assets/images/back.svg"),
              ),
            ),
          ),
          screenHeight(40).ph,
          SizedBox(
            width: screenWidth(1.11),
            child: Text(
              "Reset Password",
              style: TextStyle(
                  color: AppColors.blacktext,
                  fontSize: screenWidth(15),
                  fontWeight: FontWeight.w400),
            ),
          ),
          screenHeight(90).ph,
          SizedBox(
            width: screenWidth(1.11),
            child: Text(
              "Enter your new password ",
              style: TextStyle(
                color: AppColors.blacktext,
                fontSize: screenWidth(20),
              ),
            ),
          ),
          screenHeight(50).ph,

          // Password Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(30)),
            child: TextFormField(
              controller: controller.password,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon:
                    Icon(Icons.lock_outline, color: AppColors.secondryWhite),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.secondryWhite,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                filled: true,
                fillColor: AppColors.secondryWhite.withOpacity(0.1),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: AppColors.secondryWhite.withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.bluecolor),
                ),
              ),
            ),
          ),

          screenHeight(20).ph,

          // Confirm Password Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(30)),
            child: TextFormField(
              controller: controller.confirmpassword,
              obscureText: _obscureConfirm,
              decoration: InputDecoration(
                hintText: "Confirm password",
                prefixIcon:
                    Icon(Icons.lock_outline, color: AppColors.secondryWhite),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.secondryWhite,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirm = !_obscureConfirm;
                    });
                  },
                ),
                filled: true,
                fillColor: AppColors.secondryWhite.withOpacity(0.1),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: AppColors.secondryWhite.withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.bluecolor),
                ),
              ),
            ),
          ),

          screenHeight(20).ph,

          // Reset Button
          CustomMainButton(
            text: "RESET",
            onpressed: () {
              if (controller.password.text == controller.confirmpassword.text) {
                controller.resetPassword(
                  newpassword: controller.password.text,
                  email: widget.email,
                  id: widget.proof,
                );
              } else {
                Get.snackbar("Error", "Passwords do not match",
                    backgroundColor: Colors.red.withOpacity(0.7),
                    colorText: Colors.white);
              }
            },
            svgname: "circle_arrow",
            backgroundcolor: AppColors.bluecolor,
            width: screenWidth(2),
            hight: screenHeight(13),
          ),
          screenHeight(20).ph,
        ],
      ),
    );
  }
}
