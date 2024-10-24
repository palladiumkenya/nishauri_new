import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/data/models/blood_sugar.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/data/providers/blood_sugar_provider.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

class BloodSugarInputs extends ConsumerStatefulWidget {
  const BloodSugarInputs({super.key});

  @override
  _BloodSugarInputsState createState() => _BloodSugarInputsState();
}

class _BloodSugarInputsState extends ConsumerState<BloodSugarInputs> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _bloodGlucoseController = TextEditingController(text: "100");
  final TextEditingController _conditionController = TextEditingController();

  final List<String> _dropdownOptions = [
    'Fasting (before meals)',
    'Postprandial (after meals)'
  ];
  String _selectedCondition = "Fasting (before meals)";

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dateController.text = DateFormat('dd MMM yyyy').format(now);
    _timeController.text = "${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}";
    _conditionController.text = _selectedCondition;
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
    ref.refresh(bloodSugarProvider);
  }

  void _submitData(double level){
    final String notes = _notesController.text;
    final condition = _conditionController.text;
    final DateTime measurementTime = DateTime.now();
    final bs = BloodSugar(
      level: level,
      condition: condition??'',
      created_at: measurementTime,
      notes: notes,
    );

    ref.read(bloodSugarProvider).saveBloodSugar(bs).then((value) {
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
    final level = double.tryParse(_bloodGlucoseController.text);
    final condition = _conditionController.text;

    if (level != null && level > 0) {
      _submitData(level);

      bool isHigh = false;
      bool isLow = false;

      if (condition == "Fasting (before meals)") {
        if (level > 100) {
          isHigh = true;
        } else if (level < 70) {
          isLow = true;
        }
      } else if (condition == "Postprandial (after meals)") {
        if (level > 140) {
          isHigh = true;
        } else if (level < 90) {
          isLow = true;
        }
      }
      if (isHigh) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Warning: High blood sugar detected!'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (isLow) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Warning: Low blood sugar detected!'),
            backgroundColor: Colors.red,
          ),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data saved: $level mg/dL with condition ${_conditionController.text} on ${_dateController.text} at ${_timeController.text}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid blood sugar readings.')),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width *0.9,
                        decoration: BoxDecoration(
                          color: Constants.white,
                          borderRadius: BorderRadius.circular(1),
                          border: Border.all(color: Constants.bgColor),
                        ),
                        child: Text("mg/dL", style: theme.textTheme.bodyLarge,),
                      ),
                    ],
                  ),
                  const Divider(),
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
                            width: 270,
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
                            width: 270,
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
                      Text("Blood Sugar Level", style:  theme.textTheme.bodyLarge),
                      Container(
                        padding: const EdgeInsets.all(Constants.SPACING),
                        decoration: BoxDecoration(
                          color: Constants.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Constants.bgColor),
                        ),
                        width: 270,
                        height: 40,
                        child: TextField(
                          controller: _bloodGlucoseController,
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
                      Text("Meal Time", style: theme.textTheme.bodyLarge,),
                      Container(
                        padding: const EdgeInsets.all(Constants.SPACING),
                        decoration: BoxDecoration(
                          color: Constants.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Constants.bgColor),
                        ),
                        width: 270,
                        height: 60,
                        child: TextField(
                          controller: _conditionController,
                          readOnly: true,
                          style: theme.textTheme.bodyMedium!.copyWith(decoration: null),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              gapPadding: 4,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Constants.white),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Constants.white),
                              // borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Constants.white),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            suffixIcon: PopupMenuButton<String>(
                              icon: const Icon(Icons.arrow_drop_down),
                              onSelected: (String value) {
                                _conditionController.text = value;
                                setState(() {
                                  _selectedCondition = value;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return _dropdownOptions.map<PopupMenuItem<String>>((String value) {
                                  return PopupMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList();
                              },
                            ),
                            // FormBuilderDropdown(
                          ),
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
                          decoration: const InputDecoration(
                            labelText: "Notes (optional)",
                            border: OutlineInputBorder(
                              gapPadding: 5,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Constants.bgColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Constants.bgColor),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            focusedBorder: OutlineInputBorder(
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
                    child: const Text('Save Data', style: TextStyle(color: Constants.selfScreeningBgColor),),
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
