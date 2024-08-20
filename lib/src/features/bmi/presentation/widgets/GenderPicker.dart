import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/constants.dart';
import '../../../../utils/helpers.dart';

enum GenderPickerChoices { male, female }

class GenderPicker extends StatelessWidget {
  final GenderPickerChoices gender;
  final Color? activeColor;
  final void Function(GenderPickerChoices gender) onGenderChange;
  final bool isEnabled;

  const GenderPicker({
    super.key,
    required this.gender,
    required this.onGenderChange,
    this.activeColor,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = getOrientationAwareScreenSize(context);
    final theme = Theme.of(context);
    final color = theme.canvasColor;
    final bgColor = activeColor ?? Constants.activeSelectionColor;
    final disabledColor = Colors.grey;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: isEnabled
                ? () => onGenderChange(GenderPickerChoices.male)
                : null,
            child: Container(
              width: screenSize.width * 0.45,
              height: screenSize.width * 0.45,
              decoration: BoxDecoration(
                color: gender == GenderPickerChoices.male
                    ? bgColor
                    : (isEnabled ? color : disabledColor),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.male,
                    color: gender == GenderPickerChoices.male
                        ? color
                        : (isEnabled ? bgColor : disabledColor),
                    size: screenSize.width * 0.3,
                  ),
                  Text(
                    "Male",
                    style: theme.textTheme.headlineMedium?.copyWith(
                        color: gender == GenderPickerChoices.male
                            ? color
                            : (isEnabled ? bgColor : disabledColor)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: isEnabled
                ? () => onGenderChange(GenderPickerChoices.female)
                : null,
            child: Container(
              width: screenSize.width * 0.45,
              height: screenSize.width * 0.45,
              decoration: BoxDecoration(
                color: gender == GenderPickerChoices.female
                    ? bgColor
                    : (isEnabled ? color : disabledColor),
              ),
              child: Column(children: [
                Icon(
                  Icons.female,
                  color: gender == GenderPickerChoices.female
                      ? color
                      : (isEnabled ? bgColor : disabledColor),
                  size: screenSize.width * 0.3,
                ),
                Text("Female",
                    style: theme.textTheme.headlineMedium?.copyWith(
                        color: gender == GenderPickerChoices.female
                            ? color
                            : (isEnabled ? bgColor : disabledColor))),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
