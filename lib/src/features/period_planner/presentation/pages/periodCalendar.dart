import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/calendarKey.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:table_calendar/table_calendar.dart';
class PeriodCalendar extends StatelessWidget {
  const PeriodCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Map<DateTime, List<Event>> events = _generateEvents(cycles);
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
                CustomCalendar(initialFormat: CalendarFormat.month, events: events,),
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
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Constants.periodPlanner,
          //       ),
          //       onPressed: () {
          //         // To add functionality later       
          //         context.goNamed(RouteNames.PERIOD_PLANNER_EDIT_PERIOD_CALENDAR);
          //       },
          //       child: Text(
          //         'Edit period dates',
          //         style: theme.textTheme.titleSmall?.copyWith(
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  //Generating Events from the Cycles List
  Map<DateTime, List<Event>> _generateEvents(List<Cycle> cycles) {
    Map<DateTime, List<Event>> events = {};

    for (Cycle cycle in cycles) {
      // Add period days
      for (DateTime date = cycle.periodStart;
          date.isBefore(cycle.periodEnd) || date.isAtSameMomentAs(cycle.periodEnd);
          date = date.add(const Duration(days: 1))) {
        events.update(date, (existingEvents) => existingEvents..add(Event('Period Day', Colors.pink)), ifAbsent: () => [Event('Period Day', Colors.pink)]);
      }

      // Add fertile window days
      for (DateTime date = cycle.fertileStart;
          date.isBefore(cycle.fertileEnd) || date.isAtSameMomentAs(cycle.fertileEnd);
          date = date.add(const Duration(days: 1))) {
        events.update(date, (existingEvents) => existingEvents..add(Event('Fertile Day', Colors.green)), ifAbsent: () => [Event('Fertile Day', Colors.green)]);
      }

      // Add ovulation day
      events.update(cycle.ovulation, (existingEvents) => existingEvents..add(Event('Ovulation Day', Colors.blue)), ifAbsent: () => [Event('Ovulation Day', Colors.blue)]);

      // Add predicted period start
      for (DateTime date = cycle.predictedPeriodStart;
          date.isBefore(cycle.predictedPeriodEnd) || date.isAtSameMomentAs(cycle.predictedPeriodEnd);
          date = date.add(const Duration(days: 1))) {
        events.update(date, (existingEvents) => existingEvents..add(Event('Predicted Period Day', Colors.pink)), ifAbsent: () => [Event('Predicted Period Day', Colors.orange)]);
      }
      //events.update(cycle.predictedPeriodStart, (existingEvents) => existingEvents..add(Event('Predicted Period Start', Colors.orange)), ifAbsent: () => [Event('Predicted Period Start', Colors.orange)]);
    }

    // Debugging: Print events map
    events.forEach((key, value) {
      debugPrint('Date: $key, Events: $value');
    });

    return events;
  }
  
}
