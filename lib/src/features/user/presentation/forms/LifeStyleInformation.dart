import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/form/AppDropDownInput.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';

class LifeStyleInformation extends StatefulWidget {
  final AppFormState formState;
  final void Function(String, String?) onFormFieldChanged;

  const LifeStyleInformation(
      {super.key, required this.formState, required this.onFormFieldChanged});

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
  ];
  final List<String> educationLevels = <String>[
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
          child: AppDropDownInput(
            formState: widget.formState,
            name: "maritalStatus",
            prefixIcon: Icons.accessibility_sharp,
            label: "Marital status",
            onItemSelected: widget.onFormFieldChanged,
            items: const [
              DropdownMenuEntry(value: "married", label: "Married"),
              DropdownMenuEntry(value: "single", label: "Single"),
              DropdownMenuEntry(value: "divorced", label: "Divorced"),
              DropdownMenuEntry(
                  value: "widow-widower", label: "Widow/Widower"),
            ],
          ),
        ),
        const SizedBox(height: Constants.SPACING),
        SizedBox(
          width: double.infinity,
          child: AppDropDownInput(
            name: "primaryLanguage",
            formState: widget.formState,
            onItemSelected: widget.onFormFieldChanged,
            prefixIcon: Icons.language,
            label: "Primary Language",
            items: const [
              DropdownMenuEntry(value: "swahili", label: "Swahili"),
              DropdownMenuEntry(value: "english", label: "English"),
            ],
          ),
        ),
        const SizedBox(height: Constants.SPACING),
        SizedBox(
          width: double.infinity,
          child: AppDropDownInput(
            onItemSelected: widget.onFormFieldChanged,
            formState: widget.formState,
            prefixIcon: Icons.school_outlined,
            name: "educationLevel",
            label: "Education level",
            items: const [
              DropdownMenuEntry(label: "Primary", value: "primary"),
              DropdownMenuEntry(label: "Secondary", value: "secondary"),
              DropdownMenuEntry(label: "Post secondary", value: "post-secondary"),
              DropdownMenuEntry(label: "Undergraduate degree", value: "undergraduate"),
              DropdownMenuEntry(label: "Postgraduate degree", value: "postgraduate"),
            ],
          ),
        ),
        const SizedBox(height: Constants.SPACING),
        SizedBox(
          width: double.infinity,
          child: AppDropDownInput(
            onItemSelected: widget.onFormFieldChanged,
            formState: widget.formState,
            prefixIcon: Icons.work,
            name: "occupation",
            label: "Occupation",
            items: const [
              DropdownMenuEntry(label: "Employed", value: "employed"),
              DropdownMenuEntry(label: "Self Employed", value: "self-employed"),
              DropdownMenuEntry(label: "Unemployed", value: "unemployed"),
            ],
          ),
        ),
      ],
    );
  }
}
