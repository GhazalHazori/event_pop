import 'package:flutter_templat/core/data/models/following_model.dart';
import 'package:flutter_templat/core/data/repositories/follow_repository.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';

class FollowingController extends BaseControoler {
  final RxString searchText = ''.obs;
  final RxBool isLoading = false.obs;
  @override
  void onInit() {
    fetchFollowings(id: storage.getUserId());
    super.onInit();
  }

  void updateSearchText(String value) {
    searchText.value = value;
    // Filter followings based on search text
    if (value.isEmpty) {
      // Reset to show all followings
      fetchFollowings(id: storage.getUserId());
    } else {
      // Filter the current list
      final filtered = followings
          .where((following) => (following.name ?? '')
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
      followings.assignAll(filtered);
    }
  }

  final RxList<FolowingModel> followings = <FolowingModel>[].obs;

  Future<void> fetchFollowings({required String id}) async {
    try {
      isLoading.value = true;
      final result = await FollowRepository().getAllFollowings(id);
      result.fold(
        (error) {
          CustomToast.showMessage(
            message: error,
            messageType: MessagType.REJECTED,
          );
        },
        (fetchedFollowings) {
          followings.assignAll(fetchedFollowings);
        },
      );
    } catch (e) {
      CustomToast.showMessage(
        message: 'حدث خطأ في تحميل المتابَعين',
        messageType: MessagType.REJECTED,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
