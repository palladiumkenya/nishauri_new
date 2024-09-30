import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/models/events.dart';

class NewUserScreen extends ConsumerStatefulWidget {
  const NewUserScreen({super.key});

  @override
  ConsumerState<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends ConsumerState<NewUserScreen> {
  Map<int, Map<DateTime, List<Event>>> events = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "My Flow Tracker 🌺",
            color: Constants.periodPlanner,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome, we are so please to have you.",
                          style: TextStyle(
                              color: Constants.periodPlanner,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const SizedBox(
                          width: 300, // Adjust the width as needed
                          height: 300, // Adjust the height as needed
                          child: CircularProgressIndicator(
                            value: 0.5,
                            strokeWidth: 20,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Constants.periodPlanner,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            const Text(
                              "Click below to get Started",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            ElevatedButton(
                              onPressed: () {
                                context.goNamed(
                                    RouteNames.PERIOD_PLANNER_LOG_PERIODS);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Constants.periodPlanner,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: const Text("Get Started"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 20), // Added spacing to avoid overlap
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Features',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          FeatureTile(
                            title: 'Track Your Period',
                            description:
                                'Keep an accurate record of your menstrual cycles to better understand your health.',
                            icon: Icons.track_changes,
                          ),
                          FeatureTile(
                            title: 'Period Calendar',
                            description:
                                'View and manage your menstrual cycles with a detailed calendar.',
                            icon: Icons.calendar_today,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const FeatureTile({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(description),
    );
  }
}
