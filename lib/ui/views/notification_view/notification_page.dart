import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                  const SizedBox(width: 8),
                  const Text('Notification', style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  const Icon(Icons.more_vert),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (controller.notifications.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_none,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No notifications yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.notifications.length,
                    itemBuilder: (context, index) {
                      final notification = controller.notifications[index];
                      print(
                          '🏗️ Building notification item $index: ${notification.type}');
                      return controller.buildNotificationItem(notification);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
