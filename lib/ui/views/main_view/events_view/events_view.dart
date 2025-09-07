import 'package:cached_network_image/cached_network_image.dart';
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
    return Scaffold(backgroundColor: AppColors.whitecolor,
       body: Column(
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
                   scrollDirection: Axis.vertical,
                          itemCount: controller.eventUpcominList.length,
                          
                          itemBuilder: (BuildContext context, int index) {
                            final item = controller.eventUpcominList[index];final date = controller.eventUpcominList[index].date!;
final dateTime = DateTime.parse(date);

// مثال: عرض التاريخ فقط
final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

// مثال: عرض الوقت فقط
final formattedTime = DateFormat('HH:mm').format(dateTime);

// مثال: عرض التاريخ والوقت معاً
final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

                              var result = extractDayAndMonth(controller.eventUpcominList[index].date!);
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: screenWidth(50)),
                              child: InkWell(
                                onTap: () {
                                  controller.toggleInterest(item.name!);
                                  Get.to(EventDetailsView(id:controller.eventUpcominList[index].id .toString() ,));
                                 
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: AppColors.whitecolor,  boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1), // لون الظل
        blurRadius: 10, // درجة التمويه
        spreadRadius: 2, // مدى الانتشار
        offset: const Offset(0, 5), // اتجاه الظل (X=0 , Y=5 يعني لتحت)
      ),
    ],),
                                    child: Row(children: [ Container(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20), // هنا درجة التدوير
                                        child: CachedNetworkImage(width: screenWidth(5),height: screenHeight(10),
                                          imageUrl: controller.eventUpcominList[index].image??'',
                                          placeholder: (context, url) => 
                                            SvgPicture.asset("assets/images/placeholder.svg"), // صورة بديلة لوقت التحميل
                                          errorWidget: (context, url, error) =>
                                            Icon(Icons.error, color: Colors.red), // لو صار خطأ
                                       fit: BoxFit.cover,
                                          // حدد الارتفاع اللي بدك ياه
                                        ),
                                      ),
                                  ),Padding(
                                   padding:  EdgeInsets.symmetric(horizontal: screenWidth(50)),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [Text("${ controller.eventUpcominList[index].name != null
      ? (controller.eventUpcominList[index].name!.length > 10
          ? controller.eventUpcominList[index].name!.substring(0, 10) + '...'
          : controller.eventUpcominList[index].name!)
      : ''}",
  maxLines: 1,style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(25),fontWeight: FontWeight.w500),),
                                 screenHeight(90).ph ,    Text(
  controller.eventUpcominList[index].description != null
      ? (controller.eventUpcominList[index].description!.length > 10
          ? controller.eventUpcominList[index].description!.substring(0, 10) + '...'
          : controller.eventUpcominList[index].description!)
      : '',
  maxLines: 1,
),      Text("+ ${controller.eventUpcominList[index].tickets}Going",style: TextStyle(color: AppColors.bluecolor,fontSize: screenWidth(30)),)

                                      ],
                                      ),
                                  ),Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_pin,color:AppColors.bluecolor,size: screenWidth(30),),screenWidth(60).pw,
                                          Text(controller.eventUpcominList[index].location!.crs!.properties!.name!,style: TextStyle(fontSize: screenWidth(40)),),
                                        ],
                                      ),screenHeight(80).ph,
                                      Row(  children: [
                                          Icon(Icons.date_range,color:AppColors.bluecolor,size: screenWidth(30),),screenWidth(60).pw,
                                        Text(formattedDateTime,style: TextStyle(fontSize: screenWidth(40)),)
                                        ],),screenHeight(80).ph,
                                        Container(padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(color: AppColors.greyDotsIndicator.withOpacity(0.5),borderRadius: BorderRadius.circular(5),shape: BoxShape.rectangle),
                                          child: Text('${controller.eventUpcominList[index].price}\$',style: TextStyle(color: AppColors.orangColor,fontWeight: FontWeight.w500),),)
                                    ],),
                                  )
                                  ],),)
                                ),
                              ),
                            );
                          },
                        ),
                      );
                });
              } else {
               return 
                    SizedBox(
                                       height: screenHeight(2.9),
                        child: ListView.builder(
                       
                      shrinkWrap: true,
                   scrollDirection: Axis.vertical,
                          itemCount: controller.eventPastList.length,
                          
                          itemBuilder: (BuildContext context, int index) {final date = controller.eventPastList[index].date!;
                            final item = controller.eventPastList[index];final dateTime = DateTime.parse(date);

// مثال: عرض التاريخ فقط
final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

// مثال: عرض الوقت فقط
final formattedTime = DateFormat('HH:mm').format(dateTime);

// مثال: عرض التاريخ والوقت معاً
final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

                              var result = extractDayAndMonth(controller.eventPastList[index].date!);
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: screenWidth(50)),
                              child: InkWell(
                                onTap: () {
                                  controller.toggleInterest(item.name!);
                                  Get.to(EventDetailsView(id: controller.eventPastList[index].id.toString() ,));
                                 
                                },
                                child:  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: AppColors.whitecolor,  boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1), // لون الظل
        blurRadius: 10, // درجة التمويه
        spreadRadius: 2, // مدى الانتشار
        offset: const Offset(0, 5), // اتجاه الظل (X=0 , Y=5 يعني لتحت)
      ),
    ],),
                                    child: Row(children: [ Container(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20), // هنا درجة التدوير
                                        child: CachedNetworkImage(width: screenWidth(5),height: screenHeight(10),
                                          imageUrl: controller.eventPastList[index].image??'',
                                          placeholder: (context, url) => 
                                            SvgPicture.asset("assets/images/placeholder.svg"), // صورة بديلة لوقت التحميل
                                          errorWidget: (context, url, error) =>
                                            Icon(Icons.error, color: Colors.red), // لو صار خطأ
                                       fit: BoxFit.cover,
                                          // حدد الارتفاع اللي بدك ياه
                                        ),
                                      ),
                                  ),Padding(
                                   padding:  EdgeInsets.symmetric(horizontal: screenWidth(50)),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [Text("${ controller.eventPastList[index].name != null
      ? (controller.eventPastList[index].name!.length > 10
          ? controller.eventPastList[index].name!.substring(0, 10) + '...'
          : controller.eventPastList[index].name!)
      : ''}",
  maxLines: 1,style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(25),fontWeight: FontWeight.w500),),
                                 screenHeight(90).ph ,    Text(
  controller.eventPastList[index].description != null
      ? (controller.eventPastList[index].description!.length > 10
          ? controller.eventPastList[index].description!.substring(0, 10) + '...'
          : controller.eventPastList[index].description!)
      : '',
  maxLines: 1,
),      Text("+ ${controller.eventPastList[index].tickets}Going",style: TextStyle(color: AppColors.bluecolor,fontSize: screenWidth(30)),)

                                      ],
                                      ),
                                  ),Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_pin,color:AppColors.bluecolor,size: screenWidth(30),),screenWidth(60).pw,
                                          Text(controller.eventPastList[index].location!.crs!.properties!.name!,style: TextStyle(fontSize: screenWidth(40)),),
                                        ],
                                      ),screenHeight(80).ph,
                                      Row(  children: [
                                          Icon(Icons.date_range,color:AppColors.bluecolor,size: screenWidth(30),),screenWidth(60).pw,
                                        Text(formattedDateTime,style: TextStyle(fontSize: screenWidth(40)),)
                                        ],),screenHeight(80).ph,
                                        Container(padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(color: AppColors.greyDotsIndicator.withOpacity(0.5),borderRadius: BorderRadius.circular(5),shape: BoxShape.rectangle),
                                          child: Text('${controller.eventPastList[index].price}\$',style: TextStyle(color: AppColors.orangColor,fontWeight: FontWeight.w500),),)
                                    ],),
                                  )
                                  ],),)
                                ),
                              ),
                            );
                          },
                        ),
                      );
                }})
              
            )
        ] 
          
      ));
  }
}