// controller/my_profile_controller.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_templat/core/data/models/apis/eventt_modell.dart';
import 'package:flutter_templat/core/data/repositories/profile_repository.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';

class MyProfileController extends BaseControoler
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxString userId = "96ebfe57-87ae-452c-b591-f37dbb0091b7".obs;
  void setUserId(String id) {
    userId.value = id;
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    loadProfile(userId.value);
    fetcheventforuser(id: userId.value);
    super.onInit();
  }

  RxList<String> interests = <String>[
    'Games Online',
    'Concert',
    'Music',
    'Art',
    'Movie',
    'Others',
  ].obs;

  // 🔹 القيم المتغيرة
  RxBool isLoading = false.obs;
  RxBool isEventsLoading = false.obs;

  RxString userName = ''.obs;
  RxString followingCount = '0'.obs;
  RxString followersCount = '0'.obs;
  RxString profileImageUrl = ''.obs;
  RxString aboutText = 'No bio yet.'.obs;

  RxList<String> selectedInterests = <String>[].obs;

  final ProfileRepository _profRepository = ProfileRepository();

  // ✅ تحميل بيانات المستخدم
  void loadProfile(String userId) {
    isLoading.value = true;

    _profRepository.fetchProfileData(userId).then((value) {
      value.fold(
        (error) {
          showMessage(error);
        },
        (data) {
          userName.value = data['name'] ?? 'No name';
          followingCount.value = data['followingCount']?.toString() ?? '0';
          followersCount.value = data['followersCount']?.toString() ?? '0';
          profileImageUrl.value = data['image'] ?? '';
          aboutText.value = data['about'] ?? 'No bio yet.';
          selectedInterests.value = List<String>.from(
            (data['interests'] as List<dynamic>?)
                    ?.map((e) => e['name'] as String) ??
                [],
          );
        },
      );
      isLoading.value = false;
    });
  }

  // ✅ تحميل الأحداث الخاصة بالمستخدم
  RxList<EventModel> events = <EventModel>[].obs;
  //fea

  fetcheventforuser({required String id}) {
    runLoadingFutureFunction(
      function: ProfileRepository().geteventforuser(id: id).then(
        (value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                  message: l, messageType: MessagType.REJECTED);
            },
            (r) {
              events.value = r;
            },
          );
        },
      ),
    );
  }

  // ✅ تحديث النبذة الشخصية
  void updateAbout(
    String newAbout,
    String userId,
  ) {
    _profRepository.updateAboutText(newAbout, userId).then((value) {
      value.fold(
        (error) {
          showMessage(error);
        },
        (message) {
          aboutText.value = newAbout;
          showMessage(aboutText.value);
        },
      );
    });
  }

  // ✅ تبديل الاهتمام
  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
  }

  // Dialog لتعديل الاهتمامات
  void editInterestsDialog(List<String> interests) {
    Get.defaultDialog(
      title: 'Edit Interests',
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: interests.map((interest) {
            return Obx(() => CheckboxListTile(
                  title: Text(interest),
                  value: selectedInterests.contains(interest),
                  onChanged: (_) => toggleInterest(interest),
                ));
          }).toList(),
        ),
      ),
      textConfirm: 'Done',
      onConfirm: () => Get.back(),
    );
  }

  // عرض رسالة (Snackbar)
  void showMessage(String message) {
    Get.snackbar('Info', message,
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 3));
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
