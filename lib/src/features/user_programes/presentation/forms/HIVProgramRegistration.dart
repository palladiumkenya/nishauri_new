import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/utils/constants.dart';

class HIVProgramRegistration extends StatefulWidget {
  const HIVProgramRegistration({super.key});

  @override
  State<HIVProgramRegistration> createState() => _HIVProgramRegistrationState();
}

class _HIVProgramRegistrationState extends State<HIVProgramRegistration> {
  var _cccNumber;
  var _firstName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormInputTextField(
          onSaved: (ccc) => _cccNumber = ccc,
          placeholder: "e.g 1234567890",
          prefixIcon: Icons.verified_user,
          label: "CCC Number",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        const SizedBox(height: Constants.SPACING),
        FormInputTextField(
          onSaved: (name)=>_firstName = name,
          placeholder: "e.g John",
          prefixIcon: Icons.person,
          label: "First Name",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        const SizedBox(height: Constants.SPACING),
        const SizedBox(
          height: Constants.SPACING,
        ),
      ],
    );
  }
}
