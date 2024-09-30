import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/data/providers/cycles_provider.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/logPeriods.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/periods_history.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/carouselCard.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/logItems.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/loggerWidget.dart';
import 'package:nishauri/src/features/period_planner/utils/event_utils.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

//Function to check if two dates are on the same day by truncating the time part
bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

class PeriodPlannerScreen extends ConsumerStatefulWidget {
  const PeriodPlannerScreen({super.key});

  @override
  ConsumerState<PeriodPlannerScreen> createState() =>
      _PeriodPlannerScreenState();
}

class _PeriodPlannerScreenState extends ConsumerState<PeriodPlannerScreen> {
  DateTime _currentDate = DateTime.now();
  DateTime? _periodStart;
  DateTime? _periodEnd;
  DateTime? _ovulationDate;
  DateTime? _nextPeriodStart;
  DateTime? _nextPeriodEnd;
  Map<int, Map<DateTime, List<Event>>> events = {};

  @override
  void initState() {
    super.initState();
    _checkOverdueDialog();
  }

  Future<void> _checkOverdueDialog() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastDialogDateStr = prefs.getString('lastDialogDate');
    DateTime? lastDialogDate =
        lastDialogDateStr != null ? DateTime.parse(lastDialogDateStr) : null;

    if (lastDialogDate == null || !isSameDay(_currentDate, lastDialogDate)) {
      //If the dialog hasn't been shown today and the user's periods are overdue
      if (_nextPeriodEnd != null && _currentDate.isAfter(_nextPeriodEnd!)) {
        _overdueDialog();
        //storing the current date as the last dialog shown date
        prefs.setString('lastDialogDate', _currentDate.toIso8601String());
      }
    }
  }

  void _overdueDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Periods Overdue"),
          content: const Text(
              "We have noticed that your periods are currently overdue, we would just like you to confirm whether your periods have started"),
          actions: [
            TextButton(
              onPressed: () {
                context.goNamed(RouteNames.PERIOD_PLANNER_LOG_PERIODS);
              },
              child: const Text("Yes, they have"),
            ),
            TextButton(
              onPressed: () {
                _pregnancyDialogue();
              },
              child: const Text("No, they haven't"),
            ),
          ],
        );
      },
    );
  }

  void _pregnancyDialogue() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        String? dropdownValue;
        String? pregnancyDropDownValue;

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text("Periods Overdue"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Have you taken a pregnancy test?"),
                  const SizedBox(
                    height: 8,
                  ),
                  DropdownButtonFormField(
                    value: dropdownValue,
                    items: const [
                      DropdownMenuItem(
                        value: "Yes",
                        child: Text("Yes"),
                      ),
                      DropdownMenuItem(
                        value: "No",
                        child: Text("No"),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please Select an Option' : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: "Select an Option",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (dropdownValue == "Yes")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("If Yes: Are you pregnant?"),
                        const SizedBox(
                          height: 8,
                        ),
                        DropdownButtonFormField(
                          value: pregnancyDropDownValue,
                          items: const [
                            DropdownMenuItem(
                              value: "Yes",
                              child: Text("Yes"),
                            ),
                            DropdownMenuItem(
                              value: "No",
                              child: Text("No"),
                            )
                          ],
                          onChanged: (String? value) {
                            setState(() {
                              pregnancyDropDownValue = value;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Please select an option' : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: 'Select an option',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  if (dropdownValue == "No")
                    const Text("It is recommended you take a pregnancy test."),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cycleState = ref.watch(cyclesProvider);
    final theme = Theme.of(context);

    //Debug prints to trace the logic
    // debugPrint('Current Date: $_currentDate');
    // debugPrint('Period Start: $_periodStart');
    // debugPrint('Period End: $_periodEnd');
    // debugPrint('Is In Period: $isInPeriod');
    // debugPrint('-----Widget Rebuild-----');
    // debugPrint('Is In Period: $isInPeriod');
    // debugPrint('Is close to Ovulation: $isCloseToOvulation');
    return Scaffold(
      body: cycleState.when(
        data: (cycles) {
          bool isNewUser = cycles.isEmpty;
          if (!isNewUser) {
            Cycle latestCycle = cycles.values.last;
            _periodStart = latestCycle.period_start;
            _periodEnd = latestCycle.period_end;
            _ovulationDate = latestCycle.ovulation;
            _nextPeriodStart = latestCycle.predicted_period_start;
            _nextPeriodEnd = latestCycle.predicted_period_end;
            events = EventUtils.generateEvents(cycles);
          }
          // If cycles are updated, recalculate the events and UI elements
          int daysToOvulation = _ovulationDate != null
              ? _ovulationDate!.difference(_currentDate).inDays
              : 0;
          int daysToNextPeriod = _nextPeriodStart != null
              ? _nextPeriodStart!.difference(_currentDate).inDays
              : 0;
          int overdueDays = _nextPeriodEnd != null
              ? _currentDate.difference(_nextPeriodEnd!).inDays
              : 0;
          //int predictedDays = _nextPeriodEnd.difference(_nextPeriodStart).inDays;

          bool isInPeriod = (_periodStart != null &&
                  (_currentDate.isAfter(_periodStart!) ||
                      isSameDay(_currentDate, _periodStart!))) &&
              (_periodEnd != null && _currentDate.isBefore(_periodEnd!));

          bool veryCloseToPeriod = _nextPeriodStart != null &&
              _currentDate.isBefore(_nextPeriodStart!) &&
              daysToNextPeriod == 0;
          bool isCloseToOvulation = _ovulationDate != null &&
              _currentDate.isBefore(_ovulationDate!) &&
              !isInPeriod &&
              daysToOvulation >= 1;
          bool veryCloseToOvulation = _ovulationDate != null &&
              _currentDate.isBefore(_ovulationDate!) &&
              daysToOvulation == 0;
          bool isOvulation = _ovulationDate != null &&
                  (isSameDay(_currentDate, _ovulationDate!)) ||
              (_currentDate.isAfter(_ovulationDate!) && daysToOvulation == 0);
          bool afterOvulation =
              (_ovulationDate != null && _nextPeriodStart != null) &&
                  _currentDate.isAfter(_ovulationDate!) &&
                  (_currentDate.isBefore(_nextPeriodStart!) &&
                      daysToNextPeriod > 0);
          bool duringPredictedPeriodRange =
              (_nextPeriodStart != null && _nextPeriodEnd != null) &&
                      (_currentDate.isAfter(_nextPeriodStart!) &&
                          _currentDate.isBefore(_nextPeriodEnd!)) ||
                  (isSameDay(_currentDate, _nextPeriodStart!) ||
                      isSameDay(_currentDate, _nextPeriodEnd!));
          bool isDangerZone = _currentDate.isAfter(_nextPeriodEnd!);

          bool inPeriods = isInPeriod;

          // Determine progress value and messages based on the current date
          double progressValue = 0.0;
          String message = '';
          String buttonText = '';
          String title = '';
          String chances = '';

          if (isInPeriod) {
            progressValue = 0.2;
            title = 'Period';
            message =
                'Day ${DateTime.now().difference(_periodStart!).inDays + 1}';
            buttonText = 'Period End';
            chances = 'Low';
          } else if (isCloseToOvulation) {
            progressValue = 0.3;
            title = 'Ovulation in';
            message = '$daysToOvulation day${daysToOvulation > 1 ? 's' : ''}';
            buttonText = 'Period Start';
            chances = 'High';
          } else if (veryCloseToOvulation) {
            progressValue = 0.4;
            title = 'Ovulation is';
            message = 'Tomorrow';
            buttonText = 'Period Start';
            chances = 'High';
          } else if (isOvulation) {
            progressValue = 0.5;
            title = 'Ovulation is';
            message = 'Today';
            buttonText = 'Period Start';
            chances = 'High';
          } else if (afterOvulation) {
            progressValue = 0.7;
            title = 'Next Period in';
            message = '$daysToNextPeriod day${daysToNextPeriod > 1 ? 's' : ''}';
            buttonText = 'Period Start';
            chances = 'Low';
          } else if (veryCloseToPeriod) {
            progressValue = 0.7;
            title = 'Next Period is';
            message = 'Tomorrow';
            buttonText = 'Period Start';
            chances = 'Low';
          } else if (duringPredictedPeriodRange) {
            progressValue = 1.0;
            title = 'Periods May happen';
            message = 'Today';
            buttonText = 'Period Start';
            chances = 'Low';
          } else if (isDangerZone) {
            progressValue = 1.0;
            title = 'Periods Overdue by';
            message = '$overdueDays Day${overdueDays > 1 ? 's' : ''}';
            buttonText = 'Period Start';
            chances = 'High';
          } else if (isNewUser) {
            progressValue = 1.0;
            title = "Welcome";
            message = "Let's kickstart your predictions.";
            buttonText = 'Get Started';
            chances = "";
          }
          return Column(
            children: [
              const CustomAppBar(
                title: "My Flow Tracker 🌺",
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
                        Card(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              if (!isNewUser)
                                const Text(
                                  "Your Chances of Getting Pregnant are:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
                                ),
                              Text(
                                chances,
                                style: TextStyle(
                                  fontSize: 34,
                                  color: chances == 'High'
                                      ? Colors.red
                                      : Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(height: Constants.SPACING),
                        SizedBox(
                          height: 150,
                          child: CustomCalendar(
                            key: ValueKey(events),
                            initialFormat: CalendarFormat.week,
                            events: events,
                            headerButton: true,
                            inPeriods: inPeriods,
                          ),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 300, // Adjust the width as needed
                              height: 300, // Adjust the height as needed
                              child: CircularProgressIndicator(
                                value: progressValue,
                                strokeWidth: 20,
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  isDangerZone
                                      ? Colors.red
                                      : Constants.periodPlanner,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isDangerZone)
                                  const SizedBox(
                                      height: Constants.SPACING + 20),
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
                                  style: TextStyle(
                                      fontSize: 38,
                                      color: isDangerZone
                                          ? Colors.red
                                          : Constants.periodPlanner,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: Constants.SPACING + 10),
                                if (buttonText.isNotEmpty)
                                  ElevatedButton(
                                    onPressed: () {
                                      //Logging Start of new period
                                      if (buttonText == 'Period Start' ||
                                          buttonText == 'Get Started') {
                                        ref
                                            .read(cyclesProvider.notifier)
                                            .fetchCycles()
                                            .then((_) {
                                          context.goNamed(RouteNames
                                              .PERIOD_PLANNER_LOG_PERIODS);
                                        });
                                      }
                                      //Logging end of new period
                                      else {
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Confirming End of Period'),
                                              content: const Text(
                                                  'Are you sure you want to log the end of your period?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Confirm'),
                                                  onPressed: () {
                                                    setState(() {
                                                      // Log the period start here
                                                      isCloseToOvulation = true;
                                                      isInPeriod = false;
                                                      _currentDate =
                                                          DateTime.now();
                                                      _periodEnd = _currentDate;
                                                    });
                                                    //printCycles(cycles);
                                                    // Debug print to check the state update
                                                    // debugPrint("After User has logged end of Period");
                                                    // debugPrint('Period Start after update: $_periodStart');
                                                    // debugPrint('Period End after update: $_periodEnd');
                                                    // debugPrint('Predicted Next Period Date after update: $_nextPeriodStart');
                                                    // debugPrint('Current Date after update: $_currentDate');
                                                    // debugPrint('Is In Period after update: $isInPeriod');
                                                    // debugPrint('Is Close to Ovulation after update: $isCloseToOvulation');
                                                    // debugPrint("--------");
                                                    final cycleId =
                                                        cycles.keys.last;

                                                    final updatedCycle =
                                                        predictCycle(
                                                      _periodStart!,
                                                      _periodEnd!,
                                                      cycleId: cycleId,
                                                      cycle: cycles,
                                                    );
                                                    periodConfirmedMap[
                                                        cycleId] = true;

                                                    updateCycleLengths(cycles);

                                                    final sortedCycleKeys = cycles
                                                        .keys
                                                        .toList()
                                                      ..sort((a, b) => cycles[
                                                              a]!
                                                          .period_start
                                                          .compareTo(cycles[b]!
                                                              .period_start));

                                                    final secondLastCycleId =
                                                        sortedCycleKeys[
                                                            sortedCycleKeys
                                                                    .length -
                                                                2];

                                                    // final secondLastCycle =
                                                    //     cycles[
                                                    //         secondLastCycleId]!;

                                                    final secondLastPeriodStart =
                                                        cycles[secondLastCycleId]!
                                                            .period_start;
                                                    final secondLastPeriodEnd =
                                                        cycles[secondLastCycleId]!
                                                            .period_end;

                                                    final updateSecondLastCycle =
                                                        predictCycle(
                                                      secondLastPeriodStart,
                                                      secondLastPeriodEnd,
                                                      cycleId:
                                                          secondLastCycleId,
                                                      cycle: cycles,
                                                    );

                                                    ref
                                                        .read(cyclesProvider
                                                            .notifier)
                                                        .editCycle(cycleId,
                                                            updatedCycle)
                                                        .then((_) {
                                                      // Navigator.of(context)
                                                      //     .pop();
                                                      ref
                                                          .read(cyclesProvider
                                                              .notifier)
                                                          .editCycle(
                                                              secondLastCycleId,
                                                              updateSecondLastCycle)
                                                          .then((_) {
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    });
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
                                      backgroundColor: isDangerZone
                                          ? Colors.red
                                          : Constants.periodPlanner,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                    ),
                                    child: Text(
                                      buttonText,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                const SizedBox(height: 10),
                                //where to put the icon button
                                if (isDangerZone)
                                  IconButton(
                                    onPressed: () {
                                      _overdueDialog();
                                    },
                                    icon: const Icon(
                                      Icons.info_sharp,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        //const SizedBox(height: 20,),
                        // const Text(
                        //   "Please give your Daily Insights:",
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 15.0,
                        //     color: Constants.periodPlanner,
                        //   ),
                        // ),
                        // CarouselSlider(
                        //   options: CarouselOptions(
                        //     height: 150,
                        //     enlargeCenterPage: true,
                        //     enableInfiniteScroll: false,
                        //     initialPage: 0,
                        //     autoPlay: false,
                        //   ),
                        //   items: [
                        //     CarouselCard(
                        //       svgPath: "assets/images/symptoms.svg",
                        //       title: "Symptoms",
                        //       destination: LoggerWidget(
                        //         heading: "Log Symptoms",
                        //         items: LogItems.getSymptoms(),
                        //         )
                        //     ),
                        //     CarouselCard(
                        //       svgPath: "assets/images/discharge1.svg",
                        //       title: "Discharge",
                        //       destination: LoggerWidget(
                        //         heading: "Log Discharge",
                        //         items: LogItems.getDischarge(),
                        //         )
                        //     ),
                        //     CarouselCard(
                        //       svgPath: "assets/images/moods1.svg",
                        //       title: "Mood",
                        //       destination: LoggerWidget(
                        //         heading: "How are you feeling?",
                        //         items: LogItems.getMoods(),
                        //         ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.periodPlanner,
                    ),
                    onPressed: () {
                      context.goNamed(RouteNames.PERIOD_PLANNER_PERIOD_HISTORY);
                    },
                    child: Text(
                      'Periods History',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(
            'Failed to load cycles: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
