// gemini_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String _apiKey = 'AIzaSyCzkVZghR8Bpjse2O5uxyj9WifKLF-2cn8';

  final Map<String, String> contextPrompts = {
    "birthday":
        "أنت مساعد افتراضي خبير بتنظيم حفلات أعياد الميلاد فقط، ولا تجيب على أي شيء خارج مجال الحفلات.",
    "graduation":
        "أنت مساعد متخصص بحفلات التخرج فقط. لا تجيب على أي مواضيع أخرى خارج تنظيم الحفلات.",
    "engagement":
        "أنت منظم حفلات خطوبة فقط. أي سؤال لا يتعلق بالحفلات، تعتذر وتطلب من المستخدم الالتزام بموضوع الحفلات.",
    "default":
        "أنت مساعد افتراضي مختص فقط بتنظيم الحفلات (مثل أعياد الميلاد، التخرج، الخطوبة). لا يجب أن تتحدث أو تجيب على أي مواضيع خارج هذا المجال.",
  };

  Future<String> getGeminiResponse(
    List<Map<String, dynamic>> history, {
    String partyType = "birthday",
  }) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=$_apiKey',
    );

    final introPrompt = {
      "role": "user",
      "parts": [
        {"text": contextPrompts[partyType] ?? contextPrompts["default"]!},
      ],
    };

    final contents = [
      introPrompt,
      ...history.map((message) {
        return {
          "role": message['isMe'] ? "user" : "model",
          "parts": [
            {"text": message['text']},
          ],
        };
      }).toList(),
    ];

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"contents": contents}),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['candidates'][0]['content']['parts'][0]['text'];
    } else {
      return 'Error from Gemini API: \${response.statusCode}';
    }
  }
}
