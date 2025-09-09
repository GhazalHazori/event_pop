import 'package:flutter/material.dart';

import 'package:flutter_templat/ui/views/ai_boots/ai_boots_without_rasa/chat_serv.dart';
import 'package:flutter_templat/ui/views/ai_boots/ai_boots_without_rasa/partly_planner.dart'; // خدمتك الخاصة بالبوت

class QAScreen extends StatefulWidget {
  @override
  _QAScreenState createState() => _QAScreenState();
}

class _QAScreenState extends State<QAScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final GeminiService _geminiService = GeminiService();
  bool _isLoading = false;
  String _currentPartyType = "birthday";

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"text": text, "isMe": true});
      _controller.clear();
      _isLoading = true;
    });

    final response = await _geminiService.getGeminiResponse(
      _messages,
      partyType: _currentPartyType,
    );

    setState(() {
      _messages.add({"text": response, "isMe": false});
      _isLoading = false;
    });
  }

  Widget _buildSuggestionButton(String label, String type) {
    return ElevatedButton(
      onPressed: _isLoading
          ? null
          : () {
              _controller.text = label;
              _currentPartyType = type;
              _sendMessage();
            },
      child: Text(label, style: TextStyle(fontSize: 14)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink[100],
        foregroundColor: Colors.black,
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ai Bot")),
      body: Column(
        children: [
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              _buildSuggestionButton("🎂 أفكار حفلة عيد ميلاد", "birthday"),
              _buildSuggestionButton("🎓 اقتراحات لحفلة تخرج", "graduation"),
              _buildSuggestionButton("💍 تجهيز حفلة خطوبة", "engagement"),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg['isMe']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: msg['isMe'] ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg['text']),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          // زر إنشاء خطة الحفلة
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton.icon(
              icon: Icon(Icons.event_note),
              label: Text('إنشاء خطة الحفلة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[400],
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PartyPlannerScreen()),
                );
              },
            ),
          ),
          // مدخل النص مع زر الإرسال
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "اسأل عن تنظيم حفلتك...",
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _isLoading ? null : _sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
