import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';

class EventUtils {
  static Map<DateTime, List<Event>> generateEvents(List<Cycle> cycles) {
    Map<DateTime, List<Event>> events = {};
    debugPrint("-----Generating New Events From Event Utils-----");

    for (Cycle cycle in cycles) {
      // Add period days
      for (DateTime date = cycle.periodStart;
          date.isBefore(cycle.periodEnd) || date.isAtSameMomentAs(cycle.periodEnd);
          date = date.add(const Duration(days: 1))) {
        events.update(date, (existingEvents) => existingEvents..add(Event('Period Day', Colors.pink)), ifAbsent: () => [Event('Period Day', Colors.pink)]);
        debugPrint("Successfully Added Period Days: $date");
      }

      // Add fertile window days
      for (DateTime date = cycle.fertileStart;
          date.isBefore(cycle.fertileEnd) || date.isAtSameMomentAs(cycle.fertileEnd);
          date = date.add(const Duration(days: 1))) {
        events.update(date, (existingEvents) => existingEvents..add(Event('Fertile Day', Colors.green)), ifAbsent: () => [Event('Fertile Day', Colors.green)]);
        debugPrint("Successfully Added Fertile Days: $date");
      }

      // Add ovulation day
      events.update(cycle.ovulation, (existingEvents) => existingEvents..add(Event('Ovulation Day', Colors.blue)), ifAbsent: () => [Event('Ovulation Day', Colors.blue)]);
      debugPrint("Successfully Added Ovulation Day: ${cycle.ovulation}");

      // Add predicted period start
      for (DateTime date = cycle.predictedPeriodStart;
          date.isBefore(cycle.predictedPeriodEnd) || date.isAtSameMomentAs(cycle.predictedPeriodEnd);
          date = date.add(const Duration(days: 1))) {
        events.update(date, (existingEvents) => existingEvents..add(Event('Predicted Period Day', Colors.pink)), ifAbsent: () => [Event('Predicted Period Day', Colors.orange)]);
        debugPrint("Successfully Added Predicted Period Days: $date");
      }
    }

    return events;
  }
}
