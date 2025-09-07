// controller/my_profile_controller.dart

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_templat/core/data/models/apis/all_interest_model.dart';
import 'package:flutter_templat/core/data/models/apis/eventt_modell.dart';
import 'package:flutter_templat/core/data/models/apis/interest_model.dart';
import 'package:flutter_templat/core/data/network/network_config.dart';
import 'package:flutter_templat/core/data/repositories/interest_repository.dart';
import 'package:flutter_templat/core/data/repositories/profile_repository.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/core/utils/network_util.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as RequestType;
import 'package:image_picker/image_picker.dart';

class MyProfileController extends BaseControoler
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxString userId = storage.getUserId().obs;
  void setUserId(String id) {
    userId.value = id;
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    loadProfile(userId.value);
    fetcheventforuser(id: userId.value);
    fetchInterestsForUser(id: userId.value);
    getAllInterests();
    super.onInit();
  }

  var isUploading = false.obs;
  var profileImageUrl = ''.obs;

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final file = File(picked.path);
      isUploading.value = true;

      final response = await NetworkUtil.sendMultipartRequest(
        url: '/api/profile/image/${userId.value}',
        headers: {
          'Authorization': 'Bearer ${storage.getTokenInfo()?.accessToken}',
        },
        files: {
          'image': file.path,
        },
      );

      isUploading.value = false;

      if (response != null && response['statusCode'] == 200) {
        final imageUrl = response['response']['image'];
        profileImageUrl.value = imageUrl;
        showMessage("✅ Uploaded successfully");
      } else {
        showMessage("❌ Upload failed");
      }
    }
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

  RxString aboutText = 'No bio yet.'.obs;

  RxList<String> selectedInterests = <String>[].obs;
  RxBool isEditingInterests = false.obs;
  RxBool isLoadingInterests = false.obs;
  RxList<String> allInterests = <String>[
    'Games Online',
    'Concert',
    'Music',
    'Art',
    'Movie',
    'Others',
  ].obs;

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
  }

  void toggleEditMode() async {
    try {
      isEditingInterests.toggle();
      if (isEditingInterests.value) {
        // Load all interests when entering edit mode
        isLoadingInterests.value = true;
        await getAllInterests();
      } else {
        // Save changes when exiting edit mode
        await saveInterests();
      }
    } catch (e) {
      CustomToast.showMessage(
        message: 'حدث خطأ أثناء تحديث الاهتمامات',
        messageType: MessagType.REJECTED,
      );
    } finally {
      isLoadingInterests.value = false;
    }
  }

  final ProfileRepository _profileRepository = ProfileRepository();

  Future<void> saveInterests() async {
    if (selectedInterests.isEmpty) return;
    
    isLoadingInterests.value = true;
    try {
      // Get the IDs of the selected interests
      final selectedIds = allInterestss
          .where((interest) => selectedInterests.contains(interest.name))
          .map((interest) => interest.id)
          .toList();

      final result = await _profileRepository.updateInterestForUser(
        selectedIds,
        storage.getUserId(),
      );

      result.fold(
        (error) => CustomToast.showMessage(
          message: error,
          messageType: MessagType.REJECTED,
        ),
        (success) async {
          CustomToast.showMessage(
            message: 'تم تحديث الاهتمامات بنجاح',
            messageType: MessagType.INFO,
          );
          // Refresh user interests after update
          await fetchInterestsForUser(id: storage.getUserId());
        },
      );
    } catch (e) {
      CustomToast.showMessage(
        message: 'حدث خطأ أثناء تحديث الاهتمامات',
        messageType: MessagType.REJECTED,
      );
    } finally {
      isLoadingInterests.value = false;
    }
  }

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

// RxList للاهتمامات
  RxList<Interest> interestss = <Interest>[].obs;

  Future<void> fetchInterestsForUser({required String id}) async {
    final result = await InterestRepository().getInterests(id);
    result.fold(
      (error) {
        CustomToast.showMessage(
          message: error,
          messageType: MessagType.REJECTED,
        );
      },
      (interests) {
        interestss.value = interests;
      },
    );
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

  RxList<AllInterest> allInterestss = <AllInterest>[].obs;
  getAllInterests() {
    runLoadingFutureFunction(
      function: InterestRepository().getAllInterests().then(
        (value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                  message: l, messageType: MessagType.REJECTED);
            },
            (r) {
              allInterestss.value = r;
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

  void updateInterests(
    List<int> updatedInterests,
    String userId,
  ) {
    _profRepository
        .updateInterestForUser(updatedInterests, storage.getUserId())
        .then((value) {
      value.fold(
        (error) {
          showMessage(error);
        },
        (message) {
          showMessage(message);
          fetchInterestsForUser(id: storage.getUserId());
        },
      );
    });
  }

  // ✅ تبديل الاهتمام - This method is now defined earlier in the file

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
