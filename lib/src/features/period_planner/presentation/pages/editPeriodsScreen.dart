import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:table_calendar/table_calendar.dart';

class EditPeriods extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  const EditPeriods(
      {super.key, this.initialStartDate, this.initialEndDate});

  @override
  State<EditPeriods> createState() => _EditPeriodsState();
}

class _EditPeriodsState extends State<EditPeriods> {
  late DateTime _focusedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _focusedDay = widget.initialStartDate ?? DateTime.now();
    _rangeStart = widget.initialStartDate;
    _rangeEnd = widget.initialEndDate;
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime? focusedDay) {
    setState(() {
      _rangeStart = start;
      _rangeEnd = end;
      _focusedDay = focusedDay ?? _focusedDay;
    });
  }

  //Function for updating the entries in the list database
  void _updateCycle() {
    if (_rangeStart != null && _rangeEnd != null) {
      //Finding the current cycle to update
      Cycle currentCycle = cycles.firstWhere(
        (cycle) =>
            cycle.periodStart == widget.initialStartDate &&
            cycle.periodEnd == widget.initialEndDate,
      );

      // Predict the new cycle based on the updated period start and end dates
      Cycle updatedCycle = predictCycle(_rangeStart!, _rangeEnd!);

      //Replace the old cycle with the updated one
      int index = cycles.indexOf(currentCycle);
      cycles[index] = updatedCycle;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periods updated successfully!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Edit Period 🌸",
            color: Constants.periodPlanner,
          ),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2021),
            lastDay: DateTime(2100),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: RangeSelectionMode.toggledOn,
            onRangeSelected: _onRangeSelected,
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
              selectedDecoration: BoxDecoration(
                color: Constants.periodPlanner,
                shape: BoxShape.circle,
              ),
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
                    // if (_startDate != null) {
                    //   final endDate = _endDate ?? _startDate!; // The else statement handles where a period only happens for a single day hence the end date will be same day as start date
                    //   _updateOrAddCycle(_startDate!, endDate);
                    //   printCycles(cycles);
                    //   context.goNamed(RouteNames.PERIOD_PLANNER_SCREEN);
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Please select your Period start and end dates.')),
                    //   );
                    // }
                    if (_rangeStart == null || _rangeEnd == null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Invalid Selection'),
                          content: const Text('Please select both start and end of your periods!!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      _updateCycle();
                      context.goNamed(RouteNames.PERIOD_PLANNER_PERIOD_HISTORY);
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
