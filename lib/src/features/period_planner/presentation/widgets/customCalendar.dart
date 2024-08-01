import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

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

  CustomCalendar({this.initialFormat = CalendarFormat.month, required this.events});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _calendarFormat = widget.initialFormat;
  }

  double _getOpacity(DateTime day, DateTime eventDay) {
    final difference = day.difference(eventDay).inDays;
    final maxDays = 5;
    final opacity = (1 - (difference / maxDays)).clamp(0.2, 1.0);
    return opacity;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(2010),
      lastDay: DateTime(2100),
      focusedDay: _focusedDay,
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },
      calendarFormat: _calendarFormat,
      eventLoader: (day) {
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
          //debugPrint('Successfully cast events for date: $date, events: $eventList');

          return _buildEventsMarker(date, eventList);
        },
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List<Event> events) {
    return Positioned(
      right: 1,
      bottom: 1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: events.map((event) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            width: 7.0,
            height: 7.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: event.color,
            ),
          );
        }).toList(),
      ),
    );
  }
}