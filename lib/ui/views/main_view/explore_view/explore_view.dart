import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/core/translation/app_traslation.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_button_new.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_doted.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_drawer.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_event.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_interest.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_interest_explore.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_search.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custombutton_ger.dart';
import 'package:flutter_templat/ui/shared/utlis.dart'
    show screenHeight, screenWidth;
import 'package:flutter_templat/ui/views/all_event_view/all_event_view.dart';
import 'package:flutter_templat/ui/views/event_details_view/event_details_view.dart';
import 'package:flutter_templat/ui/views/main_view/explore_view/explore_view_controller.dart';
import 'package:flutter_templat/ui/views/search_view/search_view.dart';
import 'package:flutter_templat/ui/views/sign_up_secondry/sign_up_secondary_view_controller.dart'
    show SignUpSecondaryViewController;
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
      if (dateString.isEmpty) return {'day': 'N/A', 'month': 'N/A'};

      // تنظيف النص وإزالة أي مسافات زائدة أو رموز غير مرغوب فيها
      String cleanDate = dateString.trim().replaceAll("\n", " ");

      // محاولة تحويل النص إلى تاريخ
      DateTime? date;

      try {
        date = DateTime.parse(cleanDate);
      } catch (e) {
        // إذا فشل التحويل، جرب تنسيقات أخرى
        List<String> possibleFormats = [
          'yyyy-MM-dd',
          'dd/MM/yyyy',
          'MM/dd/yyyy',
          'yyyy/MM/dd',
          'dd-MM-yyyy'
        ];

        for (var format in possibleFormats) {
          try {
            date = DateFormat(format).parse(cleanDate);
            break;
          } catch (e) {
            continue;
          }
        }
      }

      if (date == null) {
        return {'day': 'N/A', 'month': 'N/A'};
      }

      // اليوم
      String day = date.day.toString();

      // الشهر بالعربي
      String monthName = DateFormat('MMM', 'en').format(date);

      return {'day': day, 'month': monthName};
    } catch (e) {
      return {'day': 'N/A', 'month': 'N/A'};
    }
  }

  ExploreViewController controller = Get.put(ExploreViewController());
  SignUpSecondaryViewController controllero =
      Get.put(SignUpSecondaryViewController('', '', '', ''));
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      drawer: CustomDrawer(),
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    screenHeight(20).ph,
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // screenWidth(20).pw,
                          InkWell(
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: InkWell(
                                  child: SvgPicture.asset(
                                      "assets/images/menu.svg"))),

                          //             SizedBox(
                          //               height: screenHeight(20),
                          //               width: screenWidth(3),
                          //               child:

                          //                  DropdownButton<String>(
                          //                   underline: Align(),
                          //                 icon: Icon(Icons.arrow_drop_down_sharp,color: AppColors.whitecolor,),
                          //                   isExpanded: true,
                          //                   hint:
                          // Text("Current Location\n New Yourk, USA",style: TextStyle(color: AppColors.whitecolor,fontWeight: FontWeight.w300)),
                          //                   value:"", // Set the selected value
                          //                   items: controller.location
                          // .map((location) {
                          //                     return DropdownMenuItem<String>(
                          // value:""
                          //     .toString(), // Use ID as the value
                          // child: Text(
                          // "", // Display the job name
                          //   style: TextStyle(
                          //       fontSize: screenWidth(25)),
                          // ),
                          //                     );
                          //                   }).toList(),
                          //                   onChanged: (String? newValue) {
                          //                     if (newValue != null) {

                          //                     }
                          //                   },
                          //                 )

                          //             )
                          // screenWidth(5).pw,
                          CircleAvatar(
                            radius: screenWidth(25),
                            child: SvgPicture.asset(
                                "assets/images/notification.svg"),
                            backgroundColor:
                                AppColors.whitecolor.withOpacity(0.5),
                          )
                        ],
                      ),
                    ),
                    screenHeight(40).ph,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //  Expanded(

                          //    child: InkWell(
                          //     onTap: (){
                          //       Get.to(SearchView());
                          //     },
                          //      child: CustomSearch(
                          //        prefixIcon: Icon(Icons.search,color: AppColors.whitecolor,),
                          //        hint: "| Search",

                          //        hintColor: AppColors.greySign, fillcolor: Colors.transparent,
                          //      ),
                          //    ),
                          //  ),
                          InkWell(
                            onTap: () {
                              Get.to(SearchView());
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: AppColors.whitecolor,
                                ),
                                screenWidth(50).pw,
                                Text("| Search")
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth(4.5),
                            height: screenHeight(40),
                            decoration: BoxDecoration(
                                color: AppColors.whitecolor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(50),
                                shape: BoxShape.rectangle),
                            child: InkWell(
                              onTap: () {
                                showFilterBottomSheet(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset("assets/images/filter.svg"),
                                  screenWidth(30).pw,
                                  Text(
                                    "Filter",
                                    style: TextStyle(
                                        color: AppColors.whitecolor,
                                        fontSize: screenWidth(30),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                width: double.infinity,
                height: screenHeight(4.5),
                decoration: ShapeDecoration(
                  color: AppColors.bluecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: screenWidth(70)),
                        child: InkWell(
                          onTap: () {
                            controller.toggleInterest(item.name!);
                          },
                          child: CustomInterestExplore(
                            svgname: item.logo!,
                            interestname: item.name!,
                            colorintrest: AppColors.orangColor,
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
            child: SizedBox(
              height: screenHeight(1.5),
              child: ListView(
                children: [
                  screenHeight(50).ph,
                  Row(
                    children: [
                      screenWidth(20).pw,
                      Text(
                        'Upcoming Events',
                        style: TextStyle(
                          color: AppColors.blacktext,
                          fontSize: screenWidth(20),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      screenWidth(2.3).pw,
                      InkWell(
                        onTap: () {
                          Get.to(AllEventView());
                        },
                        child: Row(
                          children: [
                            Text(
                              "see all",
                              style: TextStyle(
                                  color: AppColors.greySign,
                                  fontSize: screenWidth(25)),
                            ),
                            Icon(
                              Icons.arrow_right,
                              color: AppColors.greySign,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  screenHeight(50).ph,
                  Obx(() {
                    if (controller.eventUpcominList.isEmpty) {
                      return Center(
                        child: MultiDotLoader(
                            size: 40, color: AppColors.bluecolor),
                      );
                    }

                    return SizedBox(
                      height:
                          screenHeight(2.9), // تأكد من أن هذا الارتفاع مناسب
                      child: ListView.builder(
                        physics:
                            const ClampingScrollPhysics(), // تغيير نوع الفيزكس
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.eventUpcominList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = controller.eventUpcominList[index];
                          Map<String, String> result =
                              extractDayAndMonth(item.date ?? '');

                          return Container(
                            width: screenWidth(1.5), // تحديد عرض صريح لكل عنصر
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    screenWidth(80)), // تقليل المسافة الأفقية
                            child: InkWell(
                              onTap: () {
                                Get.to(
                                    EventDetailsView(id: item.id.toString()));
                              },
                              child: CustomEvent(
                                id: item.id,
                                imagename: item.image ?? '',
                                location:
                                    item.location?.crs?.properties?.name ??
                                        'Location not available',
                                eventname: item.name ?? 'Event Name',
                                going: '+${item.tickets ?? 0} Going',
                                date: '${result['day']}\n${result['month']}',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  screenHeight(50).ph,
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: screenWidth(1.5),
                      height: screenHeight(6),
                      decoration: BoxDecoration(
                          color: AppColors.skyColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          screenHeight(40).ph,
                          SizedBox(
                            width: screenWidth(1.2),
                            child: Text("Invite your friends",
                                style: TextStyle(
                                    color: AppColors.blacktext,
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth(20))),
                          ),
                          screenHeight(70).ph,
                          SizedBox(
                            width: screenWidth(1.2),
                            child: Text("Get \$20 for ticket",
                                style: TextStyle(
                                    color: AppColors.greySign,
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth(20))),
                          ),
                          CustomMainButton(
                            text: "Invite",
                            onpressed: () {},
                            width: screenWidth(3),
                            hight: screenHeight(20),
                            textcolor: AppColors.whitecolor,
                            backgroundcolor: AppColors.skyColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  screenHeight(50).ph,
                  Row(
                    children: [
                      screenWidth(20).pw,
                      Text(
                        'Nearby You',
                        style: TextStyle(
                            color: AppColors.blacktext,
                            fontSize: screenWidth(20),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  screenHeight(50).ph,
                  Obx(() {
                    if (controller.nearlyevent.isEmpty) {
                      return Center(
                        child: MultiDotLoader(
                            size: 40, color: AppColors.bluecolor),
                      );
                    }
                    return SizedBox(
                      height: screenHeight(2.9),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.nearlyevent.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = controller.nearlyevent[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth(50)),
                            child: InkWell(
                              onTap: () {
                                controller.toggleInterest(item.name!);
                              },
                              child: CustomEvent(
                                imagename: 'event1',
                                location: '36 Guild Street London, UK ',
                                eventname: 'International Band Mu...',
                                going:
                                    '+${controller.nearlyevent[index].tickets}Going',
                                date: '  10 \nJUNE',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
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
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth(50)),
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
              Text('Time & Date',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, fontSize: screenWidth(20))),
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
                              fontSize: screenWidth(20),
                              fontWeight: FontWeight.w400),
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

              // Choose from calendar
              Container(
                width: screenWidth(1.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: AppColors.greySign.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset("assets/images/events.svg",
                        color: AppColors.bluecolor),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: AppColors.whitecolor,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.all(16),
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Select Date",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () => Navigator.pop(context),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Expanded(
                                    child: Obx(() => TableCalendar(
                                          headerStyle: HeaderStyle(
                                              titleTextStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(23, 23, 100, 1),
                                            fontSize: 16,
                                          )),
                                          daysOfWeekStyle: DaysOfWeekStyle(
                                              weekdayStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    23, 23, 100, 1),
                                                fontSize: 16,
                                              ),
                                              weekendStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    23, 23, 100, 1),
                                                fontSize: 16,
                                              )),
                                          firstDay: DateTime.utc(2020, 1, 1),
                                          lastDay: DateTime.utc(2030, 12, 31),
                                          focusedDay:
                                              controller.selectedDate.value,
                                          selectedDayPredicate: (day) {
                                            return isSameDay(
                                                controller.selectedDate.value,
                                                day);
                                          },
                                          onDaySelected:
                                              (selectedDay, focusedDay) {
                                            controller.selectedDate.value =
                                                selectedDay;
                                            Navigator.pop(context);
                                          },
                                          calendarStyle: CalendarStyle(
                                            todayTextStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  23, 23, 100, 1),
                                            ),
                                            todayDecoration: BoxDecoration(
                                              color: AppColors.orangColor
                                                  .withOpacity(0.3),
                                              shape: BoxShape.circle,
                                            ),
                                            outsideDaysVisible: false,
                                            outsideDecoration: BoxDecoration(
                                              color:
                                                  Colors.grey[200], // الخلفية
                                              shape: BoxShape.circle,
                                            ),
                                            defaultDecoration: BoxDecoration(
                                              color:
                                                  Colors.grey[200], // الخلفية
                                              shape: BoxShape
                                                  .circle, // مربعات بدل دوائر
                                              // borderRadius: BorderRadius.circular(8),
                                            ),
                                            defaultTextStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  23, 23, 100, 1),
                                              fontSize: 16,
                                            ),
                                            outsideTextStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  23, 23, 100, 1),
                                              fontSize: 16,
                                            ),
                                            rangeEndDecoration: BoxDecoration(
                                              color:
                                                  Colors.grey[200], // الخلفية
                                              shape: BoxShape
                                                  .circle, // مربعات بدل دوائر
                                              // borderRadius: BorderRadius.circular(8),
                                            ),
                                            rangeEndTextStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  23, 23, 100, 1),
                                              fontSize: 16,
                                            ),
                                            selectedDecoration: BoxDecoration(
                                              color: AppColors.orangColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        'Choose from calendar',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: screenWidth(20),
                            color: AppColors.greySign),
                      ),
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
              Text('Location',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth(20),
                      color: AppColors.blacktext)),
              SizedBox(height: 10),
              Container(
                height: screenHeight(13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: AppColors.greySign.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    screenWidth(30).pw,
                    SvgPicture.asset("assets/images/location_icon.svg"),
                    SizedBox(
                      width: screenWidth(1.4),
                      height: screenHeight(20),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          icon:
                              Icon(Icons.arrow_forward_ios, color: Colors.blue),
                          isExpanded: true,
                          hint: Text("  New Yourk, USA",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenWidth(20),
                                  color: AppColors.blacktext)),
                          value: null,
                          items: controller.locations.map((location) {
                            return DropdownMenuItem<String>(
                              value: location,
                              child: Obx(() {
                                return Row(
                                  children: [
                                    Checkbox(
                                      value: controller.selectedLocations
                                          .contains(location),
                                      onChanged: (bool? value) {
                                        controller.toggleSelection(location);
                                      },
                                    ),
                                    Text(location,
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                );
                              }),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Price Range Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select price range',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth(20))),
                  Text(
                    '\$20-\$120',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: screenWidth(20),
                        color: AppColors.bluecolor),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Obx(() => RangeSlider(
                    values: RangeValues(
                        controller.minPrice.value, controller.maxPrice.value),
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
                      child: Text(
                        'RESET',
                        style: TextStyle(color: AppColors.blacktext),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whitecolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        fixedSize: Size(screenWidth(40), screenHeight(15)),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'APPLY',
                        style: TextStyle(color: AppColors.whitecolor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.bluecolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
