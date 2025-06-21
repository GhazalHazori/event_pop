import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_templat/core/enums/bottom_navigation_enum.dart';

import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/main.dart';
import 'package:flutter_templat/ui/shared/colors.dart';

import 'package:flutter_templat/ui/shared/custom_widgets/custom_drawer.dart';
import 'package:flutter_templat/ui/shared/utlis.dart';
import 'package:flutter_templat/ui/views/main_view/add_event/add_event_view.dart';
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
  PageController controller = PageController(initialPage: 3);
  BottomNavigationEnum selected = BottomNavigationEnum.EXPLOR;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  // @override
  // void initState() {
//   super.initState();
  //   notificationService = NotificationServicePrivate(
  //     onPrivateNotificationUpdate: updatePrivateNotificationBadge,
  //   );
  // }

  // void updatePrivateNotificationBadge() {
  //   privateNotificationCount.value =
  //       notificationService.unreadNotificationsPrivate;
  // }
  // var _tag = "MyApp";
  // var _myLogFileName = "MyLogFile";
  // var toggle = false;
  // var logStatus = '';
  // static Completer _completer = new Completer<String>();

  // @override
  // void initState() {
  //   super.initState();
  //   setUpLogs();
  // }

  // void setUpLogs() async {
  //   await FlutterLogs.initLogs(
  //       logLevelsEnabled: [
  //         LogLevel.INFO,
  //         LogLevel.WARNING,
  //         LogLevel.ERROR,
  //         LogLevel.SEVERE
  //       ],
  //       timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
  //       directoryStructure: DirectoryStructure.FOR_DATE,
  //       logTypesEnabled: [_myLogFileName],
  //       logFileExtension: LogFileExtension.LOG,
  //       logsWriteDirectoryName: "MyLogs",
  //       logsExportDirectoryName: "MyLogs/Exported",
  //       debugFileOperations: true,
  //       isDebuggable: true,
  //       enabled: true);

  //   // [IMPORTANT] The first log line must never be called before 'FlutterLogs.initLogs'
  //   FlutterLogs.logInfo(_tag, "setUpLogs", "setUpLogs: Setting up logs..");

  //   // Logs Exported Callback
  //   FlutterLogs.channel.setMethodCallHandler((call) async {
  //     if (call.method == 'logsExported') {
  //       // Contains file name of zip
  //       FlutterLogs.logInfo(
  //           _tag, "setUpLogs", "logsExported: ${call.arguments.toString()}");

  //       // setLogsStatus(
  //       //     status: "logsExported: ${call.arguments.toString()}", append: true);

  //       // Notify Future with value
  //       _completer.complete(call.arguments.toString());
  //     } else if (call.method == 'logsPrinted') {
  //       FlutterLogs.logInfo(
  //           _tag, "setUpLogs", "logsPrinted: ${call.arguments.toString()}");

  //       // setLogsStatus(
  //       //     status: "logsPrinted: ${call.arguments.toString()}", append: true);
  //     }
  //   });
  // }

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
          onTap: () {},
          child: CircleAvatar(
              backgroundColor: AppColors.bluecolor.withOpacity(0.9),
              radius: screenWidth(14),
              child: InkWell(
                  onTap: () {
                    Get.to(AddEventScreen());
                  },
                  child: Icon(
                    Icons.add_box,
                    color: AppColors.whitecolor,
                    size: screenWidth(16),
                  ))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        key: key,
        bottomNavigationBar: BottomNavigationWidget(
            navitm: selected, ontap: (select, pagenumber) {}),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [ExploreView(), MyProfilePage()],
        ),
      ),
    );
  }
}
