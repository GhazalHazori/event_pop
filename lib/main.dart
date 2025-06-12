// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_templat/core/data/repositories/shared_preference_repository.dart';
// import 'package:flutter_templat/core/services/cart_service.dart';
// import 'package:flutter_templat/core/services/connectivity_service.dart';
// import 'package:flutter_templat/core/services/location_services.dart';
// import 'package:flutter_templat/firebase_options.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'app/my_app.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Get.putAsync(() async {
//     var sharedPref = SharedPreferences.getInstance();
//     return sharedPref;
//   });
//   Get.put(SharedPrefrenceRepository());
//   Get.put(CartService());
//   Get.put(ConnectivityService());
//   Get.put(LocationService());
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     final fcmToken = await FirebaseMessaging.instance.getToken();
//     print(fcmToken);
//     FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
//       // TODO: If necessary send token to application server.

//       // Note: This callback is fired at each app startup and whenever a new
//       // token is generated.
//     }).onError((err) {
//       // Error getting token.
//     });
//     if (GetPlatform.isIOS) {
//       FirebaseMessaging messaging = FirebaseMessaging.instance;

//       NotificationSettings settings = await messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//     }
//     //*when app in foreground

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');

//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//       }
//     });

//   } catch (e) {
//     print(e);
//   }
//   runApp(MyApp());
// }

// extension EmptyPadding on num {
//   SizedBox get ph => SizedBox(
//         height: toDouble(),
//       );
//   SizedBox get pw => SizedBox(
//         width: toDouble(),
//       );
// }

// //fit:boxfit.cover
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_templat/firebase_options.dart';

import 'package:get/get.dart';
import 'package:flutter_templat/app/my_app.dart';
import 'package:flutter_templat/app/my_app_controller.dart';
import 'package:flutter_templat/core/services/cart_service.dart';
import 'package:flutter_templat/core/services/connectivity_service.dart';
import 'package:flutter_templat/core/services/location_services.dart';
import 'package:flutter_templat/core/services/notification_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/data/repositories/shared_preference_repository.dart';

//SharedPreferences? globalSharedPreferenc;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //globalSharedPreferenc = await SharedPreferences.getInstance();
  await Get.putAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });

  Get.put(SharedPrefrenceRepository());
  Get.put(CartService());
  Get.put(LocationService());
  Get.put(ConnectivityService());
  Get.put(MyAppContoller());

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    Get.put(NotificationService());
  } catch (e) {
    print(e);
  }

  runApp(const MyApp());
}

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}
