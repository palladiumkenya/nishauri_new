import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/form/AppFormTextInput.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';

class HIVProgramRegistration extends StatelessWidget {
  final AppFormState formState;
  final void Function(String, String?) onFormFieldChange;

  const HIVProgramRegistration(
      {super.key, required this.formState, required this.onFormFieldChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppFormTextInput(
          name: "cccNumber",
          formState: formState,
          onChangeText: onFormFieldChange,
          placeholder: "e.g 1234567890",
          prefixIcon: Icons.verified_user,
          label: "CCC Number",
        ),
        const SizedBox(height: Constants.SPACING),
        AppFormTextInput(
          name: "firstName",
          placeholder: "e.g John",
          prefixIcon: Icons.person,
          label: "First Name",
          formState: formState,
          onChangeText: onFormFieldChange,
        ),
        const SizedBox(height: Constants.SPACING),
        const SizedBox(
          height: Constants.SPACING,
        ),
      ],
    );
  }
}
