import 'package:flutter/material.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/customeventuser.dart';
import 'package:get/get.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_event.dart';
import 'package:flutter_templat/ui/views/followers_view/followers_page.dart';
import 'package:flutter_templat/ui/views/following_view/following_page.dart';
import 'package:flutter_templat/ui/views/notification_view/notification_page.dart';
import 'package:flutter_templat/ui/views/profile+details/profile_details_controller.dart';

class ProfileDetailsView extends StatefulWidget {
  final String? userId;
  const ProfileDetailsView({this.userId});

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView>
    with SingleTickerProviderStateMixin {
  late final ProfileDetailscontroller controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileDetailscontroller());
    controller.setUserId(widget.userId ?? storage.getUserId());
    controller.loadProfile(controller.userId.value);
    controller.fetcheventforuser(id: controller.userId.value);
  }

  @override
  void dispose() {
    controller.tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(),
                    _buildProfileSection(),
                    const SizedBox(height: 10),
                    Text(
                      controller.userName.value,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildStatsRow(),
                    const SizedBox(height: 24),
                    _buildActionButtons(),
                    _buildTabBar(),
                    _buildTabContent(),
                  ],
                ),
              )),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 24),
          ),
          const Spacer(),
          InkWell(
            onTap: () => Get.to(() => NotificationScreen()),
            child: const Icon(Icons.notifications_active),
          ),
          const SizedBox(width: 8),
          const Text(
            'Profile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[400],
            backgroundImage: controller.profileImageUrl.value != null
                ? NetworkImage(controller.profileImageUrl.value!)
                : null,
            child: controller.profileImageUrl.value == null
                ? const Icon(Icons.person, size: 50, color: Colors.white)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Get.to(() => FollowingPage()),
          child: _buildStatItem(
              controller.followingCount.value ?? '0', 'Following'),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          width: 1,
          height: 40,
          color: Colors.grey[300],
        ),
        InkWell(
          onTap: () => Get.to(() => FollowersPage()),
          child: _buildStatItem(
              controller.followersCount.value ?? '0', 'Followers'),
        ),
      ],
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => ElevatedButton.icon(
                  onPressed: () =>
                      controller.toggleFollow(controller.userId.value),
                  icon: Icon(
                    controller.isFollowing.value
                        ? Icons.check
                        : Icons.person_add,
                    color: Colors.white,
                  ),
                  label: Text(
                    controller.isFollowing.value ? 'Following' : 'Follow',
                    style: const TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isFollowing.value
                        ? Colors.grey
                        : const Color(0xFF5A6CEA),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: TabBar(
        controller: controller.tabController,
        tabs: const [Tab(text: 'ABOUT'), Tab(text: 'EVENT')],
        labelColor: const Color(0xFF5A6CEA),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF5A6CEA),
      ),
    );
  }

  Widget _buildTabContent() {
    return Obx(() => SizedBox(
          height: 400,
          child: TabBarView(
            controller: controller.tabController,
            children: [
              _buildAboutTab(),
              _buildEventTab(),
            ],
          ),
        ));
  }

  Widget _buildAboutTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('About Me', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(controller.aboutText.value),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildEventTab() {
    return Obx(() => controller.isEventsLoading.value
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: controller.events.length,
            itemBuilder: (context, index) {
              final event = controller.events[index];
              return CustomEventCard(
                eventName: event.name,
                imagePath: event.image,
              );
            },
          ));
  }
}
