import 'package:flutter/material.dart';
import 'package:nishauri/src/features/common/presentation/pages/HomeScreen.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/program_appointments.dart';
import 'package:nishauri/src/features/self_screening/presentation/pages/bpInsightScreen.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pages = [
      const BpInsightScreen(),
      const ProgramAppointmentsScreen(),
      const ProgramAppointmentsScreen(),
      const ProgramAppointmentsScreen(),
    ];

    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomAppBar(
            title: "Insight 📖",
            subTitle: "Unlock your health insights with knowledge on different self-screening tools",
            color: Constants.appointmentsColor,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pages.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => pages[index]),
                    );
                  },
                  child: Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(Constants.SPACING),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    index == 0
                                        ? Icons.calculate_outlined
                                        : index == 1
                                        ? Icons.trending_up
                                        : index == 2
                                        ? Icons.bloodtype_outlined
                                        : Icons.calendar_month_sharp,
                                    color: index == 0
                                        ? Constants.bmiCalculatorColor
                                        : index == 1
                                        ? Constants.bpShortCutBgColor
                                        : index == 2
                                        ? Constants.bloodSugarColor
                                        : Constants.periodPlannerShortcutBgColor,
                                  ),
                                  const SizedBox(width: Constants.SPACING),
                                  Text(
                                    index == 0
                                        ? 'BMI Calculator'
                                        : index == 1
                                        ? 'Blood Pressure Monitor'
                                        : index == 2
                                        ? 'Blood Sugar Monitor'
                                        : 'Period Planner',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: Constants.SPACING),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
