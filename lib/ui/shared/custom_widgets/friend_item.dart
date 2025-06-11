import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  final String name;
  final String followers;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const FriendItem({
    required this.name,
    required this.followers,
    this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage(
          imagePath ?? "",
        ),
      ),
      title: Text(name),
      subtitle: Text('$followers Followers'),
      trailing: CircleAvatar(
        radius: 12,
        backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
        child: Icon(Icons.check, size: 14, color: Colors.white),
      ),
    );
  }
}
