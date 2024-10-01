import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'SurveyNotifier.dart';
import 'SurveyProvider.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SurveyScreen extends HookConsumerWidget {
  final String link;
  final int sessionId;

  const SurveyScreen({
    Key? key,
    required this.link,
    required this.sessionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access SurveyNotifier
    final surveyNotifier = ref.read(surveyProvider.notifier);

    // Delay the execution until after the widget build is complete
    useEffect(() {
      Future(() {
        surveyNotifier.loadQuestion(link, sessionId);
      });
      return null;
    }, []);

    // Watch the SurveyProvider state
    final surveyState = ref.watch(surveyProvider);

    // Hook to manage the selected answer and openText input state
    final selectedAnswer = useState<String?>(null);
    final openTextController = useTextEditingController();

    // Hook to manage selected date state
    final selectedDate = useState<DateTime?>(null);

    // Function to submit the answer
    Future<void> submitAnswer({
      required int sessionID,
      required int questionNumber,
      String? answer,
      String? openText,
    }) async {
      final url = "https://psurveyapitest.kenyahmis.org/api/questions/answer/";

      // Prepare the request body
      final body = jsonEncode({
        "session": sessionID,
        "question": questionNumber,
        "answer": answer ?? "",
        "open_text": openText ?? "",
      });

      try {
        // Send the POST request
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Authorization': 'Token your_auth_token_here',
            'Content-Type': 'application/json',
          },
          body: body,
        );

        // Handle the response
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);

          if (responseData.containsKey("link")) {
            // Navigate to the next question if there's a "link"
            final nextLink = responseData["link"];
            final nextSessionId = responseData["session_id"];

            // Trigger loading of the next question
            surveyNotifier.loadQuestion(nextLink, nextSessionId);
          } else if (responseData["Message"].contains("Questionnaire complete")) {
            // Navigate to the completion screen
            Navigator.pushNamed(context, '/complete_survey');
          }
        } else {
          throw Exception("Failed to submit answer");
        }
      } catch (error) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $error")),
        );
      }
    }

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: CustomAppBar(
          title: "Questions",
          subTitle: "Please complete the survey to the end",
          color: Constants.pSurveyColor,
        ),
      ),
      body: surveyState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : surveyState.errorMessage.isNotEmpty
          ? Center(child: Text(surveyState.errorMessage))
          : SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display question text
                Text(
                  surveyState.isQuestionRequired
                      ? "${surveyState.questionText} *"
                      : surveyState.questionText,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Render different input types based on questionType
                if (surveyState.questionType == 1)
                  TextFormField(
                    controller: openTextController,
                    decoration: const InputDecoration(
                        labelText: "Enter your answer"),
                  )
                else if (surveyState.questionType == 2)
                  Column(
                    children: surveyState.answerOptions.map((option) {
                      return RadioListTile<String>(
                        title: Text(option),
                        value: option,
                        groupValue: selectedAnswer.value,
                        onChanged: (value) {
                          selectedAnswer.value = value;
                        },
                      );
                    }).toList(),
                  )
                else if (surveyState.questionType == 3)
                    Column(
                      children: surveyState.answerOptions.map((option) {
                        return CheckboxListTile(
                          title: Text(option),
                          value: selectedAnswer.value == option,
                          onChanged: (bool? value) {
                            if (value == true) {
                              selectedAnswer.value = option;
                            }
                          },
                        );
                      }).toList(),
                    )
                  else if (surveyState.questionType == 4)
                      TextFormField(
                        controller: openTextController,
                        decoration: const InputDecoration(
                            labelText: "Enter a number"),
                        keyboardType: TextInputType.number,
                      )
                    else if (surveyState.questionType == 5)
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // Show the date picker
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );

                                if (pickedDate != null) {
                                  selectedDate.value = pickedDate;

                                  // Format and set the selected date into openTextController
                                  openTextController.text =
                                  "${pickedDate.toLocal()}".split(' ')[0];
                                }
                              },
                              child: const Text("Select Date"),
                            ),
                            if (selectedDate.value != null)
                              Text(
                                "Selected Date: ${selectedDate.value!.toLocal()}"
                                    .split(' ')[0],
                                style: const TextStyle(fontSize: 16),
                              ),
                          ],
                        ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,  // Full width of the screen
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.pSurveyColor,  // Set button color
                      foregroundColor: Colors.white, // Set text color to white
                    ),
                    onPressed: () {
                      // Submit the answer when "Next" is pressed
                      submitAnswer(
                        sessionID: sessionId,
                        questionNumber: surveyState.questionNumber,
                        answer: selectedAnswer.value,
                        openText: openTextController.text,
                      );
                    },
                    child: const Text("Next", textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
