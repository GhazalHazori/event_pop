import 'package:flutter/material.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_buttonnno.dart';

class CustomNotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String? imageUrl;
  final bool showActions;
  final bool isRead;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const CustomNotificationItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.imageUrl,
    this.showActions = false,
    this.isRead = false,
    this.onAccept,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            backgroundColor: isRead ? Colors.grey[300] : Colors.blue[100],
            child: imageUrl == null
                ? Icon(Icons.person,
                    color: isRead ? Colors.white : Colors.blue[700])
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: title,
                          style: TextStyle(
                            fontWeight:
                                isRead ? FontWeight.normal : FontWeight.bold,
                            color: isRead ? Colors.black54 : Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: " $subtitle",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: isRead ? Colors.black54 : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: TextStyle(
                          fontSize: 12,
                          color: isRead ? Colors.grey : Colors.blue[600]),
                    ),
                  ],
                ),
                if (showActions) const SizedBox(height: 12),
                if (showActions)
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Reject",
                          onPressed: onReject ?? () {},
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          borderSide: const BorderSide(color: Colors.grey),
                          isElevated: false,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: "Accept",
                          onPressed: onAccept ?? () {},
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          isElevated: true,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
