import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

enum LevelPickerUnits { mgdl, mmol }

double convertFromMgdlTo(LevelPickerUnits units, double mgdl) {
  if (units == LevelPickerUnits.mgdl) {
    return mgdl;
  } else {
    return mgdl / 18.018;
  }
}

class BloodLevelUnitsPicker extends StatelessWidget {
  final LevelPickerUnits bloodLevelUnits;
  final Color? activeColor;
  final void Function(LevelPickerUnits bloodLevelUnits) onBloodLevelUnitsChange;

  const BloodLevelUnitsPicker({
    super.key,
    required this.bloodLevelUnits,
    required this.onBloodLevelUnitsChange,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorActive = theme.canvasColor;
    final colorInactive = theme.colorScheme.onSurface;
    final bgColorActive = activeColor ?? theme.colorScheme.primary;
    final bgColorInActive = theme.disabledColor;

    return Wrap(
      children: [
        Card(
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              onBloodLevelUnitsChange(LevelPickerUnits.mgdl);
            },
            splashColor: theme.colorScheme.primary,
            child: Container(
              padding: const EdgeInsets.all(Constants.SPACING),
              color: bloodLevelUnits == LevelPickerUnits.mgdl
                  ? bgColorActive
                  : bgColorInActive,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "mg/dl",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: bloodLevelUnits == LevelPickerUnits.mgdl
                        ? colorActive
                        : colorInactive,
                  ),
                ),
              ),
            ),
          ),
        ),
        Card(
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () {
              onBloodLevelUnitsChange(LevelPickerUnits.mmol);
            },
            splashColor: theme.colorScheme.primary,
            child: Container(
              padding: const EdgeInsets.all(Constants.SPACING),
              color: bloodLevelUnits == LevelPickerUnits.mmol
                  ? bgColorActive
                  : bgColorInActive,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "mmol/l",
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: bloodLevelUnits == LevelPickerUnits.mmol
                        ? colorActive
                        : colorInactive,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
