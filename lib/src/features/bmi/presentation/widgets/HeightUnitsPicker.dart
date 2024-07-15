import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

enum HeightUnitsPickerOptions { Cm, Ft, In }


// String convertFromCmTo(HeightUnitsPickerOptions units, double cm) {
//   switch (units) {
//     case HeightUnitsPickerOptions.Ft:
//       int totalInches = (cm / 2.54).round();
//       int feet = totalInches ~/ 12;
//       int inches = totalInches % 12;
//       return '$feet\' ${inches.toStringAsFixed(4)}"';
//     case HeightUnitsPickerOptions.In:
//       return (cm / 2.54).toStringAsFixed(4);
//     default:
//       return cm.toStringAsFixed(4);
//   }
// }

double truncateDouble(double value, int decimals) {
  num mod = pow(10.0, decimals);
  return ((value * mod).truncateToDouble() / mod);
  }

double convertFromCmTo(HeightUnitsPickerOptions units, double cm) {
  switch (units) {
    case HeightUnitsPickerOptions.Ft:
      double feet = cm / 30.48;
      return truncateDouble(feet, 1); // Convert to feet (1 cm = 0.0328 ft)
    case HeightUnitsPickerOptions.In:
      double inches = cm / 2.54;
      return truncateDouble(inches, 1); // Convert to inches (1 cm = 0.3937 in)
    default:
      return truncateDouble(cm, 1); // No conversion needed for centimeters
  }
}

class HeightUnitsPicker extends StatelessWidget {
  final HeightUnitsPickerOptions heightUnits;
  final Color? activeColor;
  final void Function(HeightUnitsPickerOptions heightUnits) onHeightUnitsChange;

  const HeightUnitsPicker(
      {super.key,
      required this.heightUnits,
      required this.onHeightUnitsChange, this.activeColor,});

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
              onHeightUnitsChange(HeightUnitsPickerOptions.In);
            },
            splashColor: theme.colorScheme.primary,
            child: Container(
              padding: const EdgeInsets.all(Constants.SPACING),
              color:
                  heightUnits == HeightUnitsPickerOptions.In ? bgColorActive : bgColorInActive,
              child: Text(
                "In",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: heightUnits == HeightUnitsPickerOptions.In
                      ? colorActive
                      : colorInactive,
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
              onHeightUnitsChange(HeightUnitsPickerOptions.Ft);
            },
            splashColor: theme.colorScheme.primary,
            child: Container(
              padding: const EdgeInsets.all(Constants.SPACING),
              color:
                  heightUnits == HeightUnitsPickerOptions.Ft ? bgColorActive : bgColorInActive,
              child: Text(
                "Ft",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: heightUnits == HeightUnitsPickerOptions.Ft
                      ? colorActive
                      : colorInactive,
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
              onHeightUnitsChange(HeightUnitsPickerOptions.Cm);
            },
            splashColor: theme.colorScheme.primary,
            child: Container(
              padding: const EdgeInsets.all(Constants.SPACING),
              color:
                  heightUnits == HeightUnitsPickerOptions.Cm ? bgColorActive : bgColorInActive,
              child: Text(
                "Cm",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: heightUnits == HeightUnitsPickerOptions.Cm
                      ? colorActive
                      : colorInactive,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
