import 'package:flutter/material.dart';
import 'package:flutter_templat/ui/shared/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Contact_Us",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildExpansionTile(
            icon: Icons.headset_mic,

            title: "Customer Service",
            children: [const Text("support@example.com")],
          ),
          _buildExpansionTile(
            icon: FontAwesomeIcons.whatsapp,
            title: "WhatsApp",
            children: [const Text("(480) 555-0103")],
          ),
          _buildExpansionTile(
            icon: Icons.language,
            title: "Website",
            children: [const Text("https://example.com")],
          ),
          _buildExpansionTile(
            icon: FontAwesomeIcons.facebook,
            title: "Facebook",
            children: [const Text("facebook.com/example")],
          ),
          _buildExpansionTile(
            icon: FontAwesomeIcons.twitter,
            title: "Twitter",
            children: [const Text("@example")],
          ),
          _buildExpansionTile(
            icon: FontAwesomeIcons.instagram,
            title: "Instagram",
            children: [const Text("@example")],
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      leading: Icon(icon, color: AppColors.bluecolor),
      title: Text(title),
      trailing: const Icon(Icons.keyboard_arrow_down),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      children: children,
    );
  }
}
