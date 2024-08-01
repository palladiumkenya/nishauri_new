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

  @override
  Widget build(BuildContext context) {
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