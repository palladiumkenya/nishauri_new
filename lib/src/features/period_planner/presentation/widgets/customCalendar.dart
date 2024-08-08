import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/eventsMaker.dart';
import 'package:nishauri/src/features/period_planner/utils/event_utils.dart';
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
  final Map<DateTime, List<Event>> events;

   CustomCalendar({
    //Key? key,
    this.initialFormat = CalendarFormat.month, 
    required this.events,
    });

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}
class _CustomCalendarState extends State<CustomCalendar>{
  late CalendarFormat _calendarFormat;
  //late Map<DateTime, List<Event>> _events;

   @override
  void initState() {
    super.initState();
    _calendarFormat = widget.initialFormat;
    //events = EventUtils.generateEvents(cycles);
    //events = widget.events;
    //_events = widget.events;
  }

  // void updateEvents(Map<DateTime, List<Event>> newEvents) {
  //   setState(() {
  //     _events = newEvents;
  //     debugPrint("Updated Calendar Events: $_events");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      //key: ValueKey(_events),
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
        // return widget.events[day] ?? [];
        return widget.events[day] ?? [];
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
          if (events.isEmpty) {
            //debugPrint('Error getting Events!! - List is empty for date: $date');
            return null;
          }
          final eventList = events.cast<Event>();
          
          debugPrint("-----From CustomCalendar------");
          debugPrint('Successfully cast events for date: $date, events: $eventList');

          return EventsMaker(date: date, events: eventList);
        },
      ),
    );
  }
}

