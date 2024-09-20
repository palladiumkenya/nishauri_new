import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'ActiveSurveyProvider.dart';
import 'Survey.dart';
import 'ConsentSurveyProvider.dart'; // Import the provider
import 'ActiveSurveysModel.dart';

class SelectSurveyScreen extends HookConsumerWidget {
  const SelectSurveyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the ActiveSurveysNotifier
    final surveysNotifier = ref.read(activeSurveysProvider.notifier);

    // Call loadActiveSurveys when the widget is first built
    useEffect(() {
      surveysNotifier.loadActiveSurveys(
        'Token 02ea508dd226142ffee71eb61ca80efa5436cf7a',
        'https://psurveyapitest.kenyahmis.org/api/questionnaire/active',
      );
      return null;
    }, []);

    // Watch the activeSurveysProvider to get the data
    final activeSurveys = ref.watch(activeSurveysProvider);
    final consentNotifier = ref.read(consentProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Select survey ",
            subTitle: "Please select the survey you would like to undertake",
            color: Constants.pSurveyColor,
          ),

          // Expanded to make the ListView take the remaining space
          Expanded(
            child: activeSurveys.when(
              data: (surveys) {
                if (surveys.isEmpty) {
                  return const Center(child: Text('No active surveys available.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: surveys.length,
                  itemBuilder: (context, index) {
                    final survey = surveys[index];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: ListTile(
                        title: Text(survey.surveyTitle),  // Display survey title
                        subtitle: Text(survey.surveyDescription),  // Display survey description
                        trailing: const Icon(Icons.navigate_next),
                        onTap: () async {
                          final baseUrl = 'https://psurveyapitest.kenyahmis.org/api/questionnaire/start/';
                          final authToken = 'Token 02ea508dd226142ffee71eb61ca80efa5436cf7a';
                          final questionnaireId = survey.id;  // Use survey's ID
                          final cccNumber = '1234500001';  // Example CCC number
                          final firstName = 'sample_first_name';  // Example first name
                          final dataId = 1;  // Example data ID

                          try {
                            // Call the confirmConsent method and handle the response
                            final data = await consentNotifier.confirmConsent(
                              baseUrl: baseUrl,
                              authToken: authToken,
                              questionnaireId: questionnaireId,
                              cccNumber: cccNumber,
                              firstName: firstName,
                              dataId: dataId,
                            );

                            // Navigate to SurveyScreen and pass the link and sessionId
                            if (data.containsKey('link') && data.containsKey('session')) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SurveyScreen(
                                    questionnaireId: questionnaireId,
                                    link: data['link'],
                                    sessionId: data['session'],
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Consent confirmation failed or missing data.')),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
