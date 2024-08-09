import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/eventsMaker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

//Algorithm
//Make the following parameter optional
Cycle predictCycle(DateTime periodStart, DateTime periodEnd, {int averageCycleLength = 28, int averagePeriodLength = 7}) {
  var uuid = const Uuid();
  String cycleId = uuid.v4(); //Generating a unique id

  DateTime predictedPeriodStart = periodStart.add(Duration(days: averageCycleLength));
  DateTime predictedPeriodEnd = predictedPeriodStart.add(Duration(days: averagePeriodLength));

  //calculating ovulation day (14 days before predicted period start)
  DateTime ovulation = predictedPeriodStart.subtract(const Duration(days: 14));

  //calculating fertile window (5 days leading up to and including ovulation day)
  DateTime fertileStart = ovulation.subtract(const Duration(days: 5));
  DateTime fertileEnd = ovulation.subtract(const Duration(days: 1));

  return Cycle(
    cycleId: cycleId, 
    periodStart: periodStart, 
    periodEnd: periodEnd, 
    fertileStart: fertileStart, 
    fertileEnd: fertileEnd, 
    ovulation: ovulation, 
    predictedPeriodStart: predictedPeriodStart, 
    predictedPeriodEnd: predictedPeriodEnd,
  );
}

class CustomCalendar extends StatefulWidget {
  final CalendarFormat initialFormat;
  final Map<String, Map<DateTime, List<Event>>> events;

   CustomCalendar({
    Key? key,
    this.initialFormat = CalendarFormat.month, 
    required this.events,
    }) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}
class _CustomCalendarState extends State<CustomCalendar>{
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _flatEvents;

   @override
  void initState() {
    super.initState();
    _calendarFormat = widget.initialFormat;
    _flatEvents = _flattenEvents(widget.events);
  }

  //To flatten the events so that it can be in the form of DateTime as the key and the events as the values
  Map<DateTime, List<Event>> _flattenEvents(Map<String, Map<DateTime, List<Event>>> nestedEvents) {
  final Map<DateTime, List<Event>> flattenedEvents = {};

  nestedEvents.forEach((cycleId, dateMap) {
    print("Processing cycle: $cycleId"); // Debug: Print current cycleId
    dateMap.forEach((date, events) {
      print("Date: $date, Events: $events"); // Debug: Print date and events being processed
      if (flattenedEvents.containsKey(date)) {
        flattenedEvents[date]!.addAll(events);
      } else {
        flattenedEvents[date] = List.from(events);
      }
    });
  });

  print("Flattened Events: $flattenedEvents"); // Debug: Print final flattened events
  return flattenedEvents;
}


  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      key: ValueKey(widget.events),
      firstDay: DateTime(2010),
      lastDay: DateTime(2100),
      focusedDay: DateTime.now(),
      // onDaySelected: (selectedDay, focusedDay) {
      //   setState(() {
      //     _focusedDay = focusedDay;
      //   });
      // },
      calendarFormat: _calendarFormat,
      eventLoader: (day) {
        print("---Event Loader");
        print(day);
        return _flatEvents[day] ?? [];
      },
      headerVisible: true,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
      ),
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

