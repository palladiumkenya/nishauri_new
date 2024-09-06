import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/providers/cycles_provider.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/logPeriods.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:table_calendar/table_calendar.dart';

class EditPeriods extends ConsumerStatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final String? cycleId;
  const EditPeriods(
      {super.key, this.initialStartDate, this.initialEndDate, this.cycleId});

  @override
  ConsumerState<EditPeriods> createState() => _EditPeriodsState();
}

class _EditPeriodsState extends ConsumerState<EditPeriods> {
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
      // Finding the current cycle using cycleId instead of periodStart and periodEnd
      Cycle currentCycle = cycles.firstWhere(
        (cycle) =>
            cycle.cycleId == widget.cycleId, // Use cycleId for identification
      );

      // Predict the new cycle based on the updated period start and end dates
      Cycle updatedCycle = predictCycle(_rangeStart!, _rangeEnd!, cycleId: currentCycle.cycleId);

      ref.read(cyclesProvider.notifier).updatedCycle(currentCycle.cycleId, updatedCycle);

      // Replace the old cycle with the updated one using index
      int index = cycles.indexOf(currentCycle);
      cycles[index] = updatedCycle;

      debugPrint("Updated Cycle Length: ${updatedCycle.cycleLength}");
      printCycles(cycles);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periods updated successfully!')),
      );
      Navigator.pop(context, true);
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
                          content: const Text(
                              'Please select both start and end of your periods!!'),
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