import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/presentation/widgets/CurrentAppoints.dart';
import 'package:nishauri/src/features/appointments/presentation/widgets/PreviousAppointments.dart';
import 'package:nishauri/src/shared/display/CustomTabBar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

import 'Survey.dart';

class SelectSurveyScreen extends HookConsumerWidget {
  const SelectSurveyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currIndex = useState(0);


    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Select survey ",
            // icon: Icons.calendar_month_outlined,
            subTitle: "Please select the survey you would like to undertake",
            color: Constants.pSurveyColor,
          ),



          // Expanded to make the ListView take the remaining space
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: const Text('Dhibiti transfer out client survey'),
                    subtitle: const Text('Survey for transfering out client'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      // Define the action for Survey 1
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Survey 1 selected')),
                      );
                    },
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: const Text('Dhibiti IIT client return to care'),
                    subtitle: const Text('Survey for IIT Return to care'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      // Define the action for Survey 2
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Survey 2 selected')),
                      );
                    },
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 3,
                  child: ListTile(
                    title: const Text('Transfer out pilot'),
                    subtitle: const Text('Survey seeks to understand reasons for interfacility movement among PLHIV'),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SurveyScreen()),
                      );

                      // Define the action for Survey 3
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Survey 3 selected')),
                      // );
                    },
                  ),
                ),
              ],
            ),
          ),



        ],
      ),
    );
  }
}
