import 'package:flutter/material.dart';

class CustomEventCard extends StatelessWidget {
  final String eventName;
  final String? imagePath; // مسار الصورة المحلي

  const CustomEventCard({
    Key? key,
    required this.eventName,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  // (imagePath != null && imagePath!.isNotEmpty)
                  //     ? Image.asset(
                  //         imagePath!,
                  //         width: 80,
                  //         height: 80,
                  //         fit: BoxFit.cover,
                  //       )
                  // :
                  Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: Icon(
                  Icons.event,
                  size: 40,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                eventName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
