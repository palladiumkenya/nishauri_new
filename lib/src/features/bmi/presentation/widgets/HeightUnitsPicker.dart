import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

enum HeightUnitsPickerOptions { Cm, Ft, In }


String convertFromCmTo(HeightUnitsPickerOptions units, double cm) {
  switch (units) {
    case HeightUnitsPickerOptions.Ft:
      int totalInches = (cm / 2.54).round();
      int feet = totalInches ~/ 12;
      int inches = totalInches % 12;
      return '$feet\' $inches"';
    case HeightUnitsPickerOptions.In:
      return (cm / 2.54).toStringAsFixed(1);
    default:
      return cm.toStringAsFixed(1);
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
