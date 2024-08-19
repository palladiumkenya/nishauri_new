import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/eventsMaker.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/modalContent.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

//Algorithm
Cycle predictCycle(DateTime periodStart, DateTime periodEnd, {int averageCycleLength = 28, int averagePeriodLength = 6}) {
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
  final Map<String, Map<DateTime, List<Event>>> events;
  final bool headerButton;

   CustomCalendar({
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

    //Finding the latest cycleId
    final latestCycleId = widget.events.keys.last;

    if (widget.events.containsKey(latestCycleId)) {
      final latestCycleEvents = widget.events[latestCycleId]!;

      //Add events from the latest cycle
      latestCycleEvents.forEach((date, events) {
        if (filteredEvents.containsKey(date)) {
          filteredEvents[date]!.addAll(events);
        } else {
          filteredEvents[date] = List.from(events);
        }
       });

       //Removing predicted period days from previous cycles
       widget.events.forEach((cycleId, dateMap) {
        if (cycleId != latestCycleId) {
          dateMap.forEach((date, events) {
            final newEventList = events.where((event) =>  event.title != 'Predicted Period Day').toList();
            if (newEventList.isNotEmpty) {
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

