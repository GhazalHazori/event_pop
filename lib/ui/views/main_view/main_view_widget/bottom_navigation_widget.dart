import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/core/enums/bottom_navigation_enum.dart';

import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';

import 'package:flutter_templat/ui/shared/utlis.dart';

import 'package:get/get.dart';

class BottomNavigationWidget extends StatefulWidget {
  final BottomNavigationEnum navitm;
  final Function(BottomNavigationEnum, int) ontap;
  final String? count;
  const BottomNavigationWidget(
      {super.key, required this.navitm, required this.ontap, this.count});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override

  

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        // SvgPicture.asset(
        //   'assets/imagesbg_bottom_navigation.svg',
        //   fit: BoxFit.fitWidth,
        // ),
        Container(
          width: screenWidth(1),
          height: screenHeight(12),

          decoration: BoxDecoration(
            color: AppColors.whitecolor,
            // border: Border(top: BorderSide(color: AppColors.maingreen)
            // )
          ),

          // padding: EdgeInsets.only(top: 40),
        ),
        Positioned(
          left: screenWidth(150),
          right: screenWidth(150),
          bottom: screenHeight(80),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth(40)),
            child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    navItem(
                        ontap: () {
                          widget.ontap(BottomNavigationEnum.EXPLOR, 0);
                        },
                        size: size,
                        imagename: 'explore',
                        width: screenWidth(13),
                        isslected:
                            widget.navitm == BottomNavigationEnum.EXPLOR,
                        text: 'Explore'),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        navItem(
                            ontap: () {
                              widget.ontap(BottomNavigationEnum.EVENTS, 1);
                             
                            },
                            size: size,
                            imagename: 'events',
                            width: screenWidth(13),
                            isslected:
                                widget.navitm == BottomNavigationEnum.EVENTS,
                            text: 'Events'),
                       
                      ],
                    ),
                    screenWidth(10).pw,
                    navItem(
                        ontap: () {
                          widget.ontap(BottomNavigationEnum.MAP, 2);
                        },
                        size: size,
                        imagename: 'map',
                        width: screenWidth(13),
                        isslected: widget.navitm == BottomNavigationEnum.MAP,
                        text: 'Map'),
                    navItem(
                        ontap: () {
                          widget.ontap(BottomNavigationEnum.PROFILE, 3);
                        },
                        size: size,
                        width: screenWidth(13),
                        imagename: 'profile',
                        isslected: widget.navitm == BottomNavigationEnum.PROFILE,
                        text: 'Profile')
                  ]),
            ),
          ),
        ),
        // Positioned(
        //   bottom: screenHeight(70),
        //   child:
        // ),
      ],
    );
  }

  Widget navItem(
      {required Size size,
      required String imagename,
      required bool isslected,
      required String text,
      required Function ontap,
      double? width}) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/$imagename.svg',
            width: width,
        color: isslected ? AppColors.bluecolor : AppColors.greySign,
          ),
          screenHeight(200).ph,
          Text(
            "${text}",
            style: TextStyle(
                color: isslected ? AppColors.bluecolor : AppColors.greySign,
              
                fontSize: screenWidth(35)),
          )
        ],
      ),
    );
  }
}
