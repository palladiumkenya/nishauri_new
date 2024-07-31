import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

//Algorithm
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

  CustomCalendar({this.initialFormat = CalendarFormat.month});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  late CalendarFormat _calendarFormat;

  // Define ovulation and period days
  final List<DateTime> fertileDays = [
    DateTime(2024, 8, 13),
    DateTime(2024, 8, 14),
    DateTime(2024, 8, 15),
    DateTime(2024, 8, 16),
    DateTime(2024, 8, 17),
  ];

  final List<DateTime> periodDays = [
    DateTime(2024, 8, 5),
    DateTime(2024, 8, 6),
    DateTime(2024, 8, 7),
    DateTime(2024, 8, 8),
    DateTime(2024, 8, 9),
  ];

  final DateTime ovulationDay = DateTime(2024, 8, 18);

  @override
  void initState() {
    super.initState();
    _calendarFormat = widget.initialFormat;
  }

  double _getOpacity(DateTime day, DateTime eventDay) {
    // Calculate the number of days between the event and the current day
    final difference = day.difference(eventDay).inDays;
    // Adjust the opacity based on the difference
    final maxDays = 5; // Maximum days after the event for full opacity
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
        defaultBuilder: (context, day, focusedDay) {
          for (DateTime eventDay in fertileDays) {
            if (isSameDay(day, eventDay)) {
              return Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(_getOpacity(day, eventDay)),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          }

          for (DateTime eventDay in periodDays) {
            if (isSameDay(day, eventDay)) {
              return Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(_getOpacity(day, eventDay)),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          }

          if (isSameDay(day, ovulationDay)) {
            return Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.8), // Fixed opacity for ovulation day
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          return null;
        },
      ),
    );
  }
}
