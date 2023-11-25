import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/shared/form/AppDropDownInput.dart';
import 'package:nishauri/src/shared/form/AppFormDateTimePicker.dart';
import 'package:nishauri/src/shared/form/AppFormTextInput.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/input/ImagePicker.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';

class PersonalInformation extends StatelessWidget {
  final AppFormState formState;
  final void Function(String, String?) onFormFieldChanged;

  const PersonalInformation(
      {super.key, required this.formState, required this.onFormFieldChanged});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const SizedBox(height: Constants.SPACING),
        AppFormTextInput(
          name: "firstName",
          onChangeText: onFormFieldChanged,
          formState: formState,
          placeholder: "Enter your firstname",
          prefixIcon: Icons.account_circle_outlined,
          label: "First name",
        ),
        const SizedBox(height: Constants.SPACING),
        AppFormTextInput(
          name: "lastName",
          onChangeText: onFormFieldChanged,
          formState: formState,
          placeholder: "Enter your last name",
          prefixIcon: Icons.account_circle_outlined,
          label: "Last name",
        ),
        const SizedBox(height: Constants.SPACING),
        AppFormDateTimePicker(
          name: "dateOfBirth",
          formState: formState,
          onDateChanged: onFormFieldChanged,
          placeholder: "Enter your date of birth",
          prefixIcon: Icons.calendar_month_rounded,
          label: "Date of birth",
        ),
        const SizedBox(height: Constants.SPACING),
        FractionallySizedBox(
          widthFactor: 1,
          child: AppDropDownInput(
            formState: formState,
            name: "gender",
            onItemSelected: onFormFieldChanged,
            prefixIcon: Icons.accessibility,
            label: "Gender",
            items: const [
              DropdownMenuEntry(value: "M", label: "Male"),
              DropdownMenuEntry(value: "F", label: "Female"),

            ],
          ),
        ),
        const SizedBox(height: Constants.SPACING),
      ],
    );
  }
}
