import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Define a model for ActiveSurveys
class ActiveSurvey {
  final int id;
  final String title;
  final String description;
  final String status;
  final String createdAt;
  final String activeTill;
  final int createdBy;
  final bool hasUploadedData;

  ActiveSurvey({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.activeTill,
    required this.createdBy,
    required this.hasUploadedData,
  });
}

// Define a StateNotifier to manage the active surveys data
class ActiveSurveyNotifier extends StateNotifier<AsyncValue<List<ActiveSurvey>>> {
  ActiveSurveyNotifier() : super(const AsyncValue.loading());

  // Function to load active surveys from the API
  Future<void> loadActiveSurveys() async {
    final String url = 'https://psurveyapitest.kenyahmis.org/api/questionnaire/active'; // Your API endpoint
    final headers = {
      'Authorization': 'Token 02ea508dd226142ffee71eb61ca80efa5436cf7a',
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Connection': 'keep-alive',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print('API Response: $data');  // Check if the data is returned
        List<ActiveSurvey> surveys = [];

        final myArray = data['data'] as List;
        if (myArray.isNotEmpty) {
          for (var item in myArray) {
            surveys.add(ActiveSurvey(
              id: item['id'] ?? 0,
              title: item['name'] ?? '',
              description: item['description'] ?? '',
              status: item['is_active'] ?? '',
              createdAt: item['created_at'] ?? '',
              activeTill: item['active_till'] ?? '',
              createdBy: item['created_by'] ?? 0,
              hasUploadedData: item['has_uploaded_data'] ?? false,
            ));
          }
          state = AsyncValue.data(surveys);
        } else {
          state = AsyncValue.data([]);
        }
      } else {
        print('Error fetching surveys:');
        throw Exception('Failed to load active surveys. Status code: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('Error fetching surveys: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

// Define a provider to expose the ActiveSurveyNotifier
final activeSurveyProvider = StateNotifierProvider<ActiveSurveyNotifier, AsyncValue<List<ActiveSurvey>>>(
      (ref) => ActiveSurveyNotifier(),
);
