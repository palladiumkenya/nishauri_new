import 'package:flutter/material.dart';

import '../../../../utils/helpers.dart';

enum GenderPickerChoices { male, female }

class GenderPicker extends StatelessWidget {
  final GenderPickerChoices gender;
  final Color? activeColor;
  final void Function(GenderPickerChoices gender) onGenderChange;

  const GenderPicker(
      {super.key, required this.gender, required this.onGenderChange, this.activeColor});

  @override
  Widget build(BuildContext context) {
    final screenSize = getOrientationAwareScreenSize(context);
    final theme = Theme.of(context);
    final color = theme.canvasColor;
    final bgColor = activeColor ?? theme.colorScheme.primary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              onGenderChange(GenderPickerChoices.male);
            },
            child: Container(
              width: screenSize.width * 0.45,
              height: screenSize.width * 0.45,
              decoration: BoxDecoration(
                color: gender == GenderPickerChoices.male ? bgColor : color,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.male,
                    color: gender == GenderPickerChoices.male ? color : bgColor,
                    size: screenSize.width * 0.3,
                  ),
                  Text(
                    "Male",
                    style: theme.textTheme.headlineMedium?.copyWith(
                        color: gender == GenderPickerChoices.male
                            ? color
                            : bgColor),
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              onGenderChange(GenderPickerChoices.female);
            },
            child: Container(
              width: screenSize.width * 0.45,
              height: screenSize.width * 0.45,
              decoration: BoxDecoration(
                color: gender == GenderPickerChoices.female ? bgColor : color,
              ),
              child: Column(children: [
                Icon(
                  Icons.female,
                  color: gender == GenderPickerChoices.female ? color : bgColor,
                  size: screenSize.width * 0.3,
                ),
                Text("Female",
                    style: theme.textTheme.headlineMedium?.copyWith(
                        color: gender == GenderPickerChoices.female
                            ? color
                            : bgColor)),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
