import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart' show CustomMainButton;
import 'package:flutter_templat/ui/shared/utlis.dart';

class EventDetailsView extends StatefulWidget {
  const EventDetailsView({super.key});

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Column(
      children: [
        Stack(
        clipBehavior: Clip.none,
        
          children: [
       
          Image.asset("assets/images/event_details.png",width: screenWidth(1),),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: screenHeight(20)),
            child: Row(
              children: [
                screenWidth(20).pw,
              Icon(Icons.arrow_back_outlined,color: AppColors.blacktext,), screenWidth(20).pw,
              Text("Event Details",style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20)),), screenWidth(2.5).pw,
                 Container(width: screenWidth(10),
              height: screenHeight(20),
                decoration: BoxDecoration(color:AppColors.whitecolor.withOpacity(0.9), borderRadius: BorderRadius.circular(10)),
                child: SvgPicture.asset("assets/images/save.svg",fit: BoxFit.none,)
              ),
            ],),
          ),
          Positioned(
            right: 30,
            left: 30,
            bottom: -screenHeight(35),
            child: Container(
            
              height: screenHeight(12),
              decoration: BoxDecoration(color: AppColors.whitecolor,borderRadius: BorderRadius.circular(50)),
              child: Row(children: [
                 screenWidth(3.5).pw,
              Text("+20 Going",style: TextStyle(color: AppColors.bluecolor,fontWeight: FontWeight.w500,fontSize: screenWidth(25))), screenHeight(40).ph,
                  screenWidth(8).pw,
              CustomMainButton(text: "Invite", onpressed: () {  }, width: screenWidth(4), hight: screenHeight(20),textcolor: AppColors.whitecolor,backgroundcolor: AppColors.bluecolor,)
            ],),),
          )
        ],),
        screenHeight(10).ph,
 SizedBox(width: screenWidth(1.11),
  child: Text('International Band \nMusic Concert',style: TextStyle(color: AppColors.blacktext,fontWeight: FontWeight.w400,fontSize: screenWidth(10)))), screenHeight(40).ph,
      SizedBox(width: screenWidth(1.11),
        child: Row(
          children: [
            Container(width: screenWidth(7),
                  height: screenHeight(17),
                    decoration: BoxDecoration(shape: BoxShape.rectangle,
                      color:AppColors.skyopcityColor.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: SvgPicture.asset("assets/images/events.svg",color: AppColors.bluecolor,),
                    ),),    screenWidth(20).pw,
                   Column(children: [Text("14 December, 2021",style: TextStyle(color: AppColors.blacktext,fontWeight: FontWeight.w300,fontSize: screenWidth(25),
                   )),Text("Tuesday, 4:00PM - 9:00PM",style: TextStyle(color: AppColors.greySign,fontWeight: FontWeight.w300,fontSize: screenWidth(25),
                   ))],)
          ],
        ),
      ),  screenHeight(30).ph,
       SizedBox(width: screenWidth(1.11),
         child: Row(
          children: [
            Container(width: screenWidth(7),
                  height: screenHeight(17),
                    decoration: BoxDecoration(shape: BoxShape.rectangle,
                      color:AppColors.skyopcityColor.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: SvgPicture.asset("assets/images/location.svg",color: AppColors.bluecolor,),
                    ),),    screenWidth(20).pw,
                   Column(children: [Text("Gala Convention Center",style: TextStyle(color: AppColors.blacktext,fontWeight: FontWeight.w300,fontSize: screenWidth(25),
                   )),Text("36 Guild Street London, UK ",style: TextStyle(color: AppColors.greySign,fontWeight: FontWeight.w300,fontSize: screenWidth(25),
                   ))],)
          ],
               ),
       ),  screenHeight(30).ph,
        SizedBox(width: screenWidth(1.11),
          child: Row(
          children: [
            Container(width: screenWidth(7),
                  height: screenHeight(17),
                    decoration: BoxDecoration(shape: BoxShape.rectangle,
                      color:AppColors.whitecolor.withOpacity(0.9), borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      child: Image.asset("assets/images/person_follow.png",fit: BoxFit.cover,),
                    ),),
                    screenWidth(20).pw,
                   Column(children: [Text("Ashfak Sayem",style: TextStyle(color: AppColors.blacktext,fontWeight: FontWeight.w300,fontSize: screenWidth(25),
                   )),Text("Organizer ",style: TextStyle(color: AppColors.greySign,fontWeight: FontWeight.w300,fontSize: screenWidth(25),
                   ))],),  screenWidth(4.4).pw,
                   CustomMainButton(text: "Follow", onpressed: () {  }, width: screenWidth(4), hight: screenHeight(20),textcolor: AppColors.bluecolor,backgroundcolor: AppColors.skyopcityColor.withOpacity(0.5),)
          ],
                ),
        ),screenHeight(30).ph,
      SizedBox(width: screenWidth(1.11),
        child: Text("About Event",style: TextStyle(color: AppColors.blacktext,fontWeight: FontWeight.w400,fontSize: screenWidth(15),
                   )),
      ),screenHeight(90).ph,
        SizedBox(width: screenWidth(1.11),
          child: Text("Enjoy your favoforite dish  ........",style: TextStyle(color: AppColors.blacktext,fontWeight: FontWeight.w400,fontSize: screenWidth(20),)
                   ),
        ),screenHeight(30).ph,    CustomMainButton(text: "Buy Ticket \$120", onpressed: (){

      },textfontwieght: FontWeight.w500,
      svgname: "circle_arrow",backgroundcolor: AppColors.bluecolor, width: screenWidth(1.3), hight: screenHeight(15),),        
      ],
    ),);
  }
}