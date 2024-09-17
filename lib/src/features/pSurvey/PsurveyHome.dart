import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'AvailableSurveyDataProvider.dart';
import 'SelectSurvey.dart';

class PsurveyHomeScreen extends HookConsumerWidget {
  const PsurveyHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Watch the surveyDataProvider
    final surveyData = ref.watch(surveyDataProvider);

    // Load survey data when the screen is loaded
    useEffect(() {
      ref.read(surveyDataProvider.notifier).loadSurveyData();
      return null;
    }, []);

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "pSurvey",
            subTitle: "A platform for qualitative and quantitative surveys",
            color: Constants.pSurveyColor,
          ),

          Padding(
            padding: const EdgeInsets.all(Constants.SPACING),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.map, color: Colors.white),
                title: Text(
                  'Available surveys',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Display the activeQuestionnaires data
                subtitle: surveyData.when(
                  data: (data) => Text(
                    data.activeQuestionnaires,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  loading: () => CircularProgressIndicator(),
                  error: (e, _) => Text(
                    'Error loading data',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                trailing: Icon(Icons.navigate_next, color: Colors.white),
                tileColor: Constants.pSurveyColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectSurveyScreen()),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Constants.SPACING),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.photo, color: Colors.white),
                title: Text(
                  'Completed surveys',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Display the completedSurveys data
                subtitle: surveyData.when(
                  data: (data) => Text(
                    data.completedSurveys,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  loading: () => CircularProgressIndicator(),
                  error: (e, _) => Text(
                    'Error loading data',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                trailing: Icon(Icons.navigate_next, color: Colors.white),
                tileColor: Constants.pSurveyColor,
                onTap: () {
                  // Handle completed surveys tap
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
