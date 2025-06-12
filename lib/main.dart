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

  // try {
  //   await Firebase.initializeApp(
  //     // options: DefaultFirebaseOptions.currentPlatform,
  //   );

  //   Get.put(NotificationService());
  // } catch (e) {
  //   print(e);
  // }

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
