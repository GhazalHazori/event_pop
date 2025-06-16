import 'dart:convert';

import 'package:flutter_templat/core/data/models/cart_model.dart';
import 'package:get/get.dart';

import 'package:flutter_templat/core/data/models/apis/token_info.dart';
import 'package:flutter_templat/core/enums/data_type.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceRepository {
  SharedPreferences globalSharedPrefs = Get.find();
  String PREF_FIRST_LUNCH = 'first_lunch';
  String PREF_IS_LOGEED = 'is_logeed';
  String PREF_TOKEN_INFO = 'token_info';
  String PREF_APP_LANG = 'aspp_langauge';
  String PREF_CART_LIST = 'cart_list';
  String PREF_ORDER_PLACED = 'order_placed';
  String PREF_SUB_STATUS = 'sub_status';
String FCM_TOKEN = 'fcm_token';
  setFirstLunch(bool value) {
    setPreferance(dataType: DataType.BOOL, key: PREF_FIRST_LUNCH, value: value);
  }

  setIsLoggedIn(bool value) {
    setPreferance(dataType: DataType.BOOL, key: PREF_IS_LOGEED, value: value);
  }

  bool getLogeedIn() {
    if (globalSharedPrefs.containsKey(PREF_IS_LOGEED)) {
      return getpreferance(key: PREF_IS_LOGEED);
    } else
      return false;
  }

  setOrderPlaced(bool value) {
    setPreferance(
      dataType: DataType.BOOL,
      key: PREF_ORDER_PLACED,
      value: value,
    );
  }

  bool getOrderPlaced() {
    if (globalSharedPrefs.containsKey(PREF_ORDER_PLACED)) {
      return getpreferance(key: PREF_ORDER_PLACED);
    } else {
      return false;
    }
  }

  setIsAppLangauge(String value) {
    setPreferance(dataType: DataType.STRING, key: PREF_APP_LANG, value: value);
  }

  String getAppLangauge() {
    if (globalSharedPrefs.containsKey(PREF_APP_LANG)) {
      return getpreferance(key: PREF_APP_LANG);
    } else
      return 'tr';
  }
  setFcmToken(String value) {
    setPreferance(dataType: DataType.STRING, key: FCM_TOKEN, value: value);
  }

  String getFcmToken() {
    if (globalSharedPrefs.containsKey(FCM_TOKEN)) {
      return getpreferance(key: FCM_TOKEN);
    } else
      return '';
  }

  bool getFirstLunch() {
    if (globalSharedPrefs.containsKey(PREF_FIRST_LUNCH))
      return getpreferance(key: PREF_FIRST_LUNCH);
    else
      return true;
  }

  setTokenInfo(TokenInfo value) {
    setPreferance(
      dataType: DataType.STRING,
      key: PREF_TOKEN_INFO,
      value: jsonEncode(value),
    );
  }

  TokenInfo? getTokenInfo() {
    if (globalSharedPrefs.containsKey(PREF_TOKEN_INFO)) {
      return TokenInfo.fromJson(
          jsonDecode(getpreferance(key: PREF_TOKEN_INFO)));
    } else {
      return null;
    }
  }

  void setCartList(List<CartModel> list) {
    setPreferance(
        dataType: DataType.STRING,
        key: PREF_CART_LIST,
        value: CartModel.encode(list));
  }

  List<CartModel> getCartList() {
    if (globalSharedPrefs.containsKey(PREF_CART_LIST)) {
      return CartModel.decode(getpreferance(key: PREF_CART_LIST));
    } else {
      return [];
    }
  }

  void setSubStatus(bool value) {
    setPreferance(
      dataType: DataType.BOOL,
      key: PREF_SUB_STATUS,
      value: value,
    );
  }

  bool getSubStatus() {
    if (Get.find<SharedPreferences>().containsKey(PREF_SUB_STATUS)) {
      return getpreferance(key: PREF_SUB_STATUS);
    } else {
      return true;
    }
  }

  setPreferance(
      {required DataType dataType,
      required String key,
      required dynamic value}) async {
    switch (dataType) {
      case DataType.INt:
        await globalSharedPrefs.setInt(key, value);
        break;
      case DataType.BOOL:
        await globalSharedPrefs.setBool(key, value);
        break;
      case DataType.DOUBLE:
        await globalSharedPrefs.setDouble(key, value);
        break;
      case DataType.STRING:
        await globalSharedPrefs.setString(key, value);
        break;
      case DataType.LISTSTRING:
        await globalSharedPrefs.setStringList(key, value);
        break;
    }
  }

  dynamic getpreferance({required String key}) {
    return globalSharedPrefs.get(key);
  }
}
