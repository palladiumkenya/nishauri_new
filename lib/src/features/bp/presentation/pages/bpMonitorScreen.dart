import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/bp/data/models/blood_pressure.dart';
import 'package:nishauri/src/features/bp/data/providers/blood_pressure_provider.dart';
import 'package:nishauri/src/features/bp/presentation/pages/BPLinelistScreen.dart';
import 'package:nishauri/src/features/bp/presentation/pages/trend_chart_screen.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

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
      date_time: measurementTime,
      notes:notes,
    );

    ref.read(bloodPressureRepositoryProvider).saveBloodPressure(bp).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value)),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Blood Pressure Monitor 📈",
            // icon: Icons.trending_up,
            color: Constants.bpShortCutBgColor,
          ),
          Expanded(
            child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TrendChartScreen(),
                        ),
                        Expanded(
                          flex: 1,
                          child: BPLinelistScreen(),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialogForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}