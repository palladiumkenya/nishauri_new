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
            items: [
              AppDropDownInputItem(value: "married", label: "Married"),
              AppDropDownInputItem(value: "single", label: "Single"),
              AppDropDownInputItem(value: "divorced", label: "Divorced"),
              AppDropDownInputItem(
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
            items: [
              AppDropDownInputItem(value: "swahili", label: "Swahili"),
              AppDropDownInputItem(value: "english", label: "English"),
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
            items: [
              AppDropDownInputItem(label: "Primary", value: "primary"),
              AppDropDownInputItem(label: "Secondary", value: "secondary"),
              AppDropDownInputItem(label: "Post secondary", value: "post-secondary"),
              AppDropDownInputItem(label: "Undergraduate degree", value: "undergraduate"),
              AppDropDownInputItem(label: "Postgraduate degree", value: "postgraduate"),
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
            items: [
              AppDropDownInputItem(label: "Employed", value: "employed"),
              AppDropDownInputItem(label: "Self Employed", value: "self-employed"),
              AppDropDownInputItem(label: "Unemployed", value: "unemployed"),
            ],
          ),
        ),
      ],
    );
  }
}
