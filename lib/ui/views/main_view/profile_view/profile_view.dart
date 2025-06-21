import 'package:flutter/material.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_event.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/customeventuser.dart';
import 'package:flutter_templat/ui/views/followers_view/followers_page.dart';
import 'package:flutter_templat/ui/views/following_view/following_page.dart';
import 'package:flutter_templat/ui/views/main_view/profile_view/profile_controller.dart';
import 'package:flutter_templat/ui/views/notification_view/notification_page.dart';
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
    controller.setUserId("96ebfe57-87ae-452c-b591-f37dbb0091b7");
    controller.loadProfile("96ebfe57-87ae-452c-b591-f37dbb0091b7");
    controller.fetcheventforuser(id: "96ebfe57-87ae-452c-b591-f37dbb0091b7");
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
              GestureDetector(
                onTap: _editInterests,
                child: const Text(
                  'CHANGE',
                  style: TextStyle(
                    color: Color(0xFF5A6CEA),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInterestTags(),
        ],
      ),
    );
  }

  void _editInterests() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Interests'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: controller.interests.map((interest) {
            return CheckboxListTile(
              title: Text(interest),
              value: controller.selectedInterests.contains(interest),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    controller.selectedInterests.add(interest);
                  } else {
                    controller.selectedInterests.remove(interest);
                  }
                });
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: controller.interests.map((interest) {
        final isSelected = controller.selectedInterests.contains(interest);
        Color backgroundColor;
        Color textColor;

        switch (interest) {
          case 'Games Online':
            backgroundColor = isSelected
                ? const Color(0xFF5A6CEA)
                : const Color(0xFF5A6CEA).withOpacity(0.1);
            textColor = isSelected ? Colors.white : const Color(0xFF5A6CEA);
            break;
          case 'Concert':
            backgroundColor = isSelected
                ? const Color(0xFFFF6B35)
                : const Color(0xFFFF6B35).withOpacity(0.1);
            textColor = isSelected ? Colors.white : const Color(0xFFFF6B35);
            break;
          case 'Music':
            backgroundColor = isSelected
                ? const Color(0xFFFF8C42)
                : const Color(0xFFFF8C42).withOpacity(0.1);
            textColor = isSelected ? Colors.white : const Color(0xFFFF8C42);
            break;
          case 'Art':
            backgroundColor = isSelected
                ? const Color(0xFF9B59B6)
                : const Color(0xFF9B59B6).withOpacity(0.1);
            textColor = isSelected ? Colors.white : const Color(0xFF9B59B6);
            break;
          case 'Movie':
            backgroundColor = isSelected
                ? const Color(0xFF1ABC9C)
                : const Color(0xFF1ABC9C).withOpacity(0.1);
            textColor = isSelected ? Colors.white : const Color(0xFF1ABC9C);
            break;
          default:
            backgroundColor = isSelected
                ? const Color(0xFF3498DB)
                : const Color(0xFF3498DB).withOpacity(0.1);
            textColor = isSelected ? Colors.white : const Color(0xFF3498DB);
        }

        return GestureDetector(
          onTap: () => controller.toggleInterest(interest),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              interest,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    );
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
          const SizedBox(width: 8),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.to(NotificationScreen());
                  },
                  child: Icon(Icons.notifications_active)),
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
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[400],
              border: Border.all(color: Colors.grey[300]!, width: 2),
            ),
            child: controller.profileImageUrl.value != null
                ? ClipOval(
                    child: Image.network(
                      controller.profileImageUrl.value!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultAvatar();
                      },
                    ),
                  )
                : _buildDefaultAvatar(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _changeProfilePicture,
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
      ),
    );
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
            child: _buildStatItem(
                controller.followersCount.value ?? '0', 'Following')),
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
        height: 400,
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
