import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/form/AppFormTextInput.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';

class PhysicalCharacteristicInformation extends StatelessWidget {
  final AppFormState formState;
  final void Function(String, String?) onFormFieldChanged;

  const PhysicalCharacteristicInformation(
      {super.key, required this.formState, required this.onFormFieldChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Constants.SPACING),
        AppFormTextInput(
          name: "weight",
          formState: formState,
          onChangeText: onFormFieldChanged,
          placeholder: "Enter your weight",
          prefixIcon: Icons.monitor_weight_outlined,
          label: "Weight",
        ),
        const SizedBox(height: Constants.SPACING),
        AppFormTextInput(
          name: "weight",
          formState: formState,
          onChangeText: onFormFieldChanged,
          placeholder: "Enter your height",
          prefixIcon: Icons.height,
          label: "Height",
        ),
      ],
    );
  }
}
