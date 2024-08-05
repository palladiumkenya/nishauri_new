import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

//printing List which is acting as a Database
void printCycles(List<Cycle> cycles) {
  for (var cycle in cycles) {
    debugPrint('Cycle ID: ${cycle.cycleId}');
    debugPrint('Period Start: ${cycle.periodStart}');
    debugPrint('Period End: ${cycle.periodEnd}');
    debugPrint('Fertile Start: ${cycle.fertileStart}');
    debugPrint('Fertile End: ${cycle.fertileEnd}');
    debugPrint('Ovulation: ${cycle.ovulation}');
    debugPrint('Predicted Period Start: ${cycle.predictedPeriodStart}');
    debugPrint('Predicted Period End: ${cycle.predictedPeriodEnd}');
    debugPrint('---'); // Separator between cycles for clarity
  }
}

class EditPeriodCalendar extends StatefulWidget {
  @override
  State<EditPeriodCalendar> createState() => _EditPeriodCalendarState();
}

class _EditPeriodCalendarState extends State<EditPeriodCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _startDate;
  DateTime? _endDate;

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime? focusedDay) {
    setState(() {
      _startDate = start;
      _endDate = end;
      _focusedDay = focusedDay ?? _focusedDay;
    });
  } 

  //Function to handle adding and updating log entries in list Database
  void _updateOrAddCycle(DateTime start, DateTime end) {
    if (cycles.isNotEmpty) {
      // Update existing cycle
      cycles[0] = predictCycle(start, end);
    } else {
      // Add new cycle
      final Cycle newCycle = predictCycle(start, end);
      cycles.add(newCycle);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Log Periods 📅",
            color: Constants.periodPlanner.withOpacity(1.0),
          ),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime.now(),
            rangeStartDay: _startDate,
            rangeEndDay: _endDate,
            onRangeSelected: _onRangeSelected,
            rangeSelectionMode: RangeSelectionMode.toggledOn,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              rangeStartDecoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              rangeEndDecoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              rangeHighlightColor: Constants.periodPlanner,
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.periodPlanner,
                  ),
                  onPressed: () {
                    if (_startDate != null && _endDate != null) {
                      _updateOrAddCycle(_startDate!, _endDate!);
                      printCycles(cycles);
                      // Print the list of cycles
                      printCycles(cycles);
                      context.goNamed(RouteNames.PERIOD_PLANNER_MENU);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select your Period start and end dates.'))
                      );
                    }
                  },
                  child: Text(
                    'Apply',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
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


