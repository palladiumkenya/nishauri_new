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
import 'package:nishauri/src/features/period_planner/utils/event_utils.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:table_calendar/table_calendar.dart';


//Function to check if two dates are on the same day by truncating the time part
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
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
  late DateTime _nextPeriodEnd;
  Map<String, Map<DateTime, List<Event>>> events = {};

  
 
  @override
  void initState() {
    super.initState();

    //events = _generateEvents(cycles);
    if (cycles.isNotEmpty) {
      Cycle latestCycle = cycles.last;
      _periodStart = latestCycle.periodStart;
      _periodEnd = latestCycle.periodEnd;
      _ovulationDate = latestCycle.ovulation;
      _nextPeriodStart = latestCycle.predictedPeriodStart;  
      _nextPeriodEnd = latestCycle.predictedPeriodEnd;    
    }
    events = EventUtils.generateEvents(cycles); 
    //_updateEvents();
  }

  void _updateEvents() {
    setState(() {
      events = EventUtils.generateEvents(cycles);
      // print("Updated Events: $events");
      // print("Updated Events");
      // events.forEach((cycleId, dateMap) {
      //   dateMap.forEach((date, events) { 
      //     print("Cycle ID $cycleId ,Date: $date, Events: $events");
      //   });
      // });
      //print("Updated Events: $events"); 
      //print("-------------"); 
    });
  }



  


  @override
  Widget build(BuildContext context) {
    //late bool endOfPeriod; // handling when user has logged end of period
    //handling the days before, after or during the various phases in the Menstrual Cycle
    int daysToOvulation = _ovulationDate.difference(_currentDate).inDays;
    int daysToNextPeriod = _nextPeriodStart.difference(_currentDate).inDays;
    int overdueDays = _currentDate.difference(_nextPeriodEnd).inDays;
    //int predictedDays = _nextPeriodEnd.difference(_nextPeriodStart).inDays;

    bool isInPeriod = (isSameDay(_currentDate, _periodStart) || _currentDate.isAfter(_periodStart)) && _currentDate.isBefore(_periodEnd);
    bool veryCloseToPeriod = _currentDate.isBefore(_nextPeriodStart) && daysToNextPeriod == 0;
    bool isCloseToOvulation = _currentDate.isBefore(_ovulationDate) && !isInPeriod && daysToOvulation>=1 ;
    bool veryCloseToOvulation = _currentDate.isBefore(_ovulationDate) && daysToOvulation == 0;
    bool isOvulation = (isSameDay(_currentDate, _ovulationDate)) || (_currentDate.isAfter(_ovulationDate) && daysToOvulation == 0);
    //two days after ovulation -- I'm thinking about it though
    bool afterOvulation = _currentDate.isAfter(_ovulationDate) && (_currentDate.isBefore(_nextPeriodStart) && daysToNextPeriod>0);
    bool duringPredictedPeriodRange = _currentDate.isAfter(_nextPeriodStart) &&
                                      _currentDate.isBefore(_nextPeriodEnd) ||
                                      isSameDay(_currentDate, _nextPeriodStart) ||
                                      isSameDay(_currentDate, _nextPeriodEnd);
    bool isDangerZone = _currentDate.isAfter(_nextPeriodEnd);  
    



    // Determine progress value and messages based on the current date
    double progressValue = 0.0;
    String message = '';
    String buttonText = '';
    String title = '';
    String chances = '';


    if (isInPeriod) {
      progressValue = 0.2;
      title = 'Period';
      message = 'Day ${DateTime.now().difference(_periodStart).inDays + 1}';
      buttonText = 'Log End Period';
      chances = 'Low Chances of Getting Pregnant';
    } else if (isCloseToOvulation) {
      progressValue = 0.3;
      title = 'Ovulation in';
      message = '$daysToOvulation days';
      buttonText = '';
      chances = 'High Chances of Getting Pregnant';
    } else if (veryCloseToOvulation) {
      progressValue = 0.4;
      title = 'Ovulation is';
      message = 'Tomorrow';
      buttonText = '';
      chances = 'High Chances of Getting Pregnant';
    } else if (isOvulation) {
      progressValue = 0.5;
      title = 'Ovulation is';
      message = 'Today';
      buttonText = '';
      chances = 'High Chances of Getting Pregnant';
    } else if (afterOvulation) {
      progressValue = 0.7;
      title = 'Next Period in'; 
      message = '$daysToNextPeriod days';
      buttonText = 'Log Period';
      chances = 'High Chances of Getting Pregnant';
    } else if (veryCloseToPeriod) {
      progressValue = 0.7; 
      title = 'Next Period is';
      message = 'Tomorrow';
      buttonText = 'Log Period';
      chances = 'Low Chances of Getting Pregnant';
    } else if (duringPredictedPeriodRange) {
      progressValue = 1.0;
      title = 'Periods May happen';
      message = 'Today';
      buttonText = 'Log Period';
      chances = 'Low Chances of Getting Pregnant';
    } else if(isDangerZone) {
      progressValue = 1.0;
      title = 'Periods Overdue by';
      message = '$overdueDays Day${overdueDays > 1 ? 's': ''}';
      buttonText = 'Log Period';
      chances = 'High Chances of Getting Pregnant';
    } 
    // else {
    //   progressValue = 1.0;
    //   message = 'Cycle Complete';
    //   buttonText = '';
    // }

    //Debug prints to trace the logic
    // debugPrint('Current Date: $_currentDate');
    // debugPrint('Period Start: $_periodStart');
    // debugPrint('Period End: $_periodEnd');
    // debugPrint('Is In Period: $isInPeriod');
    // debugPrint('-----Widget Rebuild-----');
    // debugPrint('Is In Period: $isInPeriod');
    // debugPrint('Is close to Ovulation: $isCloseToOvulation');

    

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
                    SizedBox(
                      height: 150,
                      child: CustomCalendar(
                        key: ValueKey(events),
                        initialFormat: CalendarFormat.week, 
                        events: events,
                        ),
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isDangerZone ? Colors.red : Constants.periodPlanner,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 20, 
                                fontWeight: FontWeight.bold,
                                ),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            Text(
                              message,
                              style: TextStyle(fontSize: 38, color: isDangerZone ? Colors.red: Constants.periodPlanner, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            Text(
                              chances,
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
                                                // setState(() {
                                                //    // Log the period start here
                                                //   isInPeriod = true;
                                                //   isDangerZone = false;
                                                //   _currentDate = DateTime.now();
                                                  
                                                //   final Cycle predictedCycle = predictCycle(
                                                //   _periodStart = DateTime.now(),
                                                //   _periodEnd = DateTime.now().add(const Duration(days: 6)),
                                                //   );
                                                //   cycles.add(predictedCycle);  

                                                //   _ovulationDate = predictedCycle.ovulation;
                                                //   _nextPeriodStart = predictedCycle.predictedPeriodStart;
                                                //   _updateEvents();

                                                //   // Debug print to check the state update
                                                //   debugPrint("After User has logged Period");
                                                //   debugPrint('Period Start after update: $_periodStart');
                                                //   debugPrint('Period End after update: $_periodEnd');
                                                //   debugPrint('Predicted Next Period Date after update: $_nextPeriodStart');
                                                //   debugPrint('Current Date after update: $_currentDate');
                                                //   debugPrint('Is In Period after update: $isInPeriod');
                                                //   debugPrint("--------");
                                                // }); 
                                                printCycles(cycles);
                                                context.goNamed(RouteNames.PERIOD_PLANNER_EDIT_PERIOD_CALENDAR);           
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

                                                  _updateEvents();

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
                                  backgroundColor: isDangerZone ? Colors.red: Constants.periodPlanner,
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
} 