import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nishauri/src/features/chatbot/data/models/feedback_response.dart';
import 'package:nishauri/src/features/chatbot/data/models/message.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';

class ChatbotService extends HTTPService{
  final String endpoint = "${Constants.BASE_URL}/chat";

  Future<FeedbackResponse> sendMessage(Message message) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        'question': message.question.toString(),
      }),
    );

    if (response.statusCode == 200) {
      return FeedbackResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send message');
    }
  }
}
