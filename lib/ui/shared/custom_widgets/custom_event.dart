import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';

class CustomEvent extends StatefulWidget {
  const CustomEvent({super.key, required this.imagename, required this.location, required this.eventname, required this.going, required this.date});
  final String imagename;
  final String location;
  final String eventname;
  final String going;
  final String date;


  @override
  State<CustomEvent> createState() => _CustomEventState();
}

class _CustomEventState extends State<CustomEvent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(width: screenWidth(1.5),
      decoration: BoxDecoration(color: AppColors.whitecolor,borderRadius: BorderRadius.circular(30)),
      child: Column(children: [
        screenHeight(50).ph,
      Stack(
        children: [
          Center(
            child: ClipRRect(
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: SvgPicture.asset("assets/images/${widget.imagename}.svg",fit: BoxFit.none,)),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Container(width: screenWidth(7),
            height: screenHeight(17),
              decoration: BoxDecoration(shape: BoxShape.rectangle,
                color:AppColors.whitecolor.withOpacity(0.9), borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(widget.date,style: TextStyle(color: AppColors.orangColor,
                            fontWeight: FontWeight.bold,fontSize: screenWidth(25)),),
              ),),
              screenWidth(3.3).pw,
             Container(width: screenWidth(10),
            height: screenHeight(20),
              decoration: BoxDecoration(color:AppColors.whitecolor.withOpacity(0.9), borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset("assets/images/save.svg",fit: BoxFit.none,)
            ),
          ],)
        ],
      ),
      screenHeight(60).ph,
      SizedBox(
        width: screenWidth(1.8),
        child: Text(widget.eventname,
        style: TextStyle( color: AppColors.blacktext,fontWeight: FontWeight.w400,fontSize: screenWidth(20))),
      )
      ,   
      screenHeight(50).ph,
        Text(widget.going,style: TextStyle(color: AppColors.bluecolor,fontWeight: FontWeight.w500,fontSize: screenWidth(25))), screenHeight(40).ph,
      Row(children: [screenWidth(20).pw,
        SvgPicture.asset("assets/images/location.svg"),
        screenWidth(40).pw,
        Text(widget.location)
      ],)

    ],),);
  }
}