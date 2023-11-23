import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/form/AppFormImagePicker.dart';
import 'package:nishauri/src/shared/form/AppFormTextInput.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/input/ImagePicker.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';

class AccountInformation extends StatelessWidget {
  final AppFormState formState;
  final void Function(String, String?) onFormFieldChanged;

  const AccountInformation(
      {super.key, required this.formState, required this.onFormFieldChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Constants.SPACING),
        AppFormImagePicker(
          name: "image",
          formState: formState,
          onImageChange: onFormFieldChanged,

        ),
        const SizedBox(height: Constants.SPACING),
        AppFormTextInput(
          name: "username",
          onChangeText: onFormFieldChanged,
          formState: formState,
          placeholder: "Enter your username",
          prefixIcon: Icons.account_circle_outlined,
          label: "Username",
        ),
        const SizedBox(height: Constants.SPACING),
      ],
    );
  }
}
