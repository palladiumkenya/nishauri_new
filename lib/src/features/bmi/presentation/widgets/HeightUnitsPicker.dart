import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

enum HeightUnitsPickerOptions { Cm, Ft, In }

// double convertFromCmTo(HeightUnitsPickerOptions units, double cm) {
//   switch (units) {
//     case HeightUnitsPickerOptions.Ft:
//       return (cm / 30.48);
//     case HeightUnitsPickerOptions.In:
//       return (cm / 2.54); 
//     default:
//       return cm; 
//   }
// }

//display height for user
String displayHeight(HeightUnitsPickerOptions units, double cm) {
  switch (units) {
    case HeightUnitsPickerOptions.Ft:
      int feet = (cm / 30.48).floor();
      double remainingInches = (cm / 2.54) - (feet * 12);
      int inches = remainingInches.round();

      //since 1 ft = 12 inches
      if(inches == 12) {
        feet += 1;
        inches = 0;
      }
      return "$feet' $inches\"";
    case HeightUnitsPickerOptions.In:
      return (cm / 2.54).toStringAsFixed(1);
    default:
      return cm.toStringAsFixed(1);
  }
}

//Converting height to cm
double convertToCm(HeightUnitsPickerOptions units, double value, [double inches = 0.0]) {
  switch (units) {
    case HeightUnitsPickerOptions.Ft:
      return (value * 30.48) + (inches * 2.54);
    case HeightUnitsPickerOptions.In:
      return value * 2.54;
    default:
      return value;
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