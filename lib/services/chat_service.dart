import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatService {
  static Future<String> getChatResponse(String message) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'];

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "You are a helpful medical assistant."},
          {"role": "user", "content": message},
        ]
      }),
    );

    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'].toString();
  }
}
