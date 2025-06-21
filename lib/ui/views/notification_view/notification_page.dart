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
                child: Obx(() => ListView.builder(
                      itemCount: controller.notifications.length,
                      itemBuilder: (context, index) =>
                          controller.notifications[index],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
