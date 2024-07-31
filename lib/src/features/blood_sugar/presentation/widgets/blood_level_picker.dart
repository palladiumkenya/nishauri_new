import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/features/blood_sugar/presentation/widgets/blood_level_units_picker.dart';
import 'package:nishauri/src/utils/constants.dart';

class BloodLevelPicker extends StatelessWidget {
  final double bloodLevel;
  final double? min;
  final double? max;
  final Color? activeColor;
  final LevelPickerUnits bloodLevelUnits;
  final void Function(LevelPickerUnits bloodLevelUnits) onLevelUnitsChange;
  final void Function(double bloodLevel) onLevelChange;

  const BloodLevelPicker({
    super.key,
    required this.bloodLevel,
    required this.onLevelChange,
    required this.bloodLevelUnits,
    required this.onLevelUnitsChange,
    this.min = 40,
    this.activeColor,
    this.max = 400,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(Constants.SPACING),
        child: Column(children: [
          Text(
            "Select unit",
            style: theme.textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: BloodLevelUnitsPicker(
                  bloodLevelUnits: bloodLevelUnits,
                  onBloodLevelUnitsChange: onLevelUnitsChange,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(Constants.SPACING),
            child: Text(
              convertFromMgdlTo(bloodLevelUnits, bloodLevel).toStringAsFixed(1),
              style: theme.textTheme.displayLarge,
            ),
          ),
          Slider(
            value: bloodLevel,
            min: min!,
            max: max!,
            onChanged: onLevelChange,
            activeColor: activeColor ?? theme.colorScheme.primary,
          ),
        ]),
      ),
    );
  }
}
