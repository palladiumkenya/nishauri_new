import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/eventsMaker.dart';
import 'package:nishauri/src/features/period_planner/utils/event_utils.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:table_calendar/table_calendar.dart';

//printing List which is acting as a Database
void printCycles(List<Cycle> cycles) {
  debugPrint('----Cycle Printed----');
  for (var cycle in cycles) {
    debugPrint('Cycle ID: ${cycle.cycleId}');
    debugPrint('Period Start: ${cycle.periodStart}');
    debugPrint('Period End: ${cycle.periodEnd}');
    debugPrint('Fertile Start: ${cycle.fertileStart}');
    debugPrint('Fertile End: ${cycle.fertileEnd}');
    debugPrint('Ovulation: ${cycle.ovulation}');
    debugPrint('Predicted Period Start: ${cycle.predictedPeriodStart}');
    debugPrint('Predicted Period End: ${cycle.predictedPeriodEnd}');
    debugPrint('Cycle Length: ${cycle.cycleLength}');
    debugPrint('Period Length: ${cycle.periodLength}');
    debugPrint('---'); // Separator between cycles for clarity
  }
}

class LogPeriodScreen extends StatefulWidget {

  @override
  State<LogPeriodScreen> createState() => _LogPeriodScreenState();
}

class _LogPeriodScreenState extends State<LogPeriodScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _startDate;
  DateTime? _endDate;
  Map<String, Map<DateTime, List<Event>>> events = EventUtils.generateEvents(cycles);
  late Map<DateTime, List<Event>> _flatEvents;
  late Map<DateTime, List<Event>> _filteredEvents;


   @override
  void initState()  {
    super.initState();
    // _flatEvents = _flattenEvents(events);
    // _filteredEvents = _filterEventsForLatestCycle();

    if (events.isNotEmpty) {
    _flatEvents = _flattenEvents(events);
    _filteredEvents = _filterEventsForLatestCycle();
  } else {
    _flatEvents = {}; 
    _filteredEvents = {};
  }

  }

   //To flatten the events so that it can be in the form of DateTime as the key and the events as the values
  Map<DateTime, List<Event>> _flattenEvents(Map<String, Map<DateTime, List<Event>>> nestedEvents) {
  final Map<DateTime, List<Event>> flattenedEvents = {};

  nestedEvents.forEach((cycleId, dateMap) {
    //print("Processing cycle: $cycleId"); // Debug: Print current cycleId
    dateMap.forEach((date, events) {
      //print("Date: $date, Events: $events"); // Debug: Print date and events being processed
      if (flattenedEvents.containsKey(date)) {
        flattenedEvents[date]!.addAll(events);
      } else {
        flattenedEvents[date] = List.from(events);
      }
    });
  });

  //print("Flattened Events: $flattenedEvents"); // Debug: Print final flattened events
  return flattenedEvents;
  }

  Map<DateTime, List<Event>> _filterEventsForLatestCycle()  {
  final Map<DateTime, List<Event>> filteredEvents = {};

  // Step 1: Identify the latest cycle
  final latestCycleId = events.keys.last;

  if (events.containsKey(latestCycleId)) {
    final latestCycleEvents = events[latestCycleId]!;
    print("Latest Events: $latestCycleEvents");

    // Step 2: Add all events from the latest cycle to filteredEvents
    latestCycleEvents.forEach((date, events) {
      if (filteredEvents.containsKey(date)) {
        filteredEvents[date]!.addAll(events);
      } else {
        filteredEvents[date] = List.from(events);
      }
    });

    // Step 3: Filter previous cycles
    events.forEach((cycleId, dateMap) {
      if (cycleId != latestCycleId) {
        bool shouldOmitFertileOvulationDays = false;

        // Check if any of the latest period days collide with fertile/ovulation days from previous cycles
        dateMap.forEach((date, events) {
          final hasCollision = events.any((event) {
            return (event.title == 'Fertile Day' || event.title == 'Ovulation Day') && 
                   latestCycleEvents.keys.any((latestDate) {
                     // Check if the latest period days collide with fertile/ovulation days
                     return isSameDay(latestDate, date) ||
                            latestDate.isAfter(date) && latestDate.isBefore(date.add(const Duration(days: 5)));
                   });
          });
          print("Collided Events: $hasCollision");

          if (hasCollision) {
            shouldOmitFertileOvulationDays = true;
          }
        });

        // Additional step: Check if previous cycles' dates also collide with those of later cycles
        events.forEach((laterCycleId, laterDateMap) {
          //condition ensures that we only consider cycles that are neither the current one nor the latest one
          if (laterCycleId != cycleId && laterCycleId != latestCycleId) {
            dateMap.forEach((date, events) {
              final hasCollisionWithlaterCycle = events.any((event) {
                return (event.title == 'Fertile Day' || event.title == 'Ovulation Day') && 
                       laterDateMap.keys.any((laterDate) {
                         return isSameDay(laterDate, date) ||
                                laterDate.isAfter(date) && laterDate.isBefore(date.add(const Duration(days: 5)));
                       });
              });

              if (hasCollisionWithlaterCycle) {
                shouldOmitFertileOvulationDays = true;
              }
            });
          }
        });

        // Filter out the events based on collision detection and omit predicted period days regardless
        dateMap.forEach((date, events) {
          final newEventList = events.where((event) {
            // Always omit predicted period days
            if (event.title == 'Predicted Period Day') {
              return false;
            }
            // Remove fertile and ovulation days if there was a collision
            return !shouldOmitFertileOvulationDays || (event.title != 'Fertile Day' && event.title != 'Ovulation Day');
          }).toList();

          if (newEventList.isNotEmpty) {
            print("new Event List: $newEventList");
            if (filteredEvents.containsKey(date)) {
              filteredEvents[date]!.addAll(newEventList);
            } else {
              filteredEvents[date] = List.from(newEventList);
            }
          }
        });
      }
    });
  }

  return filteredEvents;
}


    // Method to validate date range
  bool _isDateRangeValid(DateTime start, DateTime end) {
    final difference = end.difference(start).inDays + 1; // +1 to include the start day
    return difference <= 7; // Ensure the range does not exceed 7 days
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime? focusedDay) {
    if (start != null && end != null && !_isDateRangeValid(start, end)) {
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: const Text('Invalid Selection'),
          content: const Text('Please select a date range of 7 days or less. The average period typically lasts between 3 to 7 days.'),
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


  //Function to handle adding and updating log entries in list Database
  void _updateOrAddCycle(DateTime start, [DateTime? end]) {
    // If end date is not provided, set it to the start date
    end ??= start;

    final DateTime now = DateTime.now();
    int averagePeriods = calculateAveragePeriodLength(cycles);
    if (isSameDay(start, now) || isSameDay(end, now)) {
      end = start.add( Duration(days: averagePeriods));
    }

    //Handling cases where a user might log an already logged date in their previous cycle, hence warning them using a snackbar
    for (Cycle cycle in cycles) {
      if (_datesOverlap(cycle.periodStart, cycle.periodEnd, start, end)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The selected period overlaps with an existing cycle. Please choose different dates.'),
          ),
        );
        return; // Exit the function without adding the cycle
      }
    }

    // If no overlap, add a new cycle
    final Cycle newCycle = predictCycle(start, end);
    cycles.add(newCycle);
    //_updateEventsForCycle(newCycle);
  }

  // void _updateEventsForCycle(Cycle cycle) {
  //   // Remove old events for this cycle from the events map
  //   events.remove(cycle.cycleId);

  //   // Generate and add new events for the updated cycle
  //   final newEvents = EventUtils.generateEvents([cycle]);
  //   events[cycle.cycleId] = newEvents[cycle.cycleId]!;

  //   // Update the flattened events map for display
  //   setState(() {
  //     _flatEvents = _flattenEvents(events);
  //   });
  // }

  // Function to check if two date ranges overlap
  bool _datesOverlap(DateTime start1, DateTime end1, DateTime start2, DateTime end2) {
    return (start1.isBefore(end2) || isSameDay(start1, end2)) && 
    (start2.isBefore(end1) || isSameDay(start2, end1));
  }

 

  @override
  Widget build(BuildContext context) {
    //events = EventUtils.generateEvents(cycles);
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
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return _filteredEvents[day] ?? [];
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isEmpty) {
                  return null;
                }
                final eventList = events.cast<Event>();
                return EventsMaker(date: date, events: eventList);
              },
            ),
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
                    if (_startDate != null) {
                      final endDate = _endDate ?? _startDate!; // The else statement handles where a period only happens for a single day hence the end date will be same day as start date 
                      _updateOrAddCycle(_startDate!, endDate);
                      printCycles(cycles);
                      context.goNamed(RouteNames.PERIOD_PLANNER_SCREEN);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select your Period start and end dates.')),
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





