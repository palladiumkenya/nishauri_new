import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';

class EventsMaker extends StatelessWidget {
  const EventsMaker({
    super.key,
    required this.date,
    required this.events,
  });

  final DateTime date;
  final List<Event> events;

  //Calculating Opacity
   double _calculateOpacity(DateTime eventStart, DateTime eventEnd, DateTime currentDate) {
    int totalDays = eventEnd.difference(eventStart).inDays + 1;
    int currentDayIndex = currentDate.difference(eventStart).inDays;
    return (1 - (currentDayIndex / totalDays)).clamp(0.2, 1.0);
  }

 @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 1,
      bottom: 1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: events.map((event) {
          // Example: Assuming you have the start and end dates for the event
          DateTime eventStart = date; // Update this to the actual event start date
          DateTime eventEnd = date.add(Duration(days: events.length - 1)); // Update this to the actual event end date
          
          double opacity = _calculateOpacity(eventStart, eventEnd, date);
          Color colorWithOpacity = event.color.withOpacity(opacity);

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 0.5),
            width: 7.0,
            height: 7.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorWithOpacity,
            ),
          );
        }).toList(),
      ),
    );
  }
}