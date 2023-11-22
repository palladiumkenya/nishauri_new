import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/input/ImagePicker.dart';
import 'package:nishauri/src/utils/constants.dart';

class AccountInformation extends StatelessWidget {


  const AccountInformation(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: Constants.SPACING),
          ImagePickerCustomFormField(image: "https://picsum.photos/200"),
          const SizedBox(height: Constants.SPACING),
          FormInputTextField(
            placeholder: "Enter your username",
            prefixIcon: Icons.account_circle_outlined,
            label: "Username",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),

          const SizedBox(height: Constants.SPACING),
        ],
      ),
    );
  }
}
