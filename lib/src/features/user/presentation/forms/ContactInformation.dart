import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/form/AppFormTextInput.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';

class ContactInformation extends StatelessWidget {
  final AppFormState formState;
  final void Function(String, String?) onFormFieldChanged;
  const ContactInformation({super.key, required this.formState, required this.onFormFieldChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Constants.SPACING),
        AppFormTextInput(
          name: "email",
          formState: formState,
          onChangeText: onFormFieldChanged,
          keyboardType: TextInputType.emailAddress,
          placeholder: "Enter your email",
          prefixIcon: Icons.email,
          label: "Email",
        ),
        const SizedBox(height: Constants.SPACING),
        AppFormTextInput(
          name: "phoneNumber",
          formState: formState,
          onChangeText: onFormFieldChanged,
          keyboardType: TextInputType.phone,
          placeholder: "Enter your phone number",
          prefixIcon: Icons.phone,
          label: "Phone number",

        ),
        const SizedBox(height: Constants.SPACING),
        AppFormTextInput(
          name: "country",
          formState: formState,
          onChangeText: onFormFieldChanged,
          keyboardType: TextInputType.phone,
          placeholder: "Enter your county",
          prefixIcon: Icons.location_city,
          label: "County",
        ),
        const SizedBox(height: Constants.SPACING),
        AppFormTextInput(
          name: "constituency",
          formState: formState,
          onChangeText: onFormFieldChanged,
          keyboardType: TextInputType.phone,
          placeholder: "Enter your constituency",
          prefixIcon: Icons.map,
          label: "Constituency",
        ),
      ],
    );
  }
}
