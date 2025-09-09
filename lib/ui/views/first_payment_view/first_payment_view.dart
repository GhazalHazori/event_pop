import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/textform.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/first_payment_view/first_payment_view_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FirstPaymentView extends StatefulWidget {
  final String? id;
  const FirstPaymentView({super.key,  this.id});

  @override
  State<FirstPaymentView> createState() => _FirstPaymentViewState();
}

class _FirstPaymentViewState extends State<FirstPaymentView> {
  late FirstPaymentViewController controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FirstPaymentViewController(widget.id!));
  }

  Future<void> _handlePayment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // ⚠️ العملية الأساسية
      await controller.creatPayment(
        id: widget.id!,
        seats: controller.seatscontroller.text,
      );

      // لمحاكاة وقت التحميل (اختياري)
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whitecolor,
      body: Column(
        children: [
          screenHeight(18).ph,

          // ✅ زر الرجوع + العنوان
          SizedBox(
            width: screenWidth(1.2),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    "assets/images/back.svg",
                    width: screenWidth(18),
                  ),
                ),
                screenWidth(5).pw,
                Text(
                  "Number of ticket",
                  style: TextStyle(
                    color: AppColors.bluecolor,
                    fontSize: screenWidth(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight(30)),

          // ✅ Text Field
          TextForm(
            hinttext: "Enter number of ticket",
            textfieldhintcolor: AppColors.secondryWhite,
            type: TextInputType.number,
            texteditingcontroller: controller.seatscontroller,
            prefixIcon: Icon(
              Icons.chair_outlined,
              color: AppColors.secondryWhite,
            ),
          ),
           screenHeight(10).ph,
  SizedBox(
                        height: screenHeight(3),
                        child: Lottie.asset(
                          'assets/lottie/ticket.json',
                          repeat: true,
                        ),
                      ),
          const Spacer(),

          // ✅ هنا التبديل بين الزر واللودر
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: _isLoading
                ? Column(
                    children: [
                      // لودر Lottie (إذا عندك ملف JSON)
                    SizedBox(
                        height: screenHeight(15),
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Processing payment...",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                : CustomMainButton(
                    text: "Choose Payment Method",
                    onpressed: _handlePayment,
                    svgname: "circle_arrow",
                    backgroundcolor: AppColors.bluecolor,
                    width: screenWidth(1.11),
                    hight: screenHeight(15),
                  ),
          ),
        ],
      ),
    );
  }
}
