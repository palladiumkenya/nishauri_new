import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Define a provider for loading the data
final surveyDataProvider = StateNotifierProvider<SurveyDataNotifier, AsyncValue<SurveyData>>((ref) {
  return SurveyDataNotifier();
});

// Data model for SurveyData
class SurveyData {
  final String activeQuestionnaires;
  final String completedSurveys;

  SurveyData({
    required this.activeQuestionnaires,
    required this.completedSurveys,
  });
}

class SurveyDataNotifier extends StateNotifier<AsyncValue<SurveyData>> {
  SurveyDataNotifier() : super(const AsyncValue.loading());

  // Function to load the survey data
  Future<void> loadSurveyData() async {
    // URL and headers
    final prefs = await SharedPreferences.getInstance();
    final String? authToken = prefs.getString('auth_token');
    print('Retrieved auth token: $authToken');
    final String url = 'https://psurveyapitest.kenyahmis.org/api/current/user';
    final headers = {
      'Authorization': 'Token 02ea508dd226142ffee71eb61ca80efa5436cf7a',
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Connection': 'keep-alive',
    };

    // Make the API call
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract the required data
        final String activeQuestionnaires = data['Active_questionnaires'] != null
            ? data['Active_questionnaires'].toString()
            : '0'; // Convert int to String if necessary
        final String completedSurveys = data['Completed_surveys'] != null
            ? data['Completed_surveys'].toString()
            : '0'; // Convert int to String if necessary

        // Update state with the retrieved data
        state = AsyncValue.data(SurveyData(
          activeQuestionnaires: activeQuestionnaires,
          completedSurveys: completedSurveys,
        ));

      }



      else {
        print('Failed to load surveys. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load surveys. Status code: ${response.statusCode}');

       // throw Exception('Failed to load survey data');
      }
    } catch (e, stackTrace) {
      // Log the error for better debugging
      print('Error: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
