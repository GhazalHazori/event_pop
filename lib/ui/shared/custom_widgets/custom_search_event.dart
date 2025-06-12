import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';

class CustomSearchEvent extends StatefulWidget {
  const CustomSearchEvent({super.key, required this.image, required this.name, required this.date});
final String image;
final String name;
final String date;
  @override
  State<CustomSearchEvent> createState() => _CustomSearchEventState();
}

class _CustomSearchEventState extends State<CustomSearchEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
      Container(width: screenWidth(7),
                  height: screenHeight(17),
                    decoration: BoxDecoration(shape: BoxShape.rectangle,
                      color:AppColors.skyopcityColor.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),child: Image.asset("assets/images/${widget.image}.png",fit: BoxFit.cover,),), screenWidth(20).pw,
     Column(children: [Text(widget.date,style: TextStyle(color: AppColors.bluecolor,fontWeight: FontWeight.w300,fontSize: screenWidth(25),
                   )),Text(widget.name,style: TextStyle(color: AppColors.greySign,fontWeight: FontWeight.w300,fontSize: screenWidth(25),
                   ))],)
    ],),);
  }
}