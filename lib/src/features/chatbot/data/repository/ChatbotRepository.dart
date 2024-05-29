import 'package:nishauri/src/features/chatbot/data/models/feedback_response.dart';
import 'package:nishauri/src/features/chatbot/data/models/message.dart';
import 'package:nishauri/src/features/chatbot/data/services/ChatbotService.dart';

class ChatbotRepository {
  final ChatbotService _service;

  ChatbotRepository(this._service);

  Future<FeedbackResponse> sendMessage(Message message) async {
    final sendMessage = await _service.sendMessage(message);
    return sendMessage;
  }
  Future<String> review(Map<String, dynamic> data) async {
    return await _service.review(data);
  }
}
