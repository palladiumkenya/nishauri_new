import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

enum HeightUnitsPickerOptions { Cm, Ft, In }

String convertFromCmTo(HeightUnitsPickerOptions units, double cm) {
  switch (units) {
    case HeightUnitsPickerOptions.Ft:
      return cm / 30.48; // Convert to feet (1 cm = 0.0328 ft) (1 ft = 30.48cm)
      int feet = (cm / 30.48).floor(); //converting to feet without rounding up(1cm = 0.0328084 ft)
      double inches = (cm / 2.54) % 12; // first converting to inches then finding the remainder when dividing it by 12, since there are 12 inches in one foot 
      return '$feet\' ${inches.toStringAsFixed(0)}"';
      //return cm / 30.48; // Convert to feet (1 cm = 0.0328084 ft)
    case HeightUnitsPickerOptions.In:
      return cm / 2.54; // Convert to inches (1 cm = 0.3937 in) (1 In = 2.54cm)
      return (cm / 2.54).toStringAsFixed(1); // Convert to inches (1 cm = 0.3937 in)
    default:
      return cm.toStringAsFixed(1); // No conversion needed for centimeters
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
