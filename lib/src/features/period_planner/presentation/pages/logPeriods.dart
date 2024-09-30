import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/data/providers/cycles_provider.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/eventsMaker.dart';
import 'package:nishauri/src/features/period_planner/utils/event_utils.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:table_calendar/table_calendar.dart';

//printing List which is acting as a Database
// void printCycles(Cycle cycles) {
//   debugPrint('----Cycle Printed----');
//   for (var cycle in cycles) {
//     // debugPrint('Cycle ID: ${cycle.cycleId}');
//     debugPrint('Period Start: ${cycle.period_start}');
//     debugPrint('Period End: ${cycle.periodEnd}');
//     debugPrint('Fertile Start: ${cycle.fertileStart}');
//     debugPrint('Fertile End: ${cycle.fertileEnd}');
//     debugPrint('Ovulation: ${cycle.ovulation}');
//     debugPrint('Predicted Period Start: ${cycle.predictedPeriodStart}');
//     debugPrint('Predicted Period End: ${cycle.predictedPeriodEnd}');
//     debugPrint('Cycle Length: ${cycle.cycleLength}');
//     debugPrint('Period Length: ${cycle.periodLength}');
//     debugPrint('---');
//   }
// }

//This is the screen the user interacts when they are logging their Period Days

class LogPeriodScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<LogPeriodScreen> createState() => _LogPeriodScreenState();
}

class _LogPeriodScreenState extends ConsumerState<LogPeriodScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _startDate;
  DateTime? _endDate;

  //late Map<DateTime, List<Event>> _filteredEvents;
  //final latestCycle = cycles.last;
  // bool _isNewUser = cycles.isEmpty;
  // int averagePeriods = calculateAveragePeriodLength(cycles);
  final today = DateTime.now();

  @override
  void initState() {
    super.initState();
    final cycles = ref.read(cyclesProvider).asData?.value ?? {};
    bool _isNewUser = cycles.isEmpty;
    if (!_isNewUser) {
      _initializePredictedPeriodRange(cycles);
      _setFocusedDayForRegularUser(cycles);
    }
  }

  //  Map<DateTime, List<Event>> _filterEventsForLatestCycle() {
  //   final Map<DateTime, List<Event>> filteredEvents = {};

  //   final latestCycleId = events.keys.last;
  //   if (events.containsKey(latestCycleId)) {
  //     final latestCycleEvents = events[latestCycleId]!;
  //     latestCycleEvents.forEach((date, events) {
  //       if (filteredEvents.containsKey(date)) {
  //         filteredEvents[date]!.addAll(events);
  //       } else {
  //         filteredEvents[date] = List.from(events);
  //       }
  //     });
  //   }

  //   return filteredEvents;
  // }

  void _initializePredictedPeriodRange(Map<int, Cycle> cycles) {
    if (cycles.isNotEmpty) {
      final latestCycle = cycles.values.last;
      setState(() {
        _startDate = latestCycle.predicted_period_start;
        _endDate = latestCycle.predicted_period_end;
      });
    }
    // final latestCycle = cycles.last;
    // _startDate = latestCycle.predicted_period_start;
    // _endDate = latestCycle.predicted_period_end;
  }

  void _setFocusedDayForRegularUser(Map<int, Cycle> cycles) {
    if (cycles.isNotEmpty) {
      final latestCycle = cycles.values.last;
      setState(() {
        _focusedDay = latestCycle.predicted_period_start;
      });
    }
    // final cycles = ref.read(cyclesProvider) as List<Cycle>;
    // final latestCycle = cycles.last;
    // _focusedDay = latestCycle.predicted_period_start;
  }

  //Function handling selection of period days for a regular user
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _startDate = selectedDay;
      // _endDate = _startDate?.add(Duration(days: averagePeriods - 1)); // Only start date is used for regular users
      _endDate = _startDate?.add(const Duration(days: 4));
      _focusedDay = focusedDay;
      // debugPrint("Average Period Length from Log Periods is $averagePeriods");
    });
  }

  // Method to validate date range ensuring selection does not exceed 7 days
  bool _isDateRangeValid(DateTime start, DateTime end) {
    final difference =
        end.difference(start).inDays + 1; // +1 to include the start day
    return difference <= 7; // Ensure the range does not exceed 7 days
  }

  //Function handling selection of period days for a new user
  void _onRangeSelected(DateTime? start, DateTime? end, DateTime? focusedDay) {
    // If either start or end date is after today, show an error
    if (start != null &&
        end != null &&
        (start.isAfter(today) || end.isAfter(today))) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Selection'),
          content: const Text(
              'You cannot select dates in the future. Please select valid dates.'),
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
    }
    // Also check if date range is valid (max 7 days)
    else if (start != null && end != null && !_isDateRangeValid(start, end)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Selection'),
          content: const Text(
              'Please select a date range of 7 days or less. The average period typically lasts between 3 to 7 days.'),
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
      setState(() {
        _startDate = start;
        _endDate = end;
        _focusedDay = focusedDay ?? _focusedDay;
      });
    }
  }

  // Function to check if two date ranges overlap
  bool _datesOverlap(
      DateTime start1, DateTime end1, DateTime start2, DateTime end2) {
    return (start1.isBefore(end2) || isSameDay(start1, end2)) &&
        (start2.isBefore(end1) || isSameDay(start2, end1));
  }

  @override
  Widget build(BuildContext context) {
    final cycleAsyncValue = ref.watch(cyclesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: cycleAsyncValue.when(
        data: (cycles) {
          bool _isNewUser = cycles.isEmpty;
          final cyclesId = cycles.keys.lastOrNull;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: "Enter Periods 📅",
                color: Constants.periodPlanner.withOpacity(1.0),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _isNewUser
                      ? "Please enter your previous period start and end date."
                      : "Please enter when your Periods have started",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(2021),
                lastDay: DateTime(2100),
                rangeStartDay: _startDate,
                rangeEndDay: _endDate,
                onRangeSelected: _isNewUser ? _onRangeSelected : null,
                onDaySelected: _isNewUser ? null : _onDaySelected,
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
                        if (_startDate != null && !_startDate!.isAfter(today)) {
                          final endDate = _endDate ??
                              _startDate!.add(const Duration(
                                  days:
                                      1)); // The else statement handles where a period only happens for a single day hence the end date will be same day as start date
                          for (Cycle cycle in cycles.values) {
                            if (_datesOverlap(cycle.period_start,
                                cycle.period_end, _startDate!, endDate)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'The selected period overlaps with an existing cycle. Please choose different dates.'),
                                ),
                              );
                              return; // Exit the function without adding the cycle
                            }
                          }

                          final newCycle =
                              predictCycle(_startDate!, endDate, cycle: cycles);

                          //using riverpod to add the cycle to the server
                          ref
                              .read(cyclesProvider.notifier)
                              .postCycles(newCycle)
                              .then((_) {
                            context.goNamed(RouteNames.PERIOD_PLANNER_SCREEN);
                          });
                          // printCycles(cycles);
                        } else if (_startDate!.isAfter(today)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'You cannot select dates in the future. Please select valid dates.')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please select your Period start and end dates.')),
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
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(
            'Failed to load cycles: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
