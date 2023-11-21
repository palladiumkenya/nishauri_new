import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/utils/constants.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Constants.SPACING),
        FormInputTextField(
          keyboardType: TextInputType.emailAddress,
          placeholder: "Enter your email",
          prefixIcon: Icons.email,
          label: "Email",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        const SizedBox(height: Constants.SPACING),
        FormInputTextField(
          keyboardType: TextInputType.phone,
          placeholder: "Enter your phone number",
          prefixIcon: Icons.phone,
          label: "Phone number",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        const SizedBox(height: Constants.SPACING),
        FormInputTextField(
          keyboardType: TextInputType.phone,
          placeholder: "Enter your county",
          prefixIcon: Icons.location_city,
          label: "County",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        const SizedBox(height: Constants.SPACING),
        FormInputTextField(
          keyboardType: TextInputType.phone,
          placeholder: "Enter your constituency",
          prefixIcon: Icons.map,
          label: "Constituency",
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
