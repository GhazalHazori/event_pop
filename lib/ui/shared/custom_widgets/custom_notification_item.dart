import 'package:flutter/material.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_buttonnno.dart';

class CustomNotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String? imageUrl;
  final bool showActions;

  const CustomNotificationItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.imageUrl,
    this.showActions = false,
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
            backgroundColor: Colors.grey[300],
            child: imageUrl == null
                ? const Icon(Icons.person, color: Colors.white)
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: " $subtitle",
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
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
                          onPressed: () {},
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
                          onPressed: () {},
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
