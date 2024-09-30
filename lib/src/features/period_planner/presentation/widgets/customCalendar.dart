import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/data/providers/cycles_provider.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/eventsMaker.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/modalContent.dart';
import 'package:table_calendar/table_calendar.dart';

//Function to update Cycle days
void updateCycleLengths(Map<int, Cycle> cycleMap) {
  final cycles = cycleMap.values.toList();

  final updatedCycleMap = {};

  // Start from the second last cycle because the last one does not have a successor yet
  for (int i = 0; i < cycles.length - 1; i++) {
    int cycleLength =
        cycles[i + 1].period_start.difference(cycles[i].period_start).inDays;
    // cycles[i].cycle_length = cycleLength;
    final updatedCycle = cycles[i].copyWith(cycle_length: cycleLength);
    updatedCycleMap[i] = updatedCycle;
  }

  // The last cycle in the list should still use the average cycle length
  if (cycles.isNotEmpty) {
    // cycles.last.cycle_length = calculateAverageCycleLength(cycleMap);
    final lastCycle = cycles.last
        .copyWith(cycle_length: calculateAverageCycleLength(cycleMap));
    updatedCycleMap[cycles.length - 1] = lastCycle;
  }
}

// // Function to calculate Average Cycle days
int calculateAverageCycleLength(Map<int, Cycle> cyclesMap) {
  final cycles = cyclesMap.values.toList();
  if (cycles.length < 2) {
    debugPrint(
        "Not enough cycles to calculate an average, defaulting to 28 days.");
    return 28; // Default to 28 if there aren't enough cycles
  }

  int totalLength = 0;
  for (int i = 1; i < cycles.length; i++) {
    int cycleLength =
        cycles[i].period_start.difference(cycles[i - 1].period_start).inDays;
    debugPrint("Cycle Length for cycle $i: $cycleLength");

    // Cap to a minimum cycle length of 21 days
    // if (cycleLength < 21) {
    //   debugPrint(
    //       "Cycle Length $cycleLength is less than 21 days, defaulting to 26 days.");
    //   cycleLength = 26;
    // }
    totalLength += cycleLength;
  }

  int averageCycle = (totalLength / (cycles.length - 1)).round();
  debugPrint(
      "Calculated Average Cycle Length before final check: $averageCycle");

  if (averageCycle < 21) {
    debugPrint(
        "Average Cycle Length $averageCycle is less than 21 days, defaulting to 26 days.");
    return 26;
  }

  debugPrint("Final Average Cycle Length: $averageCycle");
  return averageCycle;
}

// //Function for calculating Average Period days
int calculateAveragePeriodLength(Map<int, Cycle> cycleMap) {
  final cycleList = cycleMap.values.toList();
  if (cycleList.isEmpty) return 5; // Default to 5 days if there are no cycles

  int totalPeriodLength = 0;
  for (Cycle cycle in cycleList) {
    debugPrint("Period Length : ${cycle.period_length}");
    totalPeriodLength += cycle.period_length;
  }
  int averagePeriodLength = (totalPeriodLength / cycleList.length).round();
  if (averagePeriodLength < 3) {
    return 4;
  }
  debugPrint("Total Period Length: $totalPeriodLength");
  debugPrint("Number of Cycles: ${cycleList.length}");
  debugPrint("Average Period Length: $averagePeriodLength");
  return averagePeriodLength;
}

// DateTime normalizeToMidnight(DateTime dateTime) {
//   return DateTime(dateTime.year, dateTime.month, dateTime.day);
// }

//Algorithm for calculating Next Period Days, Ovulation and Fertile Days
Cycle predictCycle(DateTime periodStart, DateTime periodEnd,
    {int? cycleId, required Map<int, Cycle> cycle}) {
  final cycleList = cycle.values.toList();

  int index = cycleId ?? cycleList.length;

  // Calculate average cycle length from previous cycles
  int averageCycleLength = calculateAverageCycleLength(cycle);

  // Calculate average period length from the period Start to the Period End
  int averagePeriodLength = calculateAveragePeriodLength(cycle);

  DateTime predictedPeriodStart =
      periodStart.add(Duration(days: averageCycleLength - 1));
  DateTime predictedPeriodEnd =
      predictedPeriodStart.add(Duration(days: averagePeriodLength - 1));

  //calculating ovulation day (14 days before predicted period start)
  DateTime ovulation = predictedPeriodStart.subtract(const Duration(days: 14));

  //calculating fertile window (5 days leading up to and including ovulation day)
  DateTime fertileStart = ovulation.subtract(const Duration(days: 5));
  DateTime fertileEnd = ovulation.subtract(const Duration(days: 1));

  //Calculating cycle Length
  // int cycleLength = (index > 0)
  //     ? periodStart.difference(cycles[index - 1].periodStart).inDays
  //     : averageCycleLength;

  int cycleLength;
  if (cycleList.isEmpty) {
    cycleLength = averageCycleLength;
  } else {
    if (index > 0 && index < cycleList.length - 1) {
      // If the current cycle has a succeeding cycle, calculate based on difference between two cycles
      cycleLength =
          periodStart.difference(cycleList[index - 1].period_start).inDays;
    } else if (index == cycleList.length - 1) {
      // If it's the last cyclStringe (no succeeding cycle), use the average cycle length as a placeholder
      cycleLength = averageCycleLength;
    } else {
      // For the very first cycle or other fallback cases, use average cycle length
      cycleLength = averageCycleLength;
    }
  }

  //Calculating period Length of each cycle
  int periodLength = periodEnd.difference(periodStart).inDays + 1;

  return Cycle(
    // cycleId: cycleId ?? uuid.v4(),
    period_start: periodStart,
    period_end: periodEnd,
    fertile_start: fertileStart,
    fertile_end: fertileEnd,
    ovulation: ovulation,
    predicted_period_start: predictedPeriodStart,
    predicted_period_end: predictedPeriodEnd,
    cycle_length: cycleLength,
    period_length: periodLength,
  );
}

class CustomCalendar extends ConsumerStatefulWidget {
  final CalendarFormat initialFormat;
  final Map<int, Map<DateTime, List<Event>>> events;
  final bool headerButton;
  final bool? inPeriods;

  const CustomCalendar({
    Key? key,
    this.initialFormat = CalendarFormat.month,
    required this.events,
    this.headerButton = false,
    this.inPeriods,
  }) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends ConsumerState<CustomCalendar> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  //late Map<DateTime, List<Event>> _flatEvents;
  late Map<DateTime, List<Event>> _filteredEvents;

  @override
  void initState() {
    super.initState();
    _calendarFormat = widget.initialFormat;
    //_flatEvents = _flattenEvents(widget.events);
    _filteredEvents = _filterEventsForLatestCycle();
    // Determine the focused day based on the calendar format
    _focusedDay = _calendarFormat == CalendarFormat.week
        ? _getNextPredictedPeriodDate() ?? DateTime.now()
        : DateTime.now();
    _firstDay = _getFirstEventDate();
    _lastDay = _getLastEventDate();
  }

  //To flatten the events so that it can be in the form of DateTime as the key and the events as the values
  // Map<DateTime, List<Event>> _flattenEvents(Map<String, Map<DateTime, List<Event>>> nestedEvents) {
  // final Map<DateTime, List<Event>> flattenedEvents = {};

  // nestedEvents.forEach((cycleId, dateMap) {
  //   dateMap.forEach((date, events) {
  //     if (flattenedEvents.containsKey(date)) {
  //       flattenedEvents[date]!.addAll(events);
  //     } else {
  //       flattenedEvents[date] = List.from(events);
  //     }
  //   });
  // });
  // return flattenedEvents;
  // }

//This is for filtering events on the calendar
  Map<DateTime, List<Event>> _filterEventsForLatestCycle() {
    final Map<DateTime, List<Event>> filteredEvents = {};

    // Identify the latest cycle
    final latestCycleId = widget.events.keys.last;

    // If the latest cycle exists, add its events to the filteredEvents map
    if (widget.events.containsKey(latestCycleId)) {
      final latestCycleEvents = widget.events[latestCycleId]!;

      // Directly add all events from the latest cycle
      latestCycleEvents.forEach((date, events) {
        filteredEvents[date] = List.from(events);
      });
    }

    // debugPrint("Filtered Events: $filteredEvents");
    return filteredEvents;
  }

  //Function for getting the focused day
  DateTime? _getNextPredictedPeriodDate() {
    for (var entry in _filteredEvents.entries) {
      if (widget.inPeriods == true) {
        // Return the first date with a 'Period Day' event
        if (entry.value.any((event) => event.title == 'Period Day')) {
          return entry.key;
        }
      } else {
        // Return the first date with a 'Predicted Period Day' event
        if (entry.value.any((event) => event.title == 'Predicted Period Day')) {
          return entry.key;
        }
      }
    }
    debugPrint("No matching events found.");
    return null;
  }

  /*Getting the first date to be displayed on the calendar
  if the function _getNextPredictedPeriodDate, the start date of the calendar is 2010
  */
  DateTime _getFirstEventDate() {
    DateTime? firstEventDate = _getNextPredictedPeriodDate();
    return _calendarFormat == CalendarFormat.week
        ? firstEventDate ?? DateTime(2010)
        : DateTime(2010); // Fallback to DateTime(2010) if null
  }

  /*Getting the last date to be displayed on the calendar
  if the function _getNextPredictedPeriodDate, the last date of the calendar is 2100
  */
  DateTime _getLastEventDate() {
    DateTime? lastEventDate;

    for (var entry in _filteredEvents.entries.toList().reversed) {
      if (widget.inPeriods == true) {
        // Return the last date with a 'Period Day' event
        if (entry.value.any((event) => event.title == 'Period Day')) {
          lastEventDate = entry.key;
          break;
        }
      } else {
        // Return the last date with a 'Predicted Period Day' event
        if (entry.value.any((event) => event.title == 'Predicted Period Day')) {
          lastEventDate = entry.key;
          break;
        }
      }
    }

    return _calendarFormat == CalendarFormat.week
        ? lastEventDate ?? DateTime(2100)
        : DateTime(2100); // Fallback to DateTime(2100) if null
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      key: ValueKey(widget.events),
      firstDay: _firstDay,
      lastDay: _lastDay,
      focusedDay: _focusedDay,
      // onDaySelected: (selectedDay, focusedDay) {
      //   setState(() {
      //     _focusedDay = focusedDay;
      //   });
      // },
      calendarFormat: _calendarFormat,
      // eventLoader: (day) {
      //   return _filteredEvents[day] ?? [];
      // },
      eventLoader: (day) {
        DateTime normalizedDay = DateTime(day.year, day.month, day.day);
        return _filteredEvents[normalizedDay] ?? [];
      },

      headerVisible: true,
      headerStyle: HeaderStyle(
        formatButtonVisible: widget.headerButton,
        //Conditionally hide chevrons if the calendar is in a weekly format
        leftChevronVisible: _calendarFormat != CalendarFormat.week,
        rightChevronVisible: _calendarFormat != CalendarFormat.week,
        headerPadding: const EdgeInsets.all(8.0),
      ),
      onFormatChanged: (format) {
        showModalBottomSheet(
          context: context,
          builder: (context) => const ModalContent(),
          showDragHandle: true,
          isScrollControlled: true,
        );
      },
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: true,
        todayDecoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        defaultDecoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        weekendDecoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Colors.black),
        weekdayStyle: TextStyle(color: Colors.black),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          // debugPrint("----From CustomCalendar-----");
          print(events);
          if (events.isEmpty) {
            // debugPrint('Error getting Events!! - List is empty for date: $date');
            return null;
          }
          final eventList = events.cast<Event>();

          // debugPrint("-----From CustomCalendar------");
          // debugPrint(
          //     'Successfully cast events for date: $date, events: $eventList');

          return EventsMaker(date: date, events: eventList);
        },
      ),
    );
  }
}
