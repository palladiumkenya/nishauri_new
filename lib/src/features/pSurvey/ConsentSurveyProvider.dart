import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;


final consentProvider = StateNotifierProvider<ConsentNotifier, AsyncValue<void>>((ref) {
  return ConsentNotifier();
});


class ConsentNotifier extends StateNotifier<AsyncValue<void>> {
  ConsentNotifier() : super(const AsyncValue.data(null));

  Future<Map<String, dynamic>> confirmConsent({
    required String baseUrl,
    required String authToken,
    required int questionnaireId,
    required String cccNumber,
    required String firstName,
    required int dataId,
  }) async {
    try {
      final url = Uri.parse('https://psurveyapitest.kenyahmis.org/api/questionnaire/start/');
      final headers = {
        'Authorization': 'Token c52fa63240b115f45b7ae1eda04fc63d95dfd4ca',
        'Accept': '*/*',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'questionnaire_id': questionnaireId,
        'ccc_number': cccNumber,
        'first_name': firstName,
        'questionnaire_participant_id': dataId,
        'interviewer_statement': true,
        'informed_consent': true,
        'privacy_policy': true,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey("link") && responseData.containsKey("session")) {
          return {
            'link': responseData['link'],
            'session': responseData['session'],
          };
        } else if (responseData['message']?.contains("client verification failed") == true) {
          throw Exception('Client verification failed');
        }
      } else {
        throw Exception('Failed to confirm consent. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error confirming consent: $e');
    }

    return {};
  }
}
