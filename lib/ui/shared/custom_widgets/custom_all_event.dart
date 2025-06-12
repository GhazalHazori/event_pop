import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';

class CustomAllEvent extends StatefulWidget {
  const CustomAllEvent({super.key, required this.image, required this.name, required this.date, required this.location});
final String image;
final String name;
final String date;
final String location;
  @override
  State<CustomAllEvent> createState() => _CustomAllEventState();
}

class _CustomAllEventState extends State<CustomAllEvent> {
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
                   )),
                   Row(children: [screenWidth(20).pw,
        SvgPicture.asset("assets/images/location.svg"),
        screenWidth(40).pw,
        Text(widget.location)
      ],)
],)
    ],),);
  }
}