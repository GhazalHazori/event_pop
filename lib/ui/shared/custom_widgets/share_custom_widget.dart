import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareBottomSheet extends StatelessWidget {
  final String shareText;
  final String shareUrl;

  const ShareBottomSheet({
    Key? key,
    this.shareText = 'Check out this amazing International Band Music Concert!',
    this.shareUrl = 'https://example.com/event/concert',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 20),

          // Title
          const Text(
            'Share with friends',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSocialIcon(
                  // icon: FontAwesomeIcons.link,
                  icon: Icons.abc,
                  label: 'Copy Link',
                  color: Colors.grey[600]!,
                  backgroundColor: Colors.grey[100]!,
                  onTap: () => _copyToClipboard(context),
                ),
                buildSocialIcon(
                  // icon: FontAwesomeIcons.whatsapp,
                  icon: Icons.abc,
                  label: 'WhatsApp',
                  color: Colors.white,
                  backgroundColor: const Color(0xFF25D366),
                  onTap: () => _shareToWhatsApp(),
                ),
                buildSocialIcon(
                  // icon: FontAwesomeIcons.facebookF,
                  icon: Icons.abc,
                  label: 'Facebook',
                  color: Colors.white,
                  backgroundColor: const Color(0xFF1877F2),
                  onTap: () => _shareToFacebook(),
                ),
                buildSocialIcon(
                  // icon: FontAwesomeIcons.facebookMessenger,
                  icon: Icons.abc,
                  label: 'Messenger',
                  color: Colors.white,
                  backgroundColor: const Color(0xFF0084FF),
                  onTap: () => _shareToMessenger(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSocialIcon(
                  // icon: FontAwesomeIcons.xTwitter,
                  icon: Icons.abc,
                  label: 'Twitter',
                  color: Colors.white,
                  backgroundColor: const Color(0xFF000000),
                  onTap: () => _shareToTwitter(),
                ),
                buildSocialIcon(
                  // icon: FontAwesomeIcons.instagram,
                  icon: Icons.abc,
                  label: 'Instagram',
                  color: Colors.white,
                  backgroundColor: const Color(0xFFE4405F),
                  onTap: () => _shareToInstagram(),
                ),
                buildSocialIcon(
                  // icon: FontAwesomeIcons.skype,
                  icon: Icons.abc,
                  label: 'Skype',
                  color: Colors.white,
                  backgroundColor: const Color(0xFF00AFF0),
                  onTap: () => _shareToSkype(),
                ),
                buildSocialIcon(
                  // icon: FontAwesomeIcons.sms,
                  icon: Icons.abc,
                  label: 'Message',
                  color: Colors.white,
                  backgroundColor: const Color(0xFF34C759),
                  onTap: () => _shareToSMS(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Cancel button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildSocialIcon({
    required IconData icon,
    required String label,
    required Color color,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // وظائف المشاركة
  Future<void> _copyToClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: shareUrl));
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ الرابط بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _shareToWhatsApp() async {
    final encodedText = Uri.encodeComponent('$shareText\n$shareUrl');
    final url = 'https://wa.me/?text=$encodedText';
    await _launchUrl(url);
  }

  Future<void> _shareToFacebook() async {
    final encodedUrl = Uri.encodeComponent(shareUrl);
    final url = 'https://www.facebook.com/sharer/sharer.php?u=$encodedUrl';
    await _launchUrl(url);
  }

  Future<void> _shareToMessenger() async {
    final encodedUrl = Uri.encodeComponent(shareUrl);
    final url = 'https://www.messenger.com/t/?link=$encodedUrl';
    await _launchUrl(url);
  }

  Future<void> _shareToTwitter() async {
    final encodedText = Uri.encodeComponent(shareText);
    final encodedUrl = Uri.encodeComponent(shareUrl);
    final url =
        'https://twitter.com/intent/tweet?text=$encodedText&url=$encodedUrl';
    await _launchUrl(url);
  }

  Future<void> _shareToInstagram() async {
    const url = 'https://www.instagram.com/';
    await _launchUrl(url);
  }

  Future<void> _shareToSkype() async {
    final encodedText = Uri.encodeComponent('$shareText $shareUrl');
    final url = 'https://web.skype.com/share?text=$encodedText';
    await _launchUrl(url);
  }

  Future<void> _shareToSMS() async {
    final encodedText = Uri.encodeComponent('$shareText $shareUrl');
    final url = 'sms:?body=$encodedText';
    await _launchUrl(url);
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}

void showShareBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const ShareBottomSheet(),
  );
}
