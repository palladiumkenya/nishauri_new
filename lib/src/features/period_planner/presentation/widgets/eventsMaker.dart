import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';

/* 
This is responsible for the highlighting of the various events as you will see in the calendar
based on their Event Title and Color
For Example if the event is a Period Day, since the corresponding color is pink,
the day in the calendar will be highlighted in Pink. The same applies for the other events that is 
Fertile days, Ovulation days and Predicted Period Days.
*/
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
    //debugPrint("----From EventMaker Class----");
    //debugPrint("Coloured Events $events");
    // return Positioned(
    //   right: 20,
    //   bottom: 1,
    //   child: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: events.map((event) {
    //       Color color = event.color;
    //       return Container(
    //         margin: const EdgeInsets.symmetric(horizontal: 0.5),
    //         width: 7.0,
    //         height: 7.0,
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           color: color,
    //         ),
    //       );
    //     }).toList(),
    //   ),
    // );

    //Whole date highlighted
    return Stack(
      children: events.map((event) {
        return Container(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: event.color,
          ),
          alignment: Alignment.center,
          child: Text(
            date.day.toString(),
            style: const TextStyle(
              color: Colors.white, 
              //fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }
}
