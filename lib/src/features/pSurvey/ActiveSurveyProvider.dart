import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'ActiveSurveysModel.dart';

final activeSurveysProvider = StateNotifierProvider<ActiveSurveysNotifier, AsyncValue<List<ActiveSurvey>>>((ref) {
  return ActiveSurveysNotifier();
});

class ActiveSurveysNotifier extends StateNotifier<AsyncValue<List<ActiveSurvey>>> {
  ActiveSurveysNotifier() : super(const AsyncValue.loading());

  Future<void> loadActiveSurveys(String authToken, String baseUrl) async {
    final String url = 'https://psurveyapitest.kenyahmis.org/api/questionnaire/active';
    final headers = {
      'Authorization': 'Token 02ea508dd226142ffee71eb61ca80efa5436cf7a',
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Connection': 'keep-alive',
    };

    try {
      print('Fetching surveys...'); // Debug
      final response = await http.get(Uri.parse(url), headers: headers);
      print('Response status: ${response.statusCode}'); // Debug

      if (response.statusCode == 200) {
        print('sucess: ${response.body}');
        final data = jsonDecode(response.body);
        List<ActiveSurvey> surveys = [];

        if (data['data'] != null) {
          surveys = (data['data'] as List).map((item) => ActiveSurvey.fromJson(item)).toList();
        }

        state = AsyncValue.data(surveys);
      } else {
        print('Failed to load surveys. Status code: ${response.body}');
        throw Exception('Failed to load surveys. Status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('CATCH EXCEPTION');
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
