import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/eventsMaker.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/modalContent.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

//Function to calculate Average Cycle days
// Function to calculate Average Cycle days
int calculateAverageCycleLength(List<Cycle> cycles) {
  if (cycles.length < 2) {
    debugPrint("Not enough cycles to calculate an average, defaulting to 28 days.");
    return 28; // Default to 28 if there aren't enough cycles
  }

  int totalLength = 0;
  for (int i = 1; i < cycles.length; i++) {
    int cycleLength = cycles[i].periodStart.difference(cycles[i - 1].periodStart).inDays;
    debugPrint("Cycle Length before adjustment for cycle $i: $cycleLength");

    // Cap to a minimum cycle length of 21 days
    if (cycleLength < 21) {
      debugPrint("Cycle Length $cycleLength is less than 21 days, defaulting to 26 days.");
      cycleLength = 26;
    }

    debugPrint("Cycle Length after check for cycle $i: $cycleLength");
    totalLength += cycleLength;
  }

  int averageCycle = (totalLength / (cycles.length - 1)).round();
  debugPrint("Calculated Average Cycle Length before final check: $averageCycle");

  if (averageCycle < 21) {
    debugPrint("Average Cycle Length $averageCycle is less than 21 days, defaulting to 26 days.");
    return 26;
  }

  debugPrint("Final Average Cycle Length: $averageCycle");
  return averageCycle;
}



//Function for calculating Average Period days
int calculateAveragePeriodLength(List<Cycle> cycles) {
  if (cycles.isEmpty) return 5; // Default to 5 days if there are no cycles

  int totalPeriodLength = 0;
  for (Cycle cycle in cycles) {
    debugPrint("Period Length : ${cycle.periodLength}");
    totalPeriodLength += cycle.periodLength;
  }
  int averagePeriodLength = (totalPeriodLength / cycles.length).round();
  if (averagePeriodLength < 3) {
      return 4;
  }
  debugPrint("Total Period Length: $totalPeriodLength");
  debugPrint("Number of Cycles: ${cycles.length}");
  debugPrint("Average Period Length: $averagePeriodLength");
  return averagePeriodLength;
}




// DateTime normalizeToMidnight(DateTime dateTime) {
//   return DateTime(dateTime.year, dateTime.month, dateTime.day);
// }




//Algorithm for calculating Next Period Days, Ovulation and Fertile Days
Cycle predictCycle(DateTime periodStart, DateTime periodEnd) {
  var uuid = const Uuid();
  String cycleId = uuid.v4(); //Generating a unique id

  // Calculate average cycle length from previous cycles
  int averageCycleLength = calculateAverageCycleLength(cycles);

  // Calculate average period length from the period Start to the Period End
  int averagePeriodLength = calculateAveragePeriodLength(cycles);

  DateTime predictedPeriodStart = periodStart.add(Duration(days: averageCycleLength));
  DateTime predictedPeriodEnd = predictedPeriodStart.add(Duration(days: averagePeriodLength - 1));

  //calculating ovulation day (14 days before predicted period start)
  DateTime ovulation = predictedPeriodStart.subtract(const Duration(days: 14));

  //calculating fertile window (5 days leading up to and including ovulation day)
  DateTime fertileStart = ovulation.subtract(const Duration(days: 5));
  DateTime fertileEnd = ovulation.subtract(const Duration(days: 1));

  //Calculating cycle Length between the previous cycle start and the latest cycle start
  int cycleLength = (cycles.isNotEmpty)
      ? periodStart.difference(cycles.last.periodStart).inDays
      : averageCycleLength; // Calculate cycle length only if there are previous cycles

  //Calculating period Length of each cycle
  int periodLength = periodEnd.difference(periodStart).inDays + 1;      

  return Cycle(
    cycleId: cycleId, 
    periodStart: periodStart, 
    periodEnd: periodEnd, 
    fertileStart: fertileStart, 
    fertileEnd: fertileEnd, 
    ovulation: ovulation, 
    predictedPeriodStart: predictedPeriodStart, 
    predictedPeriodEnd: predictedPeriodEnd,
    cycleLength: cycleLength,
    periodLength: periodLength,
  );
}

  //Removing predicted period days from previous cycles
      //  widget.events.forEach((cycleId, dateMap) {
      //   if (cycleId != latestCycleId) {
      //     dateMap.forEach((date, events) {
      //       final newEventList = events.where((event) =>  event.title != 'Predicted Period Day').toList();
      //       if (newEventList.isNotEmpty) {
      //         if (filteredEvents.containsKey(date)) {
      //           filteredEvents[date]!.addAll(newEventList);
      //         } else {
      //           filteredEvents[date] = List.from(newEventList);
      //         }
      //       }
      //      });
          
      //     /*
      //     Checks if the period date from the latest cycle collides with the 
      //     Ovulation days or Fertile Days of Previous Cycles or if they are before
      //     */
      //     dateMap.forEach((date, events) {
      //       final hasCollision = events.any((event) {
      //       return (event.title == 'Fertile Day' || event.title == 'Ovulation Day') &&
      //              latestCycleEvents.keys.any((latestDate) {
      //                // Check if the latest period days collide with fertile/ovulation days
      //                return isSameDay(latestDate, (date)) ||
      //                       latestDate.isAfter(date) && latestDate.isBefore(date.add(const Duration(days: 5)));
      //              });
      //       });
      //       debugPrint("Has Collision: $hasCollision");
      //     });
      //   }
      //   });  
class CustomCalendar extends StatefulWidget {
  final CalendarFormat initialFormat;
  final Map<String, Map<DateTime, List<Event>>> events;
  final bool headerButton;

   const CustomCalendar({
    Key? key,
    this.initialFormat = CalendarFormat.month, 
    required this.events, 
    this.headerButton = false,
    }) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}
class _CustomCalendarState extends State<CustomCalendar>{
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _flatEvents;
  late Map<DateTime, List<Event>> _filteredEvents;

   @override
  void initState() {
    super.initState();
    _calendarFormat = widget.initialFormat;
    _flatEvents = _flattenEvents(widget.events);
    _filteredEvents = _filterEventsForLatestCycle();
  }

  //To flatten the events so that it can be in the form of DateTime as the key and the events as the values
  Map<DateTime, List<Event>> _flattenEvents(Map<String, Map<DateTime, List<Event>>> nestedEvents) {
  final Map<DateTime, List<Event>> flattenedEvents = {};

  nestedEvents.forEach((cycleId, dateMap) {
    dateMap.forEach((date, events) {
      if (flattenedEvents.containsKey(date)) {
        flattenedEvents[date]!.addAll(events);
      } else {
        flattenedEvents[date] = List.from(events);
      }
    });
  });
  return flattenedEvents;
  }

Map<DateTime, List<Event>> _filterEventsForLatestCycle() {
  final Map<DateTime, List<Event>> filteredEvents = {};

  // Step 1: Identify the latest cycle
  final latestCycleId = widget.events.keys.last;

  if (widget.events.containsKey(latestCycleId)) {
    final latestCycleEvents = widget.events[latestCycleId]!;
    print("Latest Events: $latestCycleEvents");

    // Step 2: Add all events from the latest cycle to filteredEvents
    latestCycleEvents.forEach((date, events) {
      if (filteredEvents.containsKey(date)) {
        filteredEvents[date]!.addAll(events);
      } else {
        filteredEvents[date] = List.from(events);
      }
    });

    // Step 3: Filter previous cycles
    widget.events.forEach((cycleId, dateMap) {
      if (cycleId != latestCycleId) {
        bool shouldOmitFertileOvulationDays = false;

        // Check if any of the latest period days collide with fertile/ovulation days from previous cycles
        dateMap.forEach((date, events) {
          final hasCollision = events.any((event) {
            return (event.title == 'Fertile Day' || event.title == 'Ovulation Day') && 
                   latestCycleEvents.keys.any((latestDate) {
                     // Check if the latest period days collide with fertile/ovulation days
                     return isSameDay(latestDate, date) ||
                            latestDate.isAfter(date) && latestDate.isBefore(date.add(const Duration(days: 5)));
                   });
          });
          print("Collided Events: $hasCollision");

          if (hasCollision) {
            shouldOmitFertileOvulationDays = true;
          }
        });

        // Additional step: Check if previous cycles' dates also collide with those of later cycles
        widget.events.forEach((laterCycleId, laterDateMap) {
          //condition ensures that we only consider cycles that are neither the current one nor the latest one
          if (laterCycleId != cycleId && laterCycleId != latestCycleId) {
            dateMap.forEach((date, events) {
              final hasCollisionWithlaterCycle = events.any((event) {
                return (event.title == 'Fertile Day' || event.title == 'Ovulation Day') && 
                       laterDateMap.keys.any((laterDate) {
                         return isSameDay(laterDate, date) ||
                                laterDate.isAfter(date) && laterDate.isBefore(date.add(const Duration(days: 5)));
                       });
              });

              if (hasCollisionWithlaterCycle) {
                shouldOmitFertileOvulationDays = true;
              }
            });
          }
        });

        // Filter out the events based on collision detection and omit predicted period days regardless
        dateMap.forEach((date, events) {
          final newEventList = events.where((event) {
            // Always omit predicted period days
            if (event.title == 'Predicted Period Day') {
              return false;
            }
            // Remove fertile and ovulation days if there was a collision
            return !shouldOmitFertileOvulationDays || (event.title != 'Fertile Day' && event.title != 'Ovulation Day');
          }).toList();

          if (newEventList.isNotEmpty) {
            print("new Event List: $newEventList");
            if (filteredEvents.containsKey(date)) {
              filteredEvents[date]!.addAll(newEventList);
            } else {
              filteredEvents[date] = List.from(newEventList);
            }
          }
        });
      }
    });
  }

  return filteredEvents;
}


  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      key: ValueKey(widget.events),
      firstDay: DateTime(2010),
      lastDay: DateTime(2100),
      focusedDay: DateTime.now(),
      // onDaySelected: (selectedDay, focusedDay) {
      //   setState(() {
      //     _focusedDay = focusedDay;
      //   });
      // },
      calendarFormat: _calendarFormat,
      eventLoader: (day) {
        return _filteredEvents[day] ?? [];
      },
      headerVisible: true,
      headerStyle: HeaderStyle(
        formatButtonVisible: widget.headerButton,        
      ),
      onFormatChanged: (format) {
        // Show the modal when the format button is pressed
        showModalBottomSheet(
          context: context,
          builder: (context) => const ModalContent(),
          showDragHandle: true,
          isScrollControlled: true,
        );
      },
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
          //debugPrint("----From CustomCalendar-----");
          //print(events);
          if (events.isEmpty) {
            //debugPrint('Error getting Events!! - List is empty for date: $date');
            return null;
          }
          final eventList = events.cast<Event>();
          
          // debugPrint("-----From CustomCalendar------");
          // debugPrint('Successfully cast events for date: $date, events: $eventList');

          return EventsMaker(date: date, events: eventList);
        },
      ),
    );
  }
}

