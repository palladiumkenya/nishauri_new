import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class PeriodCalendar extends StatelessWidget {
  const PeriodCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Calendar",
            color: Constants.periodPlanner.withOpacity(1.0),
            ),
            CustomCalendar(initialFormat: CalendarFormat.month,)
        ],
      ),
    );
  }
}