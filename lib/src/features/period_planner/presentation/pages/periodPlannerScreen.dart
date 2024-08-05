import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/editPeriodsCalendar.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/carouselCard.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/logItems.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/loggerWidget.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:table_calendar/table_calendar.dart';

class PeriodPlannerScreen extends StatefulWidget {
  const PeriodPlannerScreen({super.key});

  @override
  State<PeriodPlannerScreen> createState() => _PeriodPlannerScreenState();
}

class _PeriodPlannerScreenState extends State<PeriodPlannerScreen> {
  DateTime _currentDate = DateTime.now();
  late DateTime _periodStart;
  late DateTime _periodEnd; 
  late DateTime _ovulationDate; 
  late DateTime _nextPeriodStart;

  @override
  void initState() {
    super.initState();
    if (cycles.isNotEmpty) {
      Cycle latestCycle = cycles.last;
      _periodStart = latestCycle.periodStart;
      _periodEnd = latestCycle.periodEnd;
      _ovulationDate = latestCycle.ovulation;
      _nextPeriodStart = latestCycle.predictedPeriodStart;
    }
  }

  //Function to check if two dates are on the same day by truncating the time part
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    //late bool endOfPeriod; // handling when user has logged end of period
    //handling the days before, after or during the various phases in the Menstrual Cycle
    int daysToOvulation = _ovulationDate.difference(_currentDate).inDays;
    int daysToNextPeriod = _nextPeriodStart.difference(_currentDate).inDays;

    bool isInPeriod = (isSameDay(_currentDate, _periodStart) || _currentDate.isAfter(_periodStart)) && _currentDate.isBefore(_periodEnd);
    bool veryCloseToPeriod = _currentDate.isBefore(_nextPeriodStart) && daysToNextPeriod == 0;
    bool isCloseToOvulation = _currentDate.isBefore(_ovulationDate) && !isInPeriod && daysToOvulation>=1 ;
    bool veryCloseToOvulation = _currentDate.isBefore(_ovulationDate) && daysToOvulation == 0;
    bool isOvulation = (isSameDay(_currentDate, _ovulationDate)) || (_currentDate.isAfter(_ovulationDate) && daysToOvulation == 0);
    //two days after ovulation -- I'm thinking about it though
    bool afterOvulation = _currentDate.isAfter(_ovulationDate) && (_currentDate.isBefore(_nextPeriodStart) && daysToNextPeriod>0);


    // Determine progress value and messages based on the current date
    double progressValue = 0.0;
    String message = '';
    String buttonText = '';

    if (isInPeriod) {
      progressValue = 0.2;
      message = 'Day ${DateTime.now().difference(_periodStart).inDays + 1}';
      buttonText = 'Log End Period';
    } else if (isCloseToOvulation) {
      progressValue = 0.3;
      message = '$daysToOvulation days';
      buttonText = '';
    } else if (veryCloseToOvulation) {
      progressValue = 0.4;
      message = 'Tomorrow';
      buttonText = '';
    } else if (isOvulation) {
      progressValue = 0.5;
      message = 'Today';
      buttonText = '';
    } else if (afterOvulation) {
      progressValue = 0.7; 
      message = '$daysToNextPeriod days';
      buttonText = 'Log Period';
    } else if (veryCloseToPeriod) {
      progressValue = 0.7; 
      message = 'Tomorrow';
      buttonText = 'Log Period';
    } 
    else {
      progressValue = 1.0;
      message = 'Cycle Complete';
      buttonText = '';
    }

    //Debug prints to trace the logic
    // debugPrint('Current Date: $_currentDate');
    // debugPrint('Period Start: $_periodStart');
    // debugPrint('Period End: $_periodEnd');
    // debugPrint('Is In Period: $isInPeriod');
    debugPrint('-----Widget Rebuild-----');
    debugPrint('Is In Period: $isInPeriod');
    debugPrint('Is close to Ovulation: $isCloseToOvulation');
  

    //Mapping the events
    Map<DateTime, List<Event>> events = _generateEvents(cycles);

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Track Periods 🌸",
            color: Constants.periodPlanner,
          ),
          //const SizedBox(height: Constants.SPACING),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          context.goNamed(RouteNames.PERIOD_PLANNER_CALENDAR);
                        }, 
                        icon: const Icon(Icons.calendar_month),
                        ),
                    ),
                    SizedBox(
                      height: 150,
                      child: CustomCalendar(initialFormat: CalendarFormat.week, events: events),
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: Constants.SPACING * 30, // Adjust the width as needed
                          height: Constants.SPACING * 30, // Adjust the height as needed
                          child: CircularProgressIndicator(
                            value: progressValue, 
                            strokeWidth: 10,
                            backgroundColor: Colors.grey,
                            valueColor: const AlwaysStoppedAnimation<Color>(Constants.periodPlanner),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isInPeriod 
                              ? 'Period' : veryCloseToPeriod 
                                ? 'Next Period is':  isCloseToOvulation 
                                  ? 'Ovulation in': veryCloseToOvulation 
                                    ? 'Ovulation is':  isOvulation 
                                      ? 'Ovulation is' : afterOvulation 
                                        ? 'Next Period in' 
                                          : 'Error',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            Text(
                              message,
                              style: const TextStyle(fontSize: 38, color: Constants.periodPlanner, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            Text(
                              isInPeriod 
                              ? 'Low Chances of Getting Pregnant': veryCloseToPeriod 
                                ? 'Low Chances of Getting Pregnant' : isCloseToOvulation 
                                  ? 'High Chances of Getting Pregnant': veryCloseToOvulation 
                                    ? 'High Chances of Getting Pregnant' : isOvulation 
                                      ? 'High Chances of Getting Pregnant' 
                                        : 'Low Chances of Getting Pregnant',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            if (buttonText.isNotEmpty)
                              ElevatedButton(
                                onPressed: () {
                                  //Logging Start of new period
                                  if (buttonText == 'Log Period') { 
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Log Period'),
                                          content: const Text('Are you sure you want to log your period?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Confirm'),
                                              onPressed: () {
                                                setState(() {
                                                   // Log the period start here
                                                  isInPeriod = true;
                                                  _currentDate = DateTime.now();
                                                  
                                                  final Cycle predictedCycle = predictCycle(
                                                  _periodStart = DateTime.now(),
                                                  _periodEnd = DateTime.now().add(const Duration(days: 7)),
                                                  );
                                                  cycles.add(predictedCycle);  

                                                  _ovulationDate = predictedCycle.ovulation;
                                                  _nextPeriodStart = predictedCycle.predictedPeriodStart;

                                                  // Debug print to check the state update
                                                  debugPrint("After User has logged Period");
                                                  debugPrint('Period Start after update: $_periodStart');
                                                  debugPrint('Period End after update: $_periodEnd');
                                                  debugPrint('Predicted Next Period Date after update: $_nextPeriodStart');
                                                  debugPrint('Current Date after update: $_currentDate');
                                                  debugPrint('Is In Period after update: $isInPeriod');
                                                  debugPrint("--------");
                                                }); 
                                                //printCycles(cycles);
                                                Navigator.of(context).pop();           
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    
                                  }
                                  //Logging end of new period
                                  else{
                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirming End of Period'),
                                          content: const Text('Are you sure you want to log the end of your period?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Confirm'),
                                              onPressed: () {
                                                setState(() {
                                                   // Log the period start here
                                                  isCloseToOvulation = true;
                                                  isInPeriod = false;
                                                  _currentDate = DateTime.now();
                                                  _periodEnd = _currentDate;
                                                  
                                                  //updating period end in my List for now
                                                  for (var cycle in cycles) {
                                                    if (cycle.periodStart == _periodStart) {
                                                      cycle.periodEnd = _periodEnd;
                                                    }
                                                  }

                                                  // Debug print to check the state update
                                                  debugPrint("After User has logged end of Period");
                                                  debugPrint('Period Start after update: $_periodStart');
                                                  debugPrint('Period End after update: $_periodEnd');
                                                  debugPrint('Predicted Next Period Date after update: $_nextPeriodStart');
                                                  debugPrint('Current Date after update: $_currentDate');
                                                  debugPrint('Is In Period after update: $isInPeriod');
                                                  debugPrint('Is Close to Ovulation after update: $isCloseToOvulation'); 
                                                  debugPrint("--------");
                                                }); 
                                                //printCycles(cycles);
                                                Navigator.of(context).pop();           
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Constants.periodPlanner,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                ),
                                child: Text(
                                  buttonText,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      "Please give your Daily Insights:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Constants.periodPlanner,
                      ),
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 150,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        autoPlay: false, 
                      ),
                      items: [
                        CarouselCard(
                          svgPath: "assets/images/symptoms.svg", 
                          title: "Symptoms",
                          destination: LoggerWidget(
                            heading: "Log Symptoms",
                            items: LogItems.getSymptoms(),
                            )
                        ),
                        CarouselCard(
                          svgPath: "assets/images/discharge1.svg", 
                          title: "Discharge",
                          destination: LoggerWidget(
                            heading: "Log Discharge", 
                            items: LogItems.getDischarge(),
                            )
                        ),
                        CarouselCard(
                          svgPath: "assets/images/moods1.svg", 
                          title: "Mood",
                          destination: LoggerWidget(
                            heading: "How are you feeling?", 
                            items: LogItems.getMoods(),
                            ),
                        ),    
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Generating Events from the Cycles List
  Map<DateTime, List<Event>> _generateEvents(List<Cycle> cycles) {
    Map<DateTime, List<Event>> events = {};

    for (Cycle cycle in cycles) {
      // Add period days
      for (DateTime date = cycle.periodStart;
          date.isBefore(cycle.periodEnd) || date.isAtSameMomentAs(cycle.periodEnd);
          date = date.add(const Duration(days: 1))) {
        events.update(date, (existingEvents) => existingEvents..add(Event('Period Day', Colors.pink)), ifAbsent: () => [Event('Period Day', Colors.pink)]);
      }

      // Add fertile window days
      for (DateTime date = cycle.fertileStart;
          date.isBefore(cycle.fertileEnd) || date.isAtSameMomentAs(cycle.fertileEnd);
          date = date.add(const Duration(days: 1))) {
        events.update(date, (existingEvents) => existingEvents..add(Event('Fertile Day', Colors.green)), ifAbsent: () => [Event('Fertile Day', Colors.green)]);
      }

      // Add ovulation day
      events.update(cycle.ovulation, (existingEvents) => existingEvents..add(Event('Ovulation Day', Colors.blue)), ifAbsent: () => [Event('Ovulation Day', Colors.blue)]);

      // Add predicted period start
      for (DateTime date = cycle.predictedPeriodStart;
          date.isBefore(cycle.predictedPeriodEnd) || date.isAtSameMomentAs(cycle.predictedPeriodEnd);
          date = date.add(const Duration(days: 1))) {
        events.update(date, (existingEvents) => existingEvents..add(Event('Predicted Period Day', Colors.orange)), ifAbsent: () => [Event('Predicted Period Day', Colors.orange)]);
      }
      //events.update(cycle.predictedPeriodStart, (existingEvents) => existingEvents..add(Event('Predicted Period Start', Colors.orange)), ifAbsent: () => [Event('Predicted Period Start', Colors.orange)]);
    }

    return events;
  }
}