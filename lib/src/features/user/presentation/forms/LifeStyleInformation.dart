import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/utils/constants.dart';

class LifeStyleInformation extends StatefulWidget {
  const LifeStyleInformation({super.key});

  @override
  State<LifeStyleInformation> createState() => _LifeStyleInformationState();
}

class _LifeStyleInformationState extends State<LifeStyleInformation> {
  final List<String> maritalStatus = <String>[
    'Married',
    'Single',
    'Divorced',
  ];
  final List<String> languages = <String>[
    'English',
    'Swahili',
  ];  final List<String> educationLevels = <String>[
    'Degree',
    'KCSE',
    'KCPE',
    'None',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Constants.SPACING),
        SizedBox(
          width: double.infinity,
          child: DropdownMenu<String>(
            leadingIcon: const IconButton(
              onPressed: null,
              icon: Icon(Icons.accessibility_sharp),
            ),
            initialSelection: maritalStatus.first,
            label: const Text("Marital status"),
            onSelected: (String? value) {
              setState(() {
                // dropdownValue = value!;
              });
            },
            dropdownMenuEntries:
                maritalStatus.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
        ),
        const SizedBox(height: Constants.SPACING),
        SizedBox(
          width: double.infinity,
          child: DropdownMenu<String>(
            leadingIcon: const IconButton(
              onPressed: null,
              icon: Icon(Icons.language),
            ),
            initialSelection: languages.first,
            label: const Text("Primary language"),
            onSelected: (String? value) {
              setState(() {
                // dropdownValue = value!;
              });
            },
            dropdownMenuEntries:
                languages.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
        ),
        const SizedBox(height: Constants.SPACING),
        SizedBox(
          width: double.infinity,
          child: DropdownMenu<String>(
            leadingIcon: const IconButton(
              onPressed: null,
              icon: Icon(Icons.school_outlined),
            ),
            initialSelection: educationLevels.first,
            label: const Text("Education level"),
            onSelected: (String? value) {
              setState(() {
                // dropdownValue = value!;
              });
            },
            dropdownMenuEntries:
                educationLevels.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
        ),
        const SizedBox(height: Constants.SPACING),
        FormInputTextField(
          placeholder: "Enter your occupation",
          prefixIcon: Icons.map,
          label: "Occupation",
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
