import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/core/translation/app_traslation.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_button_new.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_event.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_interest.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_interest_explore.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_search.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custombutton_ger.dart';
import 'package:flutter_templat/ui/shared/utlis.dart' show screenHeight, screenWidth;
import 'package:flutter_templat/ui/views/event_details_view/event_details_view.dart';
import 'package:flutter_templat/ui/views/main_view/explore_view/explore_view_controller.dart';
import 'package:flutter_templat/ui/views/sign_up_secondry/sign_up_secondary_view_controller.dart' show SignUpSecondaryViewController;
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
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
  }} ExploreViewController controller=Get.put(ExploreViewController());
  SignUpSecondaryViewController controllero=Get.put(SignUpSecondaryViewController('','','',''));
  @override
  Widget build(BuildContext context) {
    
       
    return  Scaffold(resizeToAvoidBottomInset: false,
      body: Column(children: [
       Stack(
       clipBehavior: Clip.none,
         children: [
    
           Container(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          screenHeight(20).ph,
                          Row(
                            children: [
                              screenWidth(20).pw,
                            SvgPicture.asset("assets/images/menu.svg"),
                                         screenWidth(5).pw,         
                                      SizedBox(
                                        height: screenHeight(20),
                                        width: screenWidth(3),
                                        child:
                                          
                                           DropdownButton<String>(
                                            underline: Align(),
                                          icon: Icon(Icons.arrow_drop_down_sharp,color: AppColors.whitecolor,),
                                            isExpanded: true,
                                            hint:
                          Text("Current Location\n New Yourk, USA",style: TextStyle(color: AppColors.whitecolor,fontWeight: FontWeight.w300)),
                                            value:"", // Set the selected value
                                            items: controller.location
                          .map((location) {
                                              return DropdownMenuItem<String>(
                          value:""
                              .toString(), // Use ID as the value
                          child: Text(
                          "", // Display the job name
                            style: TextStyle(
                                fontSize: screenWidth(25)),
                          ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              if (newValue != null) {
                                          
                                              }
                                            },
                                          )
                                      
                                      ),screenWidth(5).pw,
                                      CircleAvatar(radius: screenWidth(25),
                                        child: SvgPicture.asset("assets/images/notification.svg"),backgroundColor: AppColors.whitecolor.withOpacity(0.5),)
                          ],),
                          screenHeight(25).ph,
                       Row(
      children: [
    SizedBox(width: screenWidth(1.6),
      child: Expanded( 
        
        child: CustomSearch(
          prefixIcon: Icon(Icons.search,color: AppColors.whitecolor,),
          hint: "| Search",
          
          fillcolor: AppColors.whitecolor,
          hintColor: AppColors.greySign,
        ),
      ),
    ),
    SizedBox(width: screenWidth(5.5)),
    Container(
      width: screenWidth(6),
      height: screenHeight(20),
    
      decoration: BoxDecoration(color: 
       AppColors.whitecolor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: InkWell(
        onTap: (){
           showFilterBottomSheet(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: [
            SvgPicture.asset("assets/images/filter.svg"),
         
            Text(
              "Filter",
              style: TextStyle(
                color: AppColors.whitecolor,
                fontSize: screenWidth(25),
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
      ),
    ),
      ],
    ),
    
                        ],
                      ) ,
                        width: double.infinity,
                      height: screenHeight(3.6),
                        decoration: ShapeDecoration(
                         color: AppColors.bluecolor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.only(bottomLeft:  Radius.circular(50),bottomRight: Radius.circular(40) ),
                          ),
                        ),
                      ),
               
                  Positioned(
                         right: 30,
            left: 30,
            bottom: -screenHeight(35),
                    child: SizedBox(
                                     height: screenHeight(17),
                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                        itemCount: controller.intrestList.length,
                        
                        itemBuilder: (BuildContext context, int index) {
                          final item = controller.intrestList[index];
                          return Padding(
                            padding:  EdgeInsets.symmetric(horizontal: screenWidth(70)),
                            child: InkWell(
                              onTap: () {
                                controller.toggleInterest(item.name!);
                              },
                              child: CustomInterestExplore(
                                svgname: item.logo!,
                                interestname: item.name!, colorintrest: AppColors.orangColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),    
      
         ],
       ),
        SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
          child: SizedBox(height: screenHeight(1.6),
          
            child: ListView(
              children: [ screenHeight(50).ph,Row(children: [     
                screenWidth(20).pw,Text('Upcoming Events',style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20),fontWeight: FontWeight.w400),),],),
                   screenHeight(50).ph,
                Obx((){
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
                                child:CustomEvent(imagename: 'event1',
                                 location: '36 Guild Street London, UK ',
                                  eventname: 'International Band Mu...',
                                   going: '+20 Going', date: '  10 \nJUNE',
                                 
                                ),
                                // CustomEvent(imagename:controller.eventUpcominList[index].image!,
                                //  location: '36 Guild Street London, UK ', 
                                //  eventname: controller.eventUpcominList[index].name!, 
                                //  going: '+ ${controller.eventUpcominList[index].tickets} Going', 
                                //  date: ' ${result['day']} \n${result['month']}',
                                 
                                // ),
                              ),
                            );
                          },
                        ),
                      );
                }),
                      screenHeight(50).ph, 
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(width: screenWidth(1.5),
                                             
                        height: screenHeight(6),
                          decoration: BoxDecoration(color: AppColors.skyColor.withOpacity(0.5),borderRadius: BorderRadius.circular(15)),
                          child: Column(children: [
                            screenHeight(40).ph,
                             SizedBox(
                                    width: screenWidth(1.2),
                                    child: Text("Invite your friends",
                                    style: TextStyle( color: AppColors.blacktext,fontWeight: FontWeight.w400,fontSize: screenWidth(20))),
                                          ),screenHeight(70).ph,
                                     SizedBox(
                                    width: screenWidth(1.2),
                                    child: Text("Get \$20 for ticket",
                                    style: TextStyle( color: AppColors.greySign,fontWeight: FontWeight.w400,fontSize: screenWidth(20))),
                                          ),
                                          CustomMainButton(text: "Invite", onpressed: () {  }, width: screenWidth(3), hight: screenHeight(20),textcolor: AppColors.whitecolor,backgroundcolor: AppColors.skyColor,)
                        ],),),
                      ), screenHeight(50).ph,Row(children: [     screenWidth(20).pw,Text('Nearby You',style: TextStyle(color: AppColors.blacktext,fontSize: screenWidth(20),fontWeight: FontWeight.w400),),],),
                   screenHeight(50).ph,
                 SizedBox(
                                       height: screenHeight(2.9),
                        child: ListView.builder(
                   shrinkWrap: true,
                   scrollDirection: Axis.horizontal,
                          itemCount: controller.intrestList.length,
                        
                          itemBuilder: (BuildContext context, int index) {
                            final item = controller.intrestList[index];
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: screenWidth(50)),
                              child: InkWell(
                                onTap: () {
                                  controller.toggleInterest(item.name!);
                                },
                                child: CustomEvent(imagename: 'event1',
                                 location: '36 Guild Street London, UK ',
                                  eventname: 'International Band Mu...',
                                   going: '+20 Going', date: '  10 \nJUNE',
                                 
                                ),
                              ),
                            );
                          },
                        ),
                      ), ],),
          ),
        )
    ],),);
    
  }
  void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: AppColors.whitecolor,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.9,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // Categories Section
          
            SizedBox(
          height: screenHeight(5),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.intrestListFilter.length,
         
            itemBuilder: (BuildContext context, int index) {
              final item = controller.intrestListFilter[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(50),
               
                ),
                child: InkWell(
                  onTap: () {
                    controller.toggleInterestFilter(item.name!);
                  },
                  child: CustomInterest(
                    svgname: item.logo!,
                    interestname: item.name!,
                  ),
                ),
              );
            },
          ),
        ),
          
            
            // Time & Date Section
            Text('Time & Date', style: TextStyle(fontWeight: FontWeight.w400,fontSize: screenWidth(20))),
            SizedBox(height: 10),

Wrap(
  spacing: 15,
  children: ['Today', 'Tomorrow', 'This week'].map((time) {
   
    return Obx(() => FilterChip(
      label: Text(
        time,
        textAlign: TextAlign.center,

        style: TextStyle(
          color: controller.selectedTime.value == time 
              ? Colors.white 
              : null,
              fontSize: screenWidth(20),fontWeight: FontWeight.w400
        ),
      ),
      selected: controller.selectedTime.value == time,
      selectedColor: Colors.blue,
      backgroundColor: Colors.white,
      
      showCheckmark: false,
      onSelected: (bool selected) {
        if (selected) {
          controller.selectTime(time);
        } else {
          controller.selectTime('');
        }
      },
    ));
  }).toList(),
),
            SizedBox(height: 10),
            Container( width: screenWidth(1.5),
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),border: Border.all(color: AppColors.greySign.withOpacity(0.5))),
    
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset("assets/images/events.svg",color: AppColors.bluecolor,),

                  TextButton(
                    onPressed: () {},
                    child: Text('Choose from calendar',style: TextStyle(fontWeight: FontWeight.w400,fontSize: screenWidth(20),color: AppColors.greySign)),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.blue)
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // Location Section
            Text('Location', style: TextStyle(fontWeight: FontWeight.w400,fontSize: screenWidth(20),color: AppColors.blacktext)),
            SizedBox(height: 10),
              Container(height: screenHeight(13),
        
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),border: Border.all(color: AppColors.greySign.withOpacity(0.5))),
          child: Row(
            children: [
              screenWidth(30).pw,
              SvgPicture.asset("assets/images/location_icon.svg"),
              SizedBox(
                  width: screenWidth(1.4),
                height: screenHeight(20), // ضبط الارتفاع حسب الحاجة
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.blue), // استخدم AppColors.bluecolor
                    isExpanded: true,
                    hint: Text("  New Yourk, USA",style: TextStyle(fontWeight: FontWeight.w400,fontSize: screenWidth(20),color: AppColors.blacktext),),
                    value: null, // لا حاجة لقيمة هنا للاختيار المتعدد
                    items: controller.locations.map((location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Obx(() {
                          return Row(
                            children: [
                              Checkbox(
                                value: controller.selectedLocations.contains(location),
                                onChanged: (bool? value) {
                                  controller.toggleSelection(location);
                                },
                              ),
                              Text(
                                location,
                                style: TextStyle(fontSize: 18), // ضبط حجم الخط حسب الحاجة
                              ),
                            ],
                          );
                        }),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // لا حاجة لتنفيذ إجراء هنا للاختيار المتعدد
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
            SizedBox(height: 20),
            
            // Price Range Section
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select price range', style: TextStyle(fontWeight: FontWeight.w400,fontSize: screenWidth(20))),
                 Text('\$20-\$120', style: TextStyle(fontWeight: FontWeight.w400,fontSize: screenWidth(20),color: AppColors.bluecolor)), 
              ],
            ),
            SizedBox(height: 10),
              Obx(() => RangeSlider(
           
          values: RangeValues(
            controller.minPrice.value,
            controller.maxPrice.value,
          ),
          min: 0,
          max: 200,
          divisions: 10,
          activeColor: Colors.blue,
          inactiveColor: Colors.grey[300],
          labels: RangeLabels(
            '\$${controller.minPrice.value.toInt()}',
            '\$${controller.maxPrice.value.toInt()}',
            
          ),
          
          onChanged: (RangeValues values) {
            controller.setPriceRange(values.start, values.end);
            
          },
          
        )),
     
  


            SizedBox(height: 20),
            
            // Buttons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},

                    child: Text('RESET',style: TextStyle(color: AppColors.blacktext),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whitecolor,
                        
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 16),
                         fixedSize: Size(screenWidth(40), screenHeight(15)),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('APPLY',style: TextStyle(color: AppColors.whitecolor),),
                    style: ElevatedButton.styleFrom(  backgroundColor: AppColors.bluecolor,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 16),

                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      
      );
    });}
}