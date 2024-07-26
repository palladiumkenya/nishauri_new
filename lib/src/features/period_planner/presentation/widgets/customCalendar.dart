import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final CalendarFormat initialFormat;

  CustomCalendar({this.initialFormat = CalendarFormat.month});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  //DateTime _selectedDay = DateTime.now();
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

  final DateTime ovulationDay = DateTime(2024, 8 ,18);

  @override
  void initState() {
    super.initState();
    _calendarFormat = widget.initialFormat;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(2010),
      lastDay: DateTime(2100),
      focusedDay: _focusedDay,
      // selectedDayPredicate: (day) {
      //   return isSameDay(_selectedDay, day);
      // },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          //_selectedDay = selectedDay;
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
        // selectedDecoration: BoxDecoration(
        //   color: Colors.pink,
        //   shape: BoxShape.circle,
        // ),
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
          for (DateTime ovulationDay in fertileDays) {
            if (isSameDay(day, ovulationDay)) {
              return Container(
                margin: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  color: Colors.green,
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

          for (DateTime periodDay in periodDays) {
            if (isSameDay(day, periodDay)) {
              return Container(
                margin: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  color: Colors.pink,
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

          if(isSameDay(day, ovulationDay)) {
            return Container(
              margin: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  color: Colors.blue,
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
