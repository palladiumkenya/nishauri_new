import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/input/ImagePicker.dart';
import 'package:nishauri/src/utils/constants.dart';

class PersonalInformation extends StatelessWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController dateOfBirth;
  final TextEditingController gender;
  final TextEditingController image;

  const PersonalInformation({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> genderChoices = [
      {"label": 'Male', 'value': "M"},
      {"label": 'Female', 'value': "F"},
      {"label": 'Unknown', 'value': "U"},
    ];

    return Container(
      child: Column(
        children: [
          const SizedBox(height: Constants.SPACING),
          ImagePickerCustomFormField(image: "https://picsum.photos/200/300"),
          const SizedBox(height: Constants.SPACING),
          FormInputTextField(
            controler: firstName,
            placeholder: "Enter your firstname",
            prefixIcon: Icons.account_circle_outlined,
            label: "First name",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: Constants.SPACING),
          FormInputTextField(
            controler: lastName,
            placeholder: "Enter your last name",
            prefixIcon: Icons.account_circle_outlined,
            label: "Last name",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: Constants.SPACING),
          FormInputTextField(
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('dd MMM yyyy').format(pickedDate);
                dateOfBirth.text = formattedDate;
              } else {}
            },
            controler: dateOfBirth,
            placeholder: "Enter your date of birth",
            prefixIcon: Icons.calendar_month_rounded,
            label: "Date of birth",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          const SizedBox(height: Constants.SPACING),
          FractionallySizedBox(
            widthFactor: 1,
            child: DropdownMenu<String>(
              label: const Text("Gender"),
              leadingIcon: const IconButton(
                onPressed: null,
                icon: Icon(Icons.accessibility_outlined),
              ),
              initialSelection: genderChoices.first["value"],
              controller: gender,
              dropdownMenuEntries: genderChoices
                  .map<DropdownMenuEntry<String>>(
                    (Map<String, String> gender) => DropdownMenuEntry<String>(
                      value: gender['value']!,
                      label: gender['label']!,
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: Constants.SPACING),
        ],
      ),
    );
  }
}
