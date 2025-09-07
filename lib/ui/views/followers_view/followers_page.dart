import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'followers_controller.dart';

class FollowersPage extends StatelessWidget {
  final FollowersController controller = Get.put(FollowersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Followers'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontFamily: 'Tajawal'),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: controller.updateSearchText,
            ),
          ),
          Expanded(
            child: Obx(() {
              final followers = controller.filteredFollowers;
              if (followers.isEmpty) {
                return Center(
                  child: Text(
                    'لا يوجد متابعين بعد',
                    style: TextStyle(fontSize: 16, fontFamily: 'Tajawal'),
                  ),
                );
              }
              return ListView.separated(
                itemCount: followers.length,
                separatorBuilder: (_, __) => Divider(),
                itemBuilder: (context, index) {
                  final follower = followers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, color: Colors.grey[700]),
                    ),
                    title: Text(follower.name ?? 'No Name'),
                    subtitle: Text('${follower.followersCount ?? 0} متابع'),
                    trailing: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('متابع'),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
