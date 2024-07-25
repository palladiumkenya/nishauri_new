import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/blood_sugar/data/models/blood_sugar.dart';
import 'package:nishauri/src/features/blood_sugar/data/providers/blood_sugar_provider.dart';
import 'package:nishauri/src/features/blood_sugar/presentation/widgets/blood_level_picker.dart';
import 'package:nishauri/src/features/blood_sugar/presentation/widgets/blood_level_units_picker.dart';

class AddBloodSugarScreen extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  AddBloodSugarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloodLevel = useState<double>(70.0);
    final bloodLevelUnits = useState<LevelPickerUnits>(LevelPickerUnits.mgdl);
    final bloodSugarNotifier = ref.read(bloodSugarEntriesProvider.notifier);
    final note = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Blood Sugar Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                ),
                // Field to take note of user
                TextFormField(
                  controller: note,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                    hintText: 'Enter a note',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a note';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Convert blood level to mmol if necessary
                      if (bloodLevelUnits.value == LevelPickerUnits.mmol) {
                        bloodLevel.value = bloodLevel.value * 18.018;
                      }
                      final entry = BloodSugar(
                        id: DateTime.now().millisecondsSinceEpoch,
                        level: bloodLevel.value,
                        timestamp: DateTime.now(),
                        note: note.text,
                      );
                      debugPrint("Adding entry: $entry");
                      bloodSugarNotifier.addEntry(entry);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Entry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
