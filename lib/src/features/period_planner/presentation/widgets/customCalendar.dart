import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/eventsMaker.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/modalContent.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

//Function to calculate Average Cycle days
// Function to calculate Average Cycle days
int calculateAverageCycleLength(List<Cycle> cycles) {
  if (cycles.length < 2) {
    debugPrint(
        "Not enough cycles to calculate an average, defaulting to 28 days.");
    return 28; // Default to 28 if there aren't enough cycles
  }

  int totalLength = 0;
  for (int i = 1; i < cycles.length; i++) {
    int cycleLength =
        cycles[i].periodStart.difference(cycles[i - 1].periodStart).inDays;
    debugPrint("Cycle Length before adjustment for cycle $i: $cycleLength");

    // Cap to a minimum cycle length of 21 days
    if (cycleLength < 21) {
      debugPrint(
          "Cycle Length $cycleLength is less than 21 days, defaulting to 26 days.");
      cycleLength = 26;
    }

    debugPrint("Cycle Length after check for cycle $i: $cycleLength");
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

//Function for calculating Average Period days
int calculateAveragePeriodLength(List<Cycle> cycles) {
  if (cycles.isEmpty) return 5; // Default to 5 days if there are no cycles

  int totalPeriodLength = 0;
  for (Cycle cycle in cycles) {
    debugPrint("Period Length : ${cycle.periodLength}");
    totalPeriodLength += cycle.periodLength;
  }
  int averagePeriodLength = (totalPeriodLength / cycles.length).round();
  if (averagePeriodLength < 3) {
    return 4;
  }
  debugPrint("Total Period Length: $totalPeriodLength");
  debugPrint("Number of Cycles: ${cycles.length}");
  debugPrint("Average Period Length: $averagePeriodLength");
  return averagePeriodLength;
}

// DateTime normalizeToMidnight(DateTime dateTime) {
//   return DateTime(dateTime.year, dateTime.month, dateTime.day);
// }
//Algorithm for calculating Next Period Days, Ovulation and Fertile Days
Cycle predictCycle(DateTime periodStart, DateTime periodEnd) {
  var uuid = const Uuid();
  String cycleId = uuid.v4(); //Generating a unique id

  // Calculate average cycle length from previous cycles
  int averageCycleLength = calculateAverageCycleLength(cycles);

  // Calculate average period length from the period Start to the Period End
  int averagePeriodLength = calculateAveragePeriodLength(cycles);

  DateTime predictedPeriodStart =
      periodStart.add(Duration(days: averageCycleLength - 1));
  DateTime predictedPeriodEnd =
      predictedPeriodStart.add(Duration(days: averagePeriodLength - 1));

  //calculating ovulation day (14 days before predicted period start)
  DateTime ovulation = predictedPeriodStart.subtract(const Duration(days: 14));

  //calculating fertile window (5 days leading up to and including ovulation day)
  DateTime fertileStart = ovulation.subtract(const Duration(days: 5));
  DateTime fertileEnd = ovulation.subtract(const Duration(days: 1));

  //Calculating cycle Length between the previous cycle start and the latest cycle start
  int cycleLength = (cycles.isNotEmpty)
      ? periodStart.difference(cycles.last.periodStart).inDays
      : averageCycleLength; // Calculate cycle length only if there are previous cycles

  //Calculating period Length of each cycle
  int periodLength = periodEnd.difference(periodStart).inDays + 1;

  return Cycle(
    cycleId: cycleId,
    periodStart: periodStart,
    periodEnd: periodEnd,
    fertileStart: fertileStart,
    fertileEnd: fertileEnd,
    ovulation: ovulation,
    predictedPeriodStart: predictedPeriodStart,
    predictedPeriodEnd: predictedPeriodEnd,
    cycleLength: cycleLength,
    periodLength: periodLength,
  );
}

class CustomCalendar extends StatefulWidget {
  final CalendarFormat initialFormat;
  final Map<String, Map<DateTime, List<Event>>> events;
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

class _CustomCalendarState extends State<CustomCalendar> {
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
    return null;
  }

  /*Getting the first date to be displayed on the calendar
  if the function _getNextPredictedPeriodDate, the start date of the calendar is 2010
  */
  DateTime _getFirstEventDate() {
    DateTime? firstEventDate = _getNextPredictedPeriodDate();
    return  _calendarFormat == CalendarFormat.week ? firstEventDate  ?? DateTime(2010): DateTime(2010);  // Fallback to DateTime(2010) if null 
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

    return _calendarFormat == CalendarFormat.week ? lastEventDate  ?? DateTime(2100): DateTime(2100); // Fallback to DateTime(2100) if null
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
      eventLoader: (day) {
        return _filteredEvents[day] ?? [];
      },
      headerVisible: true,
      headerStyle: HeaderStyle(
        formatButtonVisible: widget.headerButton,
      ),
      onFormatChanged: (format) {
        // Show the modal when the format button is pressed
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
          //debugPrint("----From CustomCalendar-----");
          //print(events);
          if (events.isEmpty) {
            //debugPrint('Error getting Events!! - List is empty for date: $date');
            return null;
          }
          final eventList = events.cast<Event>();

          // debugPrint("-----From CustomCalendar------");
          // debugPrint('Successfully cast events for date: $date, events: $eventList');

          return EventsMaker(date: date, events: eventList);
        },
      ),
    );
  }
}
