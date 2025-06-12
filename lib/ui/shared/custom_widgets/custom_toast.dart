import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';

class CustomToast {
  static showMessage({
    required String message,
    MessagType messagetype = MessagType.INFO, required messageType,
  }) {
    String imageName = 'info';
    Color shadowColor = AppColors.bluecolor;
    switch (messagetype) {
      case MessagType.INFO:
        imageName = 'info';
        shadowColor = AppColors.bluecolor;
        break;
      case MessagType.WARNING:
        imageName = 'warning';
        shadowColor = AppColors.orangColor;
        break;
      case MessagType.REJECTED:
        imageName = 'rejected-01';
        shadowColor = AppColors.redcolor;
        break;
      case MessagType.SUCCSESS:
        imageName = 'approved1-01';
        shadowColor = AppColors.maingreen;
        break;
    }

    BotToast.showCustomText(
        duration: Duration(seconds: 5),
        toastBuilder: (value) {
          return Container(
            width: screenWidth(2),
            height: screenHeight(5),
            decoration: BoxDecoration(
                color: AppColors.whitecolor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images$imageName.svg'),
                Text('$message')
              ],
            ),
          );
        });
  }
}
