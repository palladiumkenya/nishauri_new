import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/self_screening/bp/data/models/blood_pressure.dart';
import 'package:nishauri/src/features/self_screening/bp/data/providers/blood_pressure_provider.dart';
import 'package:nishauri/src/features/self_screening/bp/presentation/pages/BPLinelistScreen.dart';
import 'package:nishauri/src/features/self_screening/bp/presentation/pages/trend_chart_screen.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/shared/display/custome_filter_chart.dart';
import 'package:nishauri/src/shared/display/daily_card.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class BPMonitorScreen extends ConsumerStatefulWidget {
  @override
  _BPMonitorScreenState createState() => _BPMonitorScreenState();
}

class _BPMonitorScreenState extends ConsumerState<BPMonitorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  void _clearForm(double systolic, double diastolic, double heartRate, TextEditingController notesController) {
    setState(() {
      systolic = 120;
      diastolic = 80;
      heartRate = 70;
      notesController.clear();
    });
  }

  void _submitData(BuildContext context, double systolic, double diastolic, double heartRate, TextEditingController notesController) {
    final String notes = notesController.text;
    final DateTime measurementTime = DateTime.now();

    final bp = BloodPressure(
      systolic: systolic,
      diastolic: diastolic,
      pulse_rate: heartRate,
      created_at: measurementTime,
      notes: notes,
    );

    ref.read(bloodPressureRepositoryProvider).saveBloodPressure(bp).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value)),
      );
      _reloadData();
      _clearForm(systolic, diastolic, heartRate, notesController);
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    });
  }

  String _getWarningText(String label, double value) {
    if (label == 'Systolic') {
      if (value < 90) return 'Systolic pressure is too low';
      if (value > 140) return 'Systolic pressure is too high';
    } else if (label == 'Diastolic') {
      if (value < 60) return 'Diastolic pressure is too low';
      if (value > 90) return 'Diastolic pressure is too high';
    } else if (label == 'Heart Rate') {
      if (value < 60) return 'Heart rate is too low';
      if (value > 100) return 'Heart rate is too high';
    }
    return '';
  }

  Color _getSliderColor(String label, double value) {
    if (label == 'Systolic') {
      if (value < 90 || value > 140) return Colors.red;
    } else if (label == 'Diastolic') {
      if (value < 60 || value > 90) return Colors.orange;
    } else if (label == 'Heart Rate') {
      if (value < 60 || value > 100) return Colors.blue;
    }
    return Colors.green;
  }

  void _showDialogForm(BuildContext context) {
    double systolic = 120;
    double diastolic = 80;
    double heartRate = 70;
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Enter Blood Pressure Data'),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Systolic Pressure (mmHg): ${systolic.toInt()}',
                        style: TextStyle(color: _getSliderColor('Systolic', systolic)),
                      ),
                      Slider(
                        value: systolic,
                        min: 50,
                        max: 200,
                        divisions: 150,
                        label: systolic.toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            systolic = value;
                          });
                        },
                      ),
                      Text(_getWarningText('Systolic', systolic)),
                      Text(
                        'Diastolic Pressure (mmHg): ${diastolic.toInt()}',
                        style: TextStyle(color: _getSliderColor('Diastolic', diastolic)),
                      ),
                      Slider(
                        value: diastolic,
                        min: 30,
                        max: 120,
                        divisions: 90,
                        label: diastolic.toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            diastolic = value;
                          });
                        },
                      ),
                      Text(_getWarningText('Diastolic', diastolic)),
                      Text(
                        'Heart Rate (bpm): ${heartRate.toInt()}',
                        style: TextStyle(color: _getSliderColor('Heart Rate', heartRate)),
                      ),
                      Slider(
                        value: heartRate,
                        min: 40,
                        max: 180,
                        divisions: 140,
                        label: heartRate.toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            heartRate = value;
                          });
                        },
                      ),
                      Text(_getWarningText('Heart Rate', heartRate)),
                      TextFormField(
                        controller: notesController,
                        decoration: InputDecoration(
                          labelText: 'Notes',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _clearForm(systolic, diastolic, heartRate, notesController);
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _submitData(context, systolic, diastolic, heartRate, notesController);
                    _reloadData();
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _reloadData() {
    ref.refresh(bloodPressureListProvider);
  }

  @override
  Widget build(BuildContext context) {
    final bloodPressureListAsync = ref.watch(bloodPressureListProvider);
    final theme = Theme.of(context);
    return bloodPressureListAsync.when(
      data: (data) {

        final displayedData = data.length > 5 ? data.sublist(data.length - 5) : data;
        return Scaffold(
          body: Column(
            children: [
              const CustomAppBar(
                // title: "Blood Pressure",
                color: Constants.selfScreeningBgColor,
                height: 120,
                smallTitle: "Blood Pressure",
                rightBtTitle: "Add Data",
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Constants.SPACING),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              children: [
                                FilterCard(
                                  onPressed: (){

                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: Constants.SPACING,),
                            Text("18 Oct 2024", style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold)),

                            SizedBox(height: Constants.SPACING,),
                            Row(
                              children: [
                                Text("4.1", style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(width: 4),
                                Text("mmol/L", style: theme.textTheme.bodyMedium),
                              ],
                            ),
                            SizedBox(height: Constants.SPACING,),
                            Wrap(
                              spacing: 1,
                              runSpacing: 16,
                              children: [
                                TrendChartScreen(data: displayedData,)
                              ],
                            ),
                            SizedBox(height: Constants.SPACING,),
                            Card(
                              color: Constants.bgColor,
                              child: ListTile(
                                title: Text("Show All Data", style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                trailing: const Icon(Icons.arrow_forward_ios_outlined),
                                onTap: (){
                                  context.goNamed(RouteNames.BLOOD_PRESSURE_RECORDS, extra: data);
                                },
                              ),
                            ),
                            SizedBox(height: Constants.SPACING,),
                            Container(
                              color: Constants.bgColor,
                              height: 250,
                              child: Padding(
                                padding: const EdgeInsets.all(Constants.SPACING),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: Text(
                                          'What is Blood Pressure',
                                          style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        subtitle: Text(
                                          "Blood pressure is the force of your blood pushing against the walls of your arteries as your heart pumps it around your body. It’s measured with two numbers: the first (systolic) is the pressure when your heart beats, and the second (diastolic) is the pressure when your heart rests between beats. For most people, a normal reading is around 120/80. Keeping your blood pressure in a healthy range is important because high or low blood pressure can lead to health problems. Regular checks can help you stay on top of it.",
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Constants.SPACING),
                            Button(
                              title: "More Insight",
                              onPress: (){
                                context.goNamed(RouteNames.BLOOD_PRESSURE_INSIGHT);
                              },
                              textColor: Constants.selfScreeningBgColor,
                              // onPressed: () {
                              //   // implement on Pressed
                              // },
                              // child: Text('More Insight', style: theme.textTheme.bodyLarge!.copyWith(color: Constants.selfScreeningBgColor)),
                              // style: TextButton.styleFrom(
                              //   backgroundColor: Constants.bgColor,
                              //   padding: EdgeInsets.all(10),
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(8), // Rounded corners
                              //   ),
                              // ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: _reloadData,
                child: Icon(Icons.refresh),
                heroTag: null,
              ),
              SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () {
                  _showDialogForm(context);
                  _reloadData();
                  },
                child: Icon(Icons.add),
                heroTag: null,
              ),
            ],
          ),
        );
      },
      error: (error, _) => BackgroundImageWidget(
        customAppBar: const CustomAppBar(
          title: "Blood Pressure Monitor 📈",
          color: Constants.bmiCalculatorColor,
        ),
        svgImage: 'assets/images/lab-empty-state.svg',
        notFoundText: "No BP Data Available to display",
        floatingButtonIcon1: Icons.refresh,
        floatingButtonAction1: () {
          _reloadData();
        },
        floatingButtonIcon2: Icons.add,
        floatingButtonAction2: () {
          _showDialogForm(context);
          _reloadData();
        },
      ),
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading Blood Pressure",
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: Constants.SPACING * 2),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
