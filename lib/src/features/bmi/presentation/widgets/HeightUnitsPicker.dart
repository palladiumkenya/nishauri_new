import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

enum HeightUnitsPickerOptions { Cm, Ft, In }

double convertFromCmTo(HeightUnitsPickerOptions units, double cm) {
  switch (units) {
    case HeightUnitsPickerOptions.Ft:
      return cm / 30.48; // Convert to feet (1 cm = 0.0328 ft)
    case HeightUnitsPickerOptions.In:
      return cm / 2.54; // Convert to inches (1 cm = 0.3937 in)
    default:
      return cm; // No conversion needed for centimeters
  }
}


class HeightUnitsPicker extends StatelessWidget {
  final HeightUnitsPickerOptions heightUnits;
  final void Function(HeightUnitsPickerOptions heightUnits) onHeightUnitsChange;

  const HeightUnitsPicker(
      {super.key,
      required this.heightUnits,
      required this.onHeightUnitsChange});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorActive = theme.canvasColor;
    final colorInactive = theme.colorScheme.onSurface;
    final bgColorActive = theme.colorScheme.primary;
    final bgColorInActive = theme.disabledColor;


    return Row(
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
