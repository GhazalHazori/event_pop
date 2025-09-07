import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_main_button.dart'
    show CustomMainButton;
import 'package:flutter_templat/ui/shared/custom_widgets/inv_custom_widget.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/event_details_view/event_details_view_controller.dart';
import 'package:flutter_templat/ui/views/profile+details/profile_details_controller.dart';
// import 'package:flutter_templat/ui/views/first_payment_view/first_payment_view.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class EventDetailsView extends StatefulWidget {
  final String id;
  const EventDetailsView({super.key, required this.id});

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  late EventdetailsControllre controllre;
  ProfileDetailscontroller profcon = Get.put(ProfileDetailscontroller());
  @override
  @override
  void initState() {
    super.initState();
    controllre = EventdetailsControllre(widget.id);
    controllre.getDetailsEvent(id: widget.id);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controllre.eventdetails.value == null
            ? CircleAvatar()
            : Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        "assets/images/event_details.png",
                        width: screenWidth(1),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight(20)),
                        child: Row(
                          children: [
                            screenWidth(20).pw,
                            Icon(
                              Icons.arrow_back_outlined,
                              color: AppColors.blacktext,
                            ),
                            screenWidth(20).pw,
                            Text(
                              "Event Details",
                              style: TextStyle(
                                  color: AppColors.blacktext,
                                  fontSize: screenWidth(20)),
                            ),
                            screenWidth(2.5).pw,
                            Container(
                                width: screenWidth(10),
                                height: screenHeight(20),
                                decoration: BoxDecoration(
                                    color:
                                        AppColors.whitecolor.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(10)),
                                child: SvgPicture.asset(
                                  "assets/images/save.svg",
                                  fit: BoxFit.none,
                                )),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 30,
                        left: 30,
                        bottom: -screenHeight(35),
                        child: Container(
                          height: screenHeight(12),
                          decoration: BoxDecoration(
                              color: AppColors.whitecolor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Row(
                            children: [
                              screenWidth(3.5).pw,
                              Text(
                                  "+${controllre.eventdetails.value.tickets ?? ''} Going",
                                  style: TextStyle(
                                      color: AppColors.bluecolor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenWidth(25))),
                              screenHeight(40).ph,
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth(40)),
                                child: CustomMainButton(
                                  text: "Invite",
                                  onpressed: () {
                                    showInviteFriendsBottomSheet(context);
                                  },
                                  width: screenWidth(4),
                                  hight: screenHeight(20),
                                  textcolor: AppColors.whitecolor,
                                  backgroundcolor: AppColors.bluecolor,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  screenHeight(10).ph,
                  SizedBox(
                      width: screenWidth(1.11),
                      child: Text('International Band \nMusic Concert',
                          style: TextStyle(
                              color: AppColors.blacktext,
                              fontWeight: FontWeight.w400,
                              fontSize: screenWidth(10)))),
                  screenHeight(40).ph,
                  SizedBox(
                    width: screenWidth(1.11),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth(7),
                          height: screenHeight(17),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: AppColors.skyopcityColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/images/events.svg",
                              color: AppColors.bluecolor,
                            ),
                          ),
                        ),
                        screenWidth(20).pw,
                        Column(
                          children: [
                            Text("${controllre.eventdetails.value.date}",
                                style: TextStyle(
                                  color: AppColors.blacktext,
                                  fontWeight: FontWeight.w300,
                                  fontSize: screenWidth(25),
                                )),
                            Text("${controllre.eventdetails.value.time}",
                                style: TextStyle(
                                  color: AppColors.greySign,
                                  fontWeight: FontWeight.w300,
                                  fontSize: screenWidth(25),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  screenHeight(30).ph,
                  SizedBox(
                    width: screenWidth(1.11),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth(7),
                          height: screenHeight(17),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: AppColors.skyopcityColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/images/location.svg",
                              color: AppColors.bluecolor,
                            ),
                          ),
                        ),
                        screenWidth(20).pw,
                        Column(
                          children: [
                            Text(
                                "${controllre.eventdetails.value.location?.crs?.properties?.name}",
                                style: TextStyle(
                                  color: AppColors.blacktext,
                                  fontWeight: FontWeight.w300,
                                  fontSize: screenWidth(25),
                                )),
                            Text(
                                "${controllre.eventdetails.value.location!.crs!.properties!.name} ",
                                style: TextStyle(
                                  color: AppColors.greySign,
                                  fontWeight: FontWeight.w300,
                                  fontSize: screenWidth(25),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  screenHeight(30).ph,
                  SizedBox(
                    width: screenWidth(1.11),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth(7),
                          height: screenHeight(17),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: AppColors.whitecolor.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            child: Image.asset(
                              "assets/images/person_follow.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        screenWidth(20).pw,
                        Column(
                          children: [
                            Text(
                                controllre.eventdetails.value.user!.name ??
                                    "inas",
                                style: TextStyle(
                                  color: AppColors.blacktext,
                                  fontWeight: FontWeight.w300,
                                  fontSize: screenWidth(25),
                                )),
                            Text("Organizer ",
                                style: TextStyle(
                                  color: AppColors.greySign,
                                  fontWeight: FontWeight.w300,
                                  fontSize: screenWidth(25),
                                ))
                          ],
                        ),
                        screenWidth(4.4).pw,
                        CustomMainButton(
                          text: "Follow",
                          onpressed: () {
                            profcon.toggleFollow(
                                controllre.eventdetails.value.user!.id!);
                          },
                          width: screenWidth(4),
                          hight: screenHeight(20),
                          textcolor: AppColors.bluecolor,
                          backgroundcolor:
                              AppColors.skyopcityColor.withOpacity(0.5),
                        )
                      ],
                    ),
                  ),
                  screenHeight(30).ph,
                  SizedBox(
                    width: screenWidth(1.11),
                    child: Text("About Event",
                        style: TextStyle(
                          color: AppColors.blacktext,
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth(15),
                        )),
                  ),
                  screenHeight(90).ph,
                  SizedBox(
                    width: screenWidth(1.11),
                    child: Text("${controllre.eventdetails.value.description}",
                        style: TextStyle(
                          color: AppColors.blacktext,
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth(20),
                        )),
                  ),
                  screenHeight(30).ph,
                  CustomMainButton(
                    text: "Buy Ticket \$120",
                    onpressed: () {
                      // Get.to(FirstPaymentView(
                      //     id: controllre.eventdetails.value.id.toString()));
                    },
                    textfontwieght: FontWeight.w500,
                    svgname: "circle_arrow",
                    backgroundcolor: AppColors.bluecolor,
                    width: screenWidth(1.3),
                    hight: screenHeight(15),
                  ),
                ],
              );
      }),
    );
  }
}
