import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'SurveyState.dart';

class SurveyNotifier extends StateNotifier<SurveyState> {
  SurveyNotifier() : super(SurveyState.initial());

  // Load the question from the server
  Future<void> loadQuestion(String link, int sessionId) async {
    final url = "$link/$sessionId";
    final headers = {
      'Authorization': 'Token c52fa63240b115f45b7ae1eda04fc63d95dfd4ca',
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Connection': 'keep-alive',
    };

    // Set loading to true
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('Question')) {
          final question = jsonResponse['Question'];
          final questionText = question['question'] ?? '';
          final questionType = question['question_type'] ?? 0;
          final isQuestionRequired = question['is_required'] ?? false;

          List<String> answerOptions = [];
          if (jsonResponse.containsKey('Ans')) {
            final ansArray = jsonResponse['Ans'] as List;
            answerOptions = ansArray.map((item) => item['option'] as String).toList();
          }

          // Log parsed question and answer details
          print("Parsed Question: $questionText");
          print("Parsed Answer Options: $answerOptions");

          // Update the state with the question and answers
          state = state.copyWith(
            questionText: questionText,
            questionType: questionType,
            isQuestionRequired: isQuestionRequired,
            answerOptions: answerOptions,
            isLoading: false,
          );
        } else if (jsonResponse.containsKey('Message')) {
          final message = jsonResponse['Message'];
          if (message.contains("Questionnaire complete")) {
            print("Questionnaire Complete Message: $message");
            state = state.copyWith(
              isLoading: false,
              errorMessage: "Questionnaire complete",
            );
          }
        }
      } else {
        // Handle non-200 response
        print("Failed to load question. Status code: ${response.statusCode}");
        state = state.copyWith(
          isLoading: false,
          errorMessage: "Failed to load question. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      // Handle errors
      state = state.copyWith(
        isLoading: false,
        errorMessage: "An error occurred: $e",
      );
    }
  }
}

