import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/utils/constants.dart';

class PhysicalCharacteristicInformation extends StatelessWidget {
  const PhysicalCharacteristicInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Constants.SPACING),
        FormInputTextField(
          placeholder: "Enter your weight",
          prefixIcon: Icons.monitor_weight_outlined,
          label: "Weight",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        const SizedBox(height: Constants.SPACING),
        FormInputTextField(
          placeholder: "Enter your height",
          prefixIcon: Icons.height,
          label: "Height",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ],
    );
  }
}
