import 'dart:convert';
import 'package:http/http.dart' as http;

class RasaService {
  final String baseUrl = "http://192.168.55.197:5005/webhooks/rest/webhook";

  Future<List<String>> sendMessage(
    String message, {
    String sender = "user_1",
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"sender": sender, "message": message}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> replies = [];
      for (var msg in data) {
        if (msg.containsKey("text")) {
          replies.add(msg["text"]);
        }
      }
      return replies;
    } else {
      throw Exception("Failed to connect to Rasa: ${response.statusCode}");
    }
  }
}
