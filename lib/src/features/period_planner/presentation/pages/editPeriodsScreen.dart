import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class EditPeriods extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  const EditPeriods({super.key, this.initialStartDate, this.initialEndDate});

  @override
  State<EditPeriods> createState() => _EditPeriodsState();
}

class _EditPeriodsState extends State<EditPeriods> {
  late DateTime _focusedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

   @override
  void initState() {
    super.initState();
     
    _focusedDay = widget.initialStartDate ?? DateTime.now();
    _rangeStart = widget.initialStartDate;
    _rangeEnd = widget.initialEndDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Edit Period 🌸",
            color: Constants.periodPlanner,
          ),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2021),
            lastDay: DateTime(2100),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _rangeStart = start;
                _rangeEnd = end;
                _focusedDay = focusedDay;
              });
            },
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
        ],
      ),
    );
  }
}