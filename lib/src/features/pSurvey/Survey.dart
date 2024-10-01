import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'SurveyNotifier.dart';
import 'SurveyProvider.dart'; // Import your SurveyNotifier and SurveyState

class SurveyScreen extends HookConsumerWidget {


  final String link;
  final int sessionId;
 // final String token;
  //final int questionnaireId;

  const SurveyScreen({
    Key? key,
    required this.link,
    required this.sessionId,
    //required this.token,
   // required this.questionnaireId,
   // required this.token,
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
      return null;  // Cleanup if necessary
    }, []);

    // Watch the SurveyProvider state
    final surveyState = ref.watch(surveyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Survey")),
      body: surveyState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : surveyState.errorMessage.isNotEmpty
          ? Center(child: Text(surveyState.errorMessage))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (surveyState.isQuestionRequired)
                Text(
                  "${surveyState.questionText} *",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              else
                Text(
                  surveyState.questionText,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 16),
              if (surveyState.questionType == 1)
                TextFormField(
                  decoration: const InputDecoration(labelText: "Enter your answer"),
                )
              else if (surveyState.questionType == 2)
                Column(
                  children: surveyState.answerOptions.map((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: null, // Replace with the selected value in state
                      onChanged: (value) {
                        // Handle single-choice selection
                      },
                    );
                  }).toList(),
                )
              else if (surveyState.questionType == 3)
                  Column(
                    children: surveyState.answerOptions.map((option) {
                      return CheckboxListTile(
                        title: Text(option),
                        value: false, // Replace with the selected state in state
                        onChanged: (bool? value) {
                          // Handle multiple-choice selection
                        },
                      );
                    }).toList(),
                  )
                else if (surveyState.questionType == 4)
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Enter a number"),
                      keyboardType: TextInputType.number,
                    )
                  else if (surveyState.questionType == 5)
                      ElevatedButton(
                        onPressed: () {
                          // Show date picker here
                        },
                        child: const Text("Select Date"),
                      ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Handle submission
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
