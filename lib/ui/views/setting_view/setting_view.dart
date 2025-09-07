import 'package:flutter/material.dart';
import 'package:flutter_templat/ui/shared/colors.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildSettingItem(
            icon: Icons.notifications_none,
            title: "Notification Settings",
            onTap: () {
              // TODO: navigate to notification settings page
            },
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.vpn_key_outlined,
            title: "Password Manager",
            onTap: () {
              // TODO: navigate to password manager page
            },
          ),
          _buildDivider(),
          _buildSettingItem(
            icon: Icons.delete_outline,
            title: "Delete Account",
            onTap: () {
              // TODO: navigate to delete account page
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.bluecolor),
      title: Text(title),
      trailing:  Icon(Icons.arrow_forward_ios, size: 18, color:AppColors.bluecolor),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 0.5,
      indent: 16,
      endIndent: 16,
    );
  }
}
