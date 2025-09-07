import 'package:flutter/material.dart';
import 'package:flutter_templat/ui/views/following_view/following_controller.dart';
import 'package:get/get.dart';

class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  final FollowingController controller = Get.put(FollowingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Following"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                controller.updateSearchText(value);
              },
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.followings.isEmpty) {
                return Center(
                  child: Text(
                    'لا يوجد متابعين بعد',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.followings.length,
                itemBuilder: (context, index) {
                  final following = controller.followings[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: following.image != null
                            ? NetworkImage(following.image!)
                            : null,
                        child: following.image == null
                            ? Icon(Icons.person, color: Colors.grey[700])
                            : null,
                      ),
                      title: Text(
                        following.name ?? 'مستخدم',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${following.followersCount ?? 0} متابع',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement unfollow functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[50],
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        child: Text(
                          'إلغاء المتابعة',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
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
