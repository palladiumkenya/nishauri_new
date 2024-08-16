import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/calendarKey.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/features/period_planner/utils/event_utils.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class PeriodCalendar extends StatelessWidget {
  const PeriodCalendar({super.key});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Map<String, Map<DateTime, List<Event>>> events = {};
    events = EventUtils.generateEvents(cycles);
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Calendar 🗓️",
            color: Constants.periodPlanner.withOpacity(1.0),
          ),
          Expanded(
            child: Column(
              children: [
                CustomCalendar(
                  events: events
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Key:",
                        style: TextStyle(
                          color: Constants.periodPlanner,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CalendarKey(color: Colors.red, label: 'Today'),
                    CalendarKey(color: Colors.pink, label: 'Period Days'),
                    CalendarKey(color: Colors.green, label: 'Fertile Days'),        
                    CalendarKey(color: Colors.blue, label: 'Ovulation Day'),
                    CalendarKey(color: Colors.orange, label: 'Predicted Next Period Days'),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.periodPlanner,
                ),
                onPressed: () {
                  // To add functionality later       
                  context.goNamed(RouteNames.PERIOD_PLANNER_EDIT_PERIODS);
                },
                child: Text(
                  'Edit period dates',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
  

