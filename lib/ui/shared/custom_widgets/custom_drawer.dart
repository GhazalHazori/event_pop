import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_templat/ui/shared/colors.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1, vertical: size.width * 0.1),
      width: size.width * 0.65,
      color: AppColors.whitecolor,
      child: Column(
        children: [
          drawerItem(
              size: size,
              iconname: Icons.verified_user,
              text: 'Profile',
              ontap: () {
                Get.back();
                // Get.to(LoginView());
              }),
          SizedBox(
            height: size.width * 0.1,
          ),
          drawerItem(
              size: size, iconname: Icons.menu, text: 'More', ontap: () {})
        ],
      ),
    );
  }
}

Widget drawerItem(
    {required Size size,
    required IconData iconname,
    required String text,
    required Function ontap}) {
  return InkWell(
    onTap: () {
      ontap();
    },
    child: Column(
      children: [
        Icon(iconname),
        SizedBox(
          width: size.width * 0.02,
        ),
        Text(
          text,
          style: TextStyle(color: AppColors.orangColor),
        )
      ],
    ),
  );
}
