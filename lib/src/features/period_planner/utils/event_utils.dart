import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:table_calendar/table_calendar.dart';

/*
This class is responsible for generating events based the logged period days 
and the days the algorithm predicts(Fertile, Ovulation and Predicted Next Period days)

The Events in this case are Period, Fertile, Ovulation and Predicted Period Day of a cycle.
The Days that are within Period Days are give a title of Period Day and a color of Colors.pink.
The rest happens for the other days.
*/
class EventUtils {
  static Map<int, Map<DateTime, List<Event>>> generateEvents(
      Map<int, Cycle> cyclesMap) {
    Map<int, Map<DateTime, List<Event>>> events = {};
    // debugPrint("-----Generating New Events From Event Utils-----");

    for (int cycleId in cyclesMap.keys) {
      final cycle = cyclesMap[cycleId];

      if (cycle == null) continue;

      if (!events.containsKey(cycleId)) {
        events[cycleId] = {};
      }

      Map<DateTime, List<Event>> updatedEvents = events[cycleId]!;

      // Add period days

      for (DateTime date = cycle.period_start;
          date.isBefore(cycle.period_end) ||
              isSameDay(date, cycle.period_end);
          date = date.add(const Duration(days: 1))) {
        updatedEvents.update(
          date,
          (existingEvents) =>
              existingEvents..add(Event('Period Day', Colors.pink)),
          ifAbsent: () => [Event('Period Day', Colors.pink)],
        );
      }

      // Add fertile window days
      for (DateTime date = cycle.fertile_start;
          date.isBefore(cycle.fertile_end) ||
              isSameDay(date, cycle.fertile_end);
          date = date.add(const Duration(days: 1))) {
        updatedEvents.update(
          date,
          (existingEvents) =>
              existingEvents..add(Event('Fertile Day', Colors.green)),
          ifAbsent: () => [Event('Fertile Day', Colors.green)],
        );
      }

      // Add ovulation day
      updatedEvents.update(
        cycle.ovulation,
        (existingEvents) =>
            existingEvents..add(Event('Ovulation Day', Colors.blue)),
        ifAbsent: () => [Event('Ovulation Day', Colors.blue)],
      );

      // Add predicted period start
      for (DateTime date = cycle.predicted_period_start;
          date.isBefore(cycle.predicted_period_end) ||
              isSameDay(date, cycle.predicted_period_end);
          date = date.add(const Duration(days: 1))) {
        updatedEvents.update(
          date,
          (existingEvents) =>
              existingEvents..add(Event('Predicted Period Day', Colors.orange)),
          ifAbsent: () => [Event('Predicted Period Day', Colors.orange)],
        );
      }
    }

    // events.forEach((id, events) {
    //   print("Cycle Id: $id");
    //   print("[");
    //   events.forEach((date, event) {
    //     print("Date: $date, Event: $event\n");
    //   });
    //   print("]");
    // });

    // print("--------------");
    return events;
  }
}
