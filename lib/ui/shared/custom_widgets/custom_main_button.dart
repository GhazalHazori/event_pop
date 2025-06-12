//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';

class CustomMainButton extends StatelessWidget {
  final Color? textcolor;
  final String text;
  final double? textsize;
  final FontWeight? textfontwieght;
  final Color? bordercolor;
  final Color? backgroundcolor;
  final VoidCallback onpressed;
  final String? svgname;
  final double width;
  final double hight;
  

  //final String? svgname;
  const CustomMainButton({
    super.key,
    this.textcolor,
    required this.text,
    this.textsize,
    this.textfontwieght,
    this.backgroundcolor,
    required this.onpressed,
    this.svgname,
    this.bordercolor, required this.width, required this.hight,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        onpressed();
      },
      child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // توزيع العناصر على الجوانب
  children: [
    Expanded( // يسمح للنص بالبقاء في المنتصف
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textcolor ?? AppColors.whitecolor,
            fontSize: screenWidth(25),
            fontWeight: textfontwieght ?? FontWeight.normal,
          ),
        ),
      ),
    ),
    if (svgname != null) ...[
      SvgPicture.asset(
        'assets/images/$svgname.svg',
        width: screenWidth(40),
        height: screenHeight(40),
      ),
    ],
  ],
),

      // Text(
      //   text,
      //   style: TextStyle(
      //       color: textcolor ?? AppColors.whitecolor,
      //       fontSize: textsize ?? size.width * 0.55,
      //       fontWeight: textfontwieght ?? FontWeight.normal),
      // )
      
      style: ElevatedButton.styleFrom(
        side: bordercolor != null
            ? BorderSide(width: 1, color: bordercolor!) //appcolors.whitcolor
            : null,
        backgroundColor: backgroundcolor,
        fixedSize: Size(width, hight),
        shape:RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
      ),
    );
  }
}