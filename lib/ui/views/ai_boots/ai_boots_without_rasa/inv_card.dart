import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class InvitationCardScreen extends StatefulWidget {
  @override
  _InvitationCardScreenState createState() => _InvitationCardScreenState();
}

class _InvitationCardScreenState extends State<InvitationCardScreen> {
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _shareInvitation() {
    final title = _titleController.text.trim();
    final details = _detailsController.text.trim();

    if (title.isEmpty || details.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجى ملء عنوان الدعوة والتفاصيل')),
      );
      return;
    }

    final shareText = '''
🎉 دعوة لحضور حفلة 🎉

$title

$details

بانتظار حضوركم بفارغ الصبر!
''';
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إنشاء بطاقة دعوة')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'عنوان الدعوة',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _detailsController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'تفاصيل الدعوة',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _shareInvitation,
              icon: Icon(Icons.share),
              label: Text('مشاركة بطاقة الدعوة'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
