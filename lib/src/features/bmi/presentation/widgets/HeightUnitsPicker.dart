import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

enum HeightUnitsPickerOptions { Cm, Ft, In }

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
    final color = theme.canvasColor;
    final bgColor = theme.colorScheme.primary;

    return Row(
      children: [
        Card(
          elevation: 0,
          color: theme.canvasColor,
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
                  heightUnits == HeightUnitsPickerOptions.In ? bgColor : color,
              child: Text(
                "In",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: heightUnits == HeightUnitsPickerOptions.In
                      ? color
                      : bgColor,
                ),
              ),
            ),
          ),
        ),
        Card(
          elevation: 0,
          color: theme.canvasColor,
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
                  heightUnits == HeightUnitsPickerOptions.Ft ? bgColor : color,
              child: Text(
                "Ft",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: heightUnits == HeightUnitsPickerOptions.Ft
                      ? color
                      : bgColor,
                ),
              ),
            ),
          ),
        ),
        Card(
          elevation: 0,
          color: theme.canvasColor,
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
                  heightUnits == HeightUnitsPickerOptions.Cm ? bgColor : color,
              child: Text(
                "Cm",
                style: theme.textTheme.titleSmall?.copyWith(
                  color: heightUnits == HeightUnitsPickerOptions.Cm
                      ? color
                      : bgColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
