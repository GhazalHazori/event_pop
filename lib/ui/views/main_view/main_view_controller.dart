import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_templat/core/data/repositories/shared_preference_repository.dart';
import 'package:flutter_templat/core/enums/bottom_navigation_enum.dart';
import 'package:flutter_templat/core/services/base_controller.dart';


import 'package:flutter_templat/ui/views/main_view/main_view_widget/bottom_navigation_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

class maincontroller extends BaseControoler {
  RxBool isVisitor = false.obs;
  maincontroller(isV) {
    isVisitor = isV;
  }
  @override
  void onInit() async {
    // Get.put(NotificationServicePrivate());
    // try {
    //   await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform,
    //   );
    // } catch (e) {
    //   print(e);
    // }

    // TODO: implement onInit
    super.onInit();
  }
  // BottomNavigationWidget getBottomNavigation() {
  //   BottomNavigationWidget bottomnav;
  //   bottom
  //  Get.put(NotificationServicePrivate());nav = BottomNavigationWidget(
  //     navitm: selected,
  //     ontap: (select, pagenumber) {
  //       controller.jumpToPage(pagenumber);

  //       selected = select;
  //     },
  //   );
  //   return bottomnav;
  // }
}
