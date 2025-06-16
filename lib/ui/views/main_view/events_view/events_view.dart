import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_event.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/event_details_view/event_details_view.dart';
import 'package:flutter_templat/ui/views/main_view/events_view/events_view_controllre.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView>  {
  
  @override
   EventsViewControllre controller=Get.put(EventsViewControllre());
    late TabController _tabController;
     @override
  

Map<String, String> extractDayAndMonth(String dateString) {
  try {
    DateTime date = DateTime.parse(dateString);
    
    // استخراج رقم اليوم (يوم الشهر)
    String day = date.day.toString();
    
    // استخراج اسم الشهر
    String monthName = DateFormat('MMMM', 'en').format(date);
    
    return {
      'day': day,
      'month': monthName
    };
  } catch (e) {
    return {
      'day': 'خطأ',
      'month': 'خطأ'
    };
  }}
  Widget build(BuildContext context) { 
    return Scaffold( body: Column(
        children: [
          // تبويبات مخصصة
          Column(
            children: [

              screenHeight(10).ph,
                
        Row(
          children: [
            Align(alignment: AlignmentDirectional.topStart,
              child: SizedBox(   width: screenWidth(6),child: SvgPicture.asset("assets/images/back.svg",))),
              Text(
            "Events",
            style: TextStyle(
              color: AppColors.blacktext,
              fontSize: screenWidth(15),
              fontWeight: FontWeight.w400,
            ),
          ),
          ],
        ),
      
        
        screenHeight(20).ph,
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: screenWidth(15)),
                child: Container(
                  height: screenHeight(13),
                  decoration: BoxDecoration(color: AppColors.greyDotsIndicator.withOpacity(0.3),  borderRadius: BorderRadius.circular(20),),
                  child: Row(
                  
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.changeTab(0),
                          child: Obx(() => Container(
               
                            padding: EdgeInsets.symmetric(vertical: 16,),
                            decoration: controller.currentTab.value == 0? BoxDecoration(color: AppColors.whitecolor,
                              borderRadius: BorderRadius.circular(25),
                               boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // لون الظل
                        spreadRadius: 2, // مدى انتشار الظل
                        blurRadius: 5, // درجة ضبابية الظل
                        offset: Offset(0, 3), // اتجاه الظل (x, y)
                      ),
                    ],
                            ):null,
                            child: Text(
                              'UPCOMING',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: controller.currentTab.value == 0 
                                    ? Colors.blue 
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.changeTab(1),
                          child: Obx(() => Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                          
                            decoration: controller.currentTab.value == 1 ? BoxDecoration(color: AppColors.whitecolor,
                              borderRadius: BorderRadius.circular(25),
                               boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // لون الظل
                        spreadRadius: 2, // مدى انتشار الظل
                        blurRadius: 5, // درجة ضبابية الظل
                        offset: Offset(0, 3), // اتجاه الظل (x, y)
                      ),
                    ],
                            ):null,
                            child: Text(
                              'PAST EVENTS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: controller.currentTab.value == 1 
                                    ? Colors.blue 
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
            Expanded(
            child: Obx(() {
              if (controller.currentTab.value == 0) {
                return  Obx((){
                  return  SizedBox(
                                       height: screenHeight(2.9),
                        child: ListView.builder(
                       
                      shrinkWrap: true,
                   scrollDirection: Axis.horizontal,
                          itemCount: controller.eventUpcominList.length,
                          
                          itemBuilder: (BuildContext context, int index) {
                            final item = controller.eventUpcominList[index];
                              var result = extractDayAndMonth(controller.eventUpcominList[index].date!);
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: screenWidth(50)),
                              child: InkWell(
                                onTap: () {
                                  controller.toggleInterest(item.name!);
                                  Get.to(EventDetailsView());
                                 
                                },
                                child: CustomEvent(imagename:controller.eventUpcominList[index].image!,
                                 location: '36 Guild Street London, UK ', 
                                 eventname: controller.eventUpcominList[index].name!, 
                                 going: '+ ${controller.eventUpcominList[index].tickets} Going', 
                                 date: ' ${result['day']} \n${result['month']}',
                                 
                                ),
                              ),
                            );
                          },
                        ),
                      );
                });
              } else {
               return Obx((){
                  return  SizedBox(
                                       height: screenHeight(2.9),
                        child: ListView.builder(
                       
                      shrinkWrap: true,
                   scrollDirection: Axis.vertical,
                          itemCount: controller.eventPastList.length,
                          
                          itemBuilder: (BuildContext context, int index) {
                            final item = controller.eventPastList[index];
                              var result = extractDayAndMonth(controller.eventPastList[index].date!);
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: screenWidth(50)),
                              child: InkWell(
                                onTap: () {
                                  controller.toggleInterest(item.name!);
                                  Get.to(EventDetailsView());
                                 
                                },
                                child: CustomEvent(imagename:controller.eventPastList[index].image!,
                                 location: '36 Guild Street London, UK ', 
                                 eventname: controller.eventPastList[index].name!, 
                                 going: '+ ${controller.eventPastList[index].tickets} Going', 
                                 date: ' ${result['day']} \n${result['month']}',
                                 
                                ),
                              ),
                            );
                          },
                        ),
                      );
                });
              }
            }))
        ] 
          
      ));
  }
}