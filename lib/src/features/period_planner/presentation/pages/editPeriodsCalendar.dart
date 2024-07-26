import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class EditPeriodCalendar extends StatefulWidget {
  @override
  State<EditPeriodCalendar> createState() => _EditPeriodCalendarState();
}

class _EditPeriodCalendarState extends State<EditPeriodCalendar> {
  // List of selected dates
  final List<DateTime> _selectedDates = [];

  // Callback when a day is selected
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      if (_selectedDates.contains(day)) {
        _selectedDates.remove(day);
      } else {
        _selectedDates.add(day);
      }
    });
  }

  // Check if a day is selected
  bool _isDaySelected(DateTime day) {
    return _selectedDates.contains(day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Log Periods",
            color: Constants.periodPlanner.withOpacity(1.0),
          ),
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime(2010),
            lastDay: DateTime(2100),
            selectedDayPredicate: (day) => _isDaySelected(day),
            onDaySelected: _onDaySelected,
            calendarStyle:  CalendarStyle(
              todayDecoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              selectedDecoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(color: Colors.pink),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
        ],
      ),
    );
  }
}
