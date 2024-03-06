import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/chatbot/data/repository/ChatbotRepository.dart';
import 'package:nishauri/src/features/chatbot/data/services/ChatbotService.dart';

final chatbotProvider =
Provider.autoDispose((ref) => ChatbotRepository(ChatbotService("https://ushauriapi.kenyahmis.org/nishauri/chat?user_id=")));
