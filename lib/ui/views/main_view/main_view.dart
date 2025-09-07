import 'dart:async';
import 'dart:collection';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/core/enums/bottom_navigation_enum.dart';

import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';

import 'package:flutter_templat/ui/shared/custom_widgets/custom_drawer.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/Map_view/map_view.dart';
import 'package:flutter_templat/ui/views/main_view/add_event/add_event_view.dart';
import 'package:flutter_templat/ui/views/main_view/events_view/events_view.dart';
import 'package:flutter_templat/ui/views/main_view/explore_view/explore_view.dart';
import 'package:flutter_templat/ui/views/main_view/main_view_widget/bottom_navigation_widget.dart'
    show BottomNavigationWidget;
import 'package:flutter_templat/ui/views/main_view/profile_view/profile_view.dart';

import 'package:flutter_templat/ui/views/sign_up_view/sign_up_view.dart';
import 'package:get/get.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  PageController controller = PageController(initialPage: 0);
  BottomNavigationEnum selected = BottomNavigationEnum.EXPLOR;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.page?.round() != 3) {
          // 3 is the index for Home page
          controller.jumpToPage(3);
          return false;
        }
        return true;
      },
      child: Scaffold(
        drawer: CustomDrawer(),
        resizeToAvoidBottomInset: false,
        floatingActionButton: InkWell(
          onTap: () {
            Get.to(() => AddEventScreen());
          },
          child: CircleAvatar(
              backgroundColor: AppColors.bluecolor.withOpacity(0.9),
              radius: screenWidth(14),
              child: Icon(
                Icons.add_box,
                color: AppColors.whitecolor,
                size: screenWidth(16),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        key: key,
        bottomNavigationBar: BottomNavigationWidget(
            navitm: selected,
            ontap: (select, pagenumber) {
              controller.jumpToPage(pagenumber);

              setState(() {
                selected = select;
              });
            }),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            ExploreView(),
            EventsView(),
            MapVieww(),
            MyProfilePage(),
          ],
        ),
      ),
    );
  }
}
