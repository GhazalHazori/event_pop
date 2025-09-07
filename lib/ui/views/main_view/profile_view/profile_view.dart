import 'package:flutter/material.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_event.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/customeventuser.dart';
import 'package:flutter_templat/ui/views/followers_view/followers_page.dart';
import 'package:flutter_templat/ui/views/following_view/following_page.dart';
import 'package:flutter_templat/ui/views/main_view/profile_view/profile_controller.dart';
import 'package:flutter_templat/ui/views/notification_view/notification_page.dart';
import 'package:flutter_templat/ui/views/profile+details/profile_details_view.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatefulWidget {
  final String? userId;
  MyProfilePage({this.userId});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final controller = Get.put(MyProfileController());

  @override
  void initState() {
    super.initState();
    controller.setUserId(storage.getUserId());
    controller.loadProfile(storage.getUserId());
    controller.fetcheventforuser(id: storage.getUserId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(),
                    _buildProfileSection(),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        controller.userName.value,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildStatsRow(),
                    const SizedBox(height: 24),
                    _buildInterestSection(),
                    _buildTabBar(),
                    _buildTabContent(),
                  ],
                ),
              )),
      ),
    );
  }

  Widget _buildInterestSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Interest',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Obx(() => GestureDetector(
                    onTap: _editInterests,
                    child: Text(
                      controller.isEditingInterests.value ? 'DONE' : 'CHANGE',
                      style: const TextStyle(
                        color: Color(0xFF5A6CEA),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 16),
          _buildUserInterests(),
        ],
      ),
    );
  }

  void _editInterests() {
    controller.toggleEditMode();
  }

  Widget _buildUserInterests() {
    return Obx(() {
      // Show loading indicator when interests are being loaded
      if (controller.isLoadingInterests.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      // Show user's current interests by default, and all interests in edit mode
      final interestsToShow = controller.isEditingInterests.value
          ? controller.allInterestss.map((i) => i.name).toList()
          : (controller.interestss.isNotEmpty
              ? controller.interestss.map((i) => i.name).toList()
              : ["No interests selected"]);

      // Get the list of selected interest names for highlighting
      final selectedInterestNames = controller.selectedInterests.toSet();

      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: interestsToShow.map((interest) {
          final isSelected = selectedInterestNames.contains(interest);
          final isPlaceholder = interest == "No interests selected";

          return GestureDetector(
            onTap: controller.isEditingInterests.value && !isPlaceholder
                ? () => controller.toggleInterest(interest)
                : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isPlaceholder
                    ? Colors.grey[100]
                    : (isSelected
                        ? Color(0xFF5A6CEA).withOpacity(0.1)
                        : Colors.grey[200]),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Color(0xFF5A6CEA) : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Text(
                interest,
                style: TextStyle(
                  color: isPlaceholder
                      ? Colors.grey[600]
                      : (isSelected ? Color(0xFF5A6CEA) : Colors.black87),
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontStyle:
                      isPlaceholder ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 24),
          ),
          Row(
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Center(
        child: Obx(() => Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[400],
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                  ),
                  child: controller.profileImageUrl.value.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            controller.profileImageUrl.value,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildDefaultAvatar();
                            },
                          ),
                        )
                      : _buildDefaultAvatar(),
                ),

                // ✅ اللودر أثناء التحميل
                if (controller.isUploading.value)
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),

                // 📸 زر تغيير الصورة
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      controller.pickAndUploadImage();
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5A6CEA),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  Widget _buildDefaultAvatar() {
    return const Icon(Icons.person, size: 50, color: Colors.white);
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              Get.to(FollowingPage());
            },
            child:
                _buildStatItem(controller.followersCount.value, 'Following')),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          width: 1,
          height: 40,
          color: Colors.grey[300],
        ),
        InkWell(
            onTap: () {
              Get.to(FollowersPage());
            },
            child: _buildStatItem(
                controller.followingCount.value ?? '0', 'Followers')),
      ],
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() => TabBar(
        controller: controller.tabController,
        tabs: const [Tab(text: 'ABOUT'), Tab(text: 'EVENT')],
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
      );

  Widget _buildTabContent() => Obx(() => Container(
        height: 600,
        child: TabBarView(
          controller: controller.tabController,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About Me',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(controller.aboutText.value),
                  ElevatedButton(
                      onPressed: () => _editAboutDialog(), child: Text('Edit')),
                ],
              ),
            ),
            Obx(() => controller.isEventsLoading.value
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.events.length,
                    itemBuilder: (context, index) {
                      final event = controller.events[index];
                      return CustomEventCard(
                        eventName: event.name,
                        imagePath: event.image,
                      );
                    },
                  )),
          ],
        ),
      ));

  void _changeProfilePicture() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Change Profile Picture',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                showMessage('Opening camera...');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                showMessage('Opening gallery...');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Remove Photo'),
              onTap: () {
                Navigator.pop(context);
                showMessage('Photo removed');
              },
            ),
          ],
        ),
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF5A6CEA),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _editAboutDialog() {
    final controllerLogic = Get.find<MyProfileController>();
    TextEditingController aboutController =
        TextEditingController(text: controllerLogic.aboutText.value);
    Get.defaultDialog(
      title: 'Edit About',
      content: TextField(controller: aboutController),
      textConfirm: 'Save',
      onConfirm: () {
        controllerLogic.updateAbout(
          aboutController.text,
          controllerLogic.userId.value,
          // النص الجديد اللي كتبه المستخدم
        );
        Get.back();
      },
      textCancel: 'Cancel',
    );
  }
}
