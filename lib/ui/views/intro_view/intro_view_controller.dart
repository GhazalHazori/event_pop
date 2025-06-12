


import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:get/get.dart';

class IntroController extends BaseControoler {
  RxInt currentIndex = 0.obs;

  void incrementIndex() {
    if (currentIndex != 2) {
      currentIndex += 1;
    } else {
      currentIndex = 0.obs;
    }
  }

  void decrementIndex() {
    if (currentIndex != 2) {
      currentIndex -= 1;
    } else {
      currentIndex = 0.obs;
    }
  }

  bool isLastIndex() {
    return currentIndex == 2;
  }
}
