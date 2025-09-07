import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/ui/views/contact_us_view/contact_us_view.dart';
import 'package:flutter_templat/ui/views/setting_view/setting_view.dart';
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
          Text(""),
          drawerItem(
              size: size,
              iconname: "my_profile",
              text: 'Profile',
              ontap: () {
                Get.back();
                // Get.to(LoginView());
              }),
          SizedBox(
            height: size.width * 0.1,
          ),
          drawerItem(
              size: size, iconname: "masseges", text: 'Massage', ontap: () {}),
          SizedBox(
            height: size.width * 0.1,
          ),
          drawerItem(
              size: size, iconname: "bookmark", text: 'Bookmark', ontap: () {}),
          SizedBox(
            height: size.width * 0.1,
          ),
          drawerItem(
              size: size,
              iconname: "contact_us",
              text: 'Contact Us',
              ontap: () {
                Get.to(ContactUsPage());
              }),
          SizedBox(
            height: size.width * 0.1,
          ),
          drawerItem(
              size: size,
              iconname: "setting",
              text: 'Settings',
              ontap: () {
                Get.to(SettingsView());
              }),
          SizedBox(
            height: size.width * 0.5,
          ),
          drawerItem(
              size: size, iconname: "sign_out", text: 'Sign Out', ontap: () {})
        ],
      ),
    );
  }
}

Widget drawerItem(
    {required Size size,
    required String iconname,
    required String text,
    required Function ontap}) {
  return InkWell(
    onTap: () {
      ontap();
    },
    child: Row(
      children: [
        SvgPicture.asset("assets/images/${iconname}.svg"),
        SizedBox(
          width: size.width * 0.02,
        ),
        Text(
          text,
          style: TextStyle(color: AppColors.blacktext),
        )
      ],
    ),
  );
}
