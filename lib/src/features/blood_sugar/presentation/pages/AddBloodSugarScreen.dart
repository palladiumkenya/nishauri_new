import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/blood_sugar/data/models/blood_sugar.dart';
import 'package:nishauri/src/features/blood_sugar/data/providers/blood_sugar_provider.dart';
import 'package:nishauri/src/features/blood_sugar/presentation/widgets/blood_level_picker.dart';
import 'package:nishauri/src/features/blood_sugar/presentation/widgets/blood_level_units_picker.dart';
import 'package:nishauri/src/utils/constants.dart';

class AddBloodSugarScreen extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  AddBloodSugarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloodLevel = useState<double>(70.0);
    final bloodLevelUnits = useState<LevelPickerUnits>(LevelPickerUnits.mgdl);
    final note = TextEditingController();
    final condition = useState<String>('Fasting');
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BloodLevelPicker(
            bloodLevelUnits: bloodLevelUnits.value,
            onLevelUnitsChange: (units) {
              bloodLevelUnits.value = units;
            },
            bloodLevel: bloodLevel.value,
            onLevelChange: (level) {
              bloodLevel.value = level;
              debugPrint("Blood level on add: $level");
            },
            activeColor: Constants.bloodSugarColor,
          ),
          const SizedBox(height: 20),
          // Drop down menu to select blood level condition
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Condition',
              hintText: 'Select a condition',
            ),
            items:
                <String>['Fasting (before meals)', 'Postprandial (after meals)']
                    .map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
            onChanged: (String? value) {
              condition.value = value!;
              debugPrint("Selected value: $value");
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a condition';
              }
              return null;
            },
          ),
          // Field to take note of user
          TextFormField(
            controller: note,
            decoration: const InputDecoration(
              labelText: 'Note',
              hintText: 'Enter a note',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final entry = BloodSugar(
                  level: bloodLevel.value,
                  date: DateTime.now(),
                  notes: note.text,
                  condition: condition.value,
                );
                debugPrint("Adding entry: $entry");
                ref
                    .read(bloodSugarProvider)
                    .saveBloodSugar(entry)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Blood sugar entry added successfully'),
                    ),
                  );
                  Navigator.of(context).pop();
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to add blood sugar entry: $error'),
                    ),
                  );
                });
              }
            },
            child: const Text('Add Entry'),
          ),
        ],
      ),
    );
  }
}
