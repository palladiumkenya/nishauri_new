import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/HeightUnitsPicker.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';



class HeightPicker extends StatelessWidget {
  final double height;
  final double? min;
  final double? max;
  final Color? activeColor;
  final HeightUnitsPickerOptions heightUnits;
  final void Function(HeightUnitsPickerOptions heightUnits) onHeightUnitsChange;
  final void Function(double height) onHeightChange;

  const HeightPicker(
      {super.key,
      required this.height,
      required this.onHeightChange,
      required this.heightUnits,
      required this.onHeightUnitsChange,
      this.min = 120,
      this.activeColor,
      this.max = 270});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(Constants.SPACING),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Height",
                style: theme.textTheme.titleMedium,
              ),
              HeightUnitsPicker(
                heightUnits: heightUnits,
                onHeightUnitsChange: onHeightUnitsChange,
                activeColor: activeColor,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(Constants.SPACING),
            

            child: Text(
              convertFromCmTo(heightUnits, height).toString(),
              style: theme.textTheme.displayLarge,
            ),
          ),
          Slider(
            value: height,
            
            min: min!,
            max: max!,
            onChanged: onHeightChange,
            activeColor: activeColor ?? theme.colorScheme.primary,
          ),
        ]),
      ),
    );
  }
}
