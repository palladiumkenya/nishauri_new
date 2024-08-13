import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/calendarKey.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/eventsMaker.dart';
import 'package:nishauri/src/features/period_planner/utils/event_utils.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:table_calendar/table_calendar.dart';

//printing List which is acting as a Database
void printCycles(List<Cycle> cycles) {
  debugPrint('----Cycle Printed----');
  for (var cycle in cycles) {
    debugPrint('Cycle ID: ${cycle.cycleId}');
    debugPrint('Period Start: ${cycle.periodStart}');
    debugPrint('Period End: ${cycle.periodEnd}');
    debugPrint('Fertile Start: ${cycle.fertileStart}');
    debugPrint('Fertile End: ${cycle.fertileEnd}');
    debugPrint('Ovulation: ${cycle.ovulation}');
    debugPrint('Predicted Period Start: ${cycle.predictedPeriodStart}');
    debugPrint('Predicted Period End: ${cycle.predictedPeriodEnd}');
    debugPrint('---'); // Separator between cycles for clarity
  }
}

enum SelectionMode { range, multiple }

class EditPeriodCalendar extends StatefulWidget {

  @override
  State<EditPeriodCalendar> createState() => _EditPeriodCalendarState();
}

class _EditPeriodCalendarState extends State<EditPeriodCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _startDate;
  DateTime? _endDate;
  Map<String, Map<DateTime, List<Event>>> events = EventUtils.generateEvents(cycles);
  late Map<DateTime, List<Event>> _flatEvents;
  SelectionMode _selectionMode = SelectionMode.range;
  Set<DateTime> _selectedDates = {};

   @override
  void initState() {
    super.initState();
    _flatEvents = _flattenEvents(events);
  }

   //To flatten the events so that it can be in the form of DateTime as the key and the events as the values
  Map<DateTime, List<Event>> _flattenEvents(Map<String, Map<DateTime, List<Event>>> nestedEvents) {
  final Map<DateTime, List<Event>> flattenedEvents = {};

  nestedEvents.forEach((cycleId, dateMap) {
    print("Processing cycle: $cycleId"); // Debug: Print current cycleId
    dateMap.forEach((date, events) {
      print("Date: $date, Events: $events"); // Debug: Print date and events being processed
      if (flattenedEvents.containsKey(date)) {
        flattenedEvents[date]!.addAll(events);
      } else {
        flattenedEvents[date] = List.from(events);
      }
    });
  });

  print("Flattened Events: $flattenedEvents"); // Debug: Print final flattened events
  return flattenedEvents;
}

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime? focusedDay) {
    setState(() {
      _startDate = start;
      _endDate = end;
      _focusedDay = focusedDay ?? _focusedDay;
    });
  } 

  //Handling selection of individual dates
    void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;

      // if (_selectionMode == SelectionMode.range) {
      //   if (_startDate == null) {
      //     _startDate = selectedDay;
      //   } else if (_endDate == null) {
      //     _endDate = selectedDay.isAfter(_startDate!) ? selectedDay : _startDate;
      //     _startDate = selectedDay.isAfter(_startDate!) ? _startDate : selectedDay;
      //   } else {
      //     _startDate = selectedDay;
      //     _endDate = null;
      //   }
      // } 
        if (_selectedDates.contains(selectedDay)) {
          _selectedDates.remove(selectedDay);
        } else {
          _selectedDates.add(selectedDay);
        }
    });
  }



  //Function to handle adding and updating log entries in list Database
  void _updateOrAddCycle(DateTime start, DateTime end) {
    final Cycle newCycle = predictCycle(start, end);
      cycles.add(newCycle);
  }

  // Logic to handle individual date addition
  void _updateOrAddDates() {
  if (_selectedDates.isNotEmpty) {
    final List<DateTime> sortedDates = _selectedDates.toList()..sort();
    DateTime periodStart = sortedDates.first;
    DateTime periodEnd = sortedDates.last;

    // If only one date is selected
    if (_selectedDates.length == 1) {
      // Check if the selected date is DateTime.now()
      if (isSameDay(periodStart, DateTime.now())) {
        // Set the end date to six days after the selected date
        periodEnd = periodStart.add(const Duration(days: 6));
      } else {
        // If not, just set periodEnd to periodStart (one-day period)
        periodEnd = periodStart;
      }
    }

    final Cycle newCycle = predictCycle(periodStart, periodEnd);
    cycles.add(newCycle);

    printCycles(cycles);
  } else {
    // Handle case where no dates are selected
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select your Period start and end dates.')),
    );
  }
  }



  @override
  Widget build(BuildContext context) {
    //events = EventUtils.generateEvents(cycles);
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Log Periods 📅",
            color: Constants.periodPlanner.withOpacity(1.0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleButtons(
              isSelected: [
                _selectionMode == SelectionMode.range,
                _selectionMode == SelectionMode.multiple,
              ],
              onPressed: (index) {
                setState(() {
                  _selectionMode = index == 0 ? SelectionMode.range : SelectionMode.multiple;
                  _startDate = null;
                  _endDate = null;
                  _selectedDates.clear();
                });
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Range'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Multiple Dates'),
                ),
              ],
            ),
          ),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime.now(),
            rangeStartDay: _selectionMode == SelectionMode.range ? _startDate : null,
            rangeEndDay: _selectionMode == SelectionMode.range ? _endDate : null,
            onRangeSelected: _onRangeSelected,
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) {
              return _selectedDates.contains(day);
            },
            rangeSelectionMode: _selectionMode == SelectionMode.range
                ? RangeSelectionMode.toggledOn
                : RangeSelectionMode.disabled,
            eventLoader: (day) {
              return _flatEvents[day] ?? [];
            },
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
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.periodPlanner,
                  ),
                  onPressed: () {
                    if (_selectionMode == SelectionMode.range) {
                      if (_startDate != null) {
                        final endDate = _endDate ?? _startDate!;
                        _updateOrAddCycle(_startDate!, endDate);
                        printCycles(cycles);
                        context.goNamed(RouteNames.PERIOD_PLANNER_SCREEN);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select your Period start and end dates.')),
                        );
                      }
                    } else if (_selectionMode == SelectionMode.multiple) {
                      _updateOrAddDates();
                      context.goNamed(RouteNames.PERIOD_PLANNER_SCREEN);
                    }
                  },
                  child: Text(
                    'Apply',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





