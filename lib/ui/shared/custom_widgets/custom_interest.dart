import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_templat/ui/views/sign_up_secondry/sign_up_secondary_view_controller.dart';

class CustomInterest extends StatelessWidget {
  const CustomInterest({
    super.key,
    required this.svgname,
    required this.interestname,
  });

  final String svgname;
  final String interestname;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpSecondaryViewController>();

    return Obx(() {
      final isSelected = controller.isSelected(interestname);

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.white,
              shape: BoxShape.circle,
            border: Border.all(color: AppColors.greySign.withOpacity(0.6))
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/images/$svgname.svg",
              width: 32,
              height: 32,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(height:20),
          Text(
            interestname,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    });
  }
}