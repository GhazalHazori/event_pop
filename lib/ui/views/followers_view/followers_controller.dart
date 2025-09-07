import 'package:flutter_templat/core/data/models/following_model.dart';
import 'package:flutter_templat/core/data/repositories/follow_repository.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';

class FollowersController extends BaseControoler {
  final RxString searchText = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<FolowingModel> followers = <FolowingModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFollowers(id: storage.getUserId());
  }

  List<FolowingModel> get filteredFollowers {
    if (searchText.value.isEmpty) {
      return followers;
    } else {
      return followers
          .where((follower) => (follower.name ?? '')
              .toLowerCase()
              .contains(searchText.value.toLowerCase()))
          .toList();
    }
  }

  void updateSearchText(String value) {
    searchText.value = value;
  }

  Future<void> fetchFollowers({required String id}) async {
    try {
      isLoading.value = true;
      final result = await FollowRepository().getAllFollowers(id);
      result.fold(
        (error) {
          CustomToast.showMessage(
            message: error,
            messageType: MessagType.REJECTED,
          );
        },
        (fetchedFollowers) {
          followers.assignAll(fetchedFollowers);
        },
      );
    } catch (e) {
      CustomToast.showMessage(
        message: 'حدث خطأ في تحميل المتابِعين',
        messageType: MessagType.REJECTED,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
