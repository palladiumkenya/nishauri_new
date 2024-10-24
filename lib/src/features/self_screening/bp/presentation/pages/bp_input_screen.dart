import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/self_screening/bp/data/models/blood_pressure.dart';
import 'package:nishauri/src/features/self_screening/bp/data/providers/blood_pressure_provider.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

class BloodPressureInputs extends ConsumerStatefulWidget {
  @override
  _BloodPressureInputsState createState() => _BloodPressureInputsState();
}

class _BloodPressureInputsState extends ConsumerState<BloodPressureInputs> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _systolicController = TextEditingController(text: '120');
  final TextEditingController _diastolicController = TextEditingController(text: '80');

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dateController.text = DateFormat('dd MMM yyyy').format(now);
    _timeController.text = "${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}";
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = '${picked.hour}:${picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  void _reloadData() {
    ref.refresh(bloodPressureListProvider);
  }

  void _submitData(double systolic, double diastolic, double? pulseRate){
    final String notes = _notesController.text;
    final DateTime measurementTime = DateTime.now();
    final bp = BloodPressure(
      systolic: systolic,
      diastolic: diastolic,
      pulse_rate: pulseRate!,
      created_at: measurementTime,
      notes: notes,
    );

    ref.read(bloodPressureRepositoryProvider).saveBloodPressure(bp).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value)),
      );
      _reloadData();
      // _clearForm(systolic, diastolic, heartRate, notesController);
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    });
  }

  void _saveData() {
    final systolic = double.parse(_systolicController.text);
    final diastolic = double.parse(_diastolicController.text);
    final pulseRate = double.parse(_diastolicController.text);
    _submitData(systolic, diastolic, pulseRate);
    if (systolic != null && diastolic != null && systolic > 0 && diastolic > 0) {
      if (systolic > 140 || diastolic > 90) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Warning: High blood pressure detected!'),
            backgroundColor: Colors.red,
          ),
        );
      }
      else if (systolic < 90 || diastolic < 60){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Warning: Low blood pressure detected!'),
            backgroundColor: Colors.red,
          ),
      );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved: $systolic/$diastolic on ${_dateController.text} at ${_timeController.text}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid blood pressure readings.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            color: Constants.selfScreeningBgColor,
            height: 120,
            smallTitle: "Blood Pressure Input",
            rightBtTitle: "Add Data",
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            // main container
            child: Container(
              padding: const EdgeInsets.all(Constants.SPACING),
              decoration: BoxDecoration(
                color: Constants.bgColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Constants.bgColor),
              ),
              child: Column(
                children: [
                  const SizedBox(height: Constants.SPACING),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date:", style:  theme.textTheme.bodyLarge,),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Constants.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Constants.bgColor),
                            ),
                            padding: const EdgeInsets.all(Constants.SPACING),
                            width: 150,
                            height: 40,
                            child: TextField(
                              controller: _dateController,
                              decoration: null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.SPACING),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Time:", style:  theme.textTheme.bodyLarge),
                      GestureDetector(
                        onTap: () => _selectTime(context),
                        child: AbsorbPointer(
                          child: Container(
                            padding: const EdgeInsets.all(Constants.SPACING),
                            decoration: BoxDecoration(
                              color: Constants.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Constants.bgColor),
                            ),
                            width: 150,
                            height: 40,
                            child: TextField(
                              controller: _timeController,
                              decoration: null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.SPACING),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Systolic:", style:  theme.textTheme.bodyLarge),
                      Container(
                        padding: const EdgeInsets.all(Constants.SPACING),
                        decoration: BoxDecoration(
                          color: Constants.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Constants.bgColor),
                        ),
                        width: 150,
                        height: 40,
                        child: TextField(
                          controller: _systolicController,
                          keyboardType: TextInputType.number,
                          decoration: null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.SPACING),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Diastolic", style: theme.textTheme.bodyLarge,),
                      Container(
                        padding: const EdgeInsets.all(Constants.SPACING),
                        decoration: BoxDecoration(
                          color: Constants.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Constants.bgColor),
                        ),
                        width: 150,
                        height: 40,
                        child: TextField(

                          controller: _diastolicController,
                          keyboardType: TextInputType.number,
                          decoration: null,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: Constants.SPACING),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Container(
                        padding: const EdgeInsets.all(Constants.SPACING),
                        decoration: BoxDecoration(
                          color: Constants.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Constants.bgColor),
                        ),
                        width: MediaQuery.of(context).size.width *0.9,
                        child: TextFormField(
                          style: theme.textTheme.bodyMedium!.copyWith(decoration: null),
                          controller: _notesController,
                          decoration: InputDecoration(
                            labelText: "Notes",
                            border: const OutlineInputBorder(
                              gapPadding: 5,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Constants.bgColor),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Constants.bgColor),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Constants.bgColor),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            labelStyle: TextStyle(color: Constants.selfScreeningBgColor),
                          ),
                          keyboardType: TextInputType.text,
                          maxLines: null,
                        ),

                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.SPACING),
                  const Divider(),
                  ElevatedButton(
                    onPressed: _saveData,
                    child: Text('Save Data', style: TextStyle(color: Constants.selfScreeningBgColor),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
