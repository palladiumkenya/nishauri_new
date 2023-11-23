import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/form/AppDropDownInput.dart';
import 'package:nishauri/src/shared/input/MultiChoiceCheckList.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';

class HealthInformation extends StatefulWidget {
  final AppFormState formState;
  final void Function(String, String?) onFormFieldChanged;

  const HealthInformation(
      {super.key, required this.formState, required this.onFormFieldChanged});

  @override
  State<HealthInformation> createState() => _HealthInformationState();
}

class _HealthInformationState extends State<HealthInformation> {
  List<MultiChoiceCheckListChoice> allergies = [];
  List<MultiChoiceCheckListChoice> disabilities = [];
  List<MultiChoiceCheckListChoice> chronics = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: Constants.SPACING),
        SizedBox(
            width: double.infinity,
            child: AppDropDownInput(
              name: "bloodGroup",
              label: "Blood group",
              formState: widget.formState,
              onItemSelected: widget.onFormFieldChanged,
              prefixIcon: Icons.bloodtype,
              items: [
                AppDropDownInputItem(value: "A", label: "A"),
                AppDropDownInputItem(value: "B", label: "B"),
                AppDropDownInputItem(value: "AB", label: "AB"),
                AppDropDownInputItem(value: "O", label: "O"),
              ],
            )),
        const SizedBox(height: Constants.SPACING),
        MultiChoiceCheckList(
          items: [
            MultiChoiceCheckListChoice(label: "Dust", value: "dust"),
            MultiChoiceCheckListChoice(label: "Feather", value: "feather"),
            MultiChoiceCheckListChoice(label: "Cold", value: "cold"),
            MultiChoiceCheckListChoice(label: "Husk", value: "husk"),
          ],
          label: "Do you suffer from any allergies?",
          value: allergies,
          onValueChanged: (values) => setState(() {
            allergies = values;
          }),
        ),
        const SizedBox(height: Constants.SPACING),
        MultiChoiceCheckList(
          items: [
            MultiChoiceCheckListChoice(label: "Blind", value: "blind"),
            MultiChoiceCheckListChoice(label: "Cripple", value: "cripple"),
            MultiChoiceCheckListChoice(label: "Deaf", value: "deaf"),
          ],
          label: "Do you have any disabilities?",
          value: disabilities,
          onValueChanged: (values) => setState(() {
            disabilities = values;
          }),
        ),
        const SizedBox(height: Constants.SPACING),
        MultiChoiceCheckList(
          items: [
            MultiChoiceCheckListChoice(label: "Tuberculosis", value: "TB"),
            MultiChoiceCheckListChoice(label: "Asthma", value: "asthma"),
            MultiChoiceCheckListChoice(label: "Cancer", value: "cancer"),
            MultiChoiceCheckListChoice(label: "Diabetes", value: "diabetes"),
          ],
          label: "Do you suffer from any chronic illness?",
          value: chronics,
          onValueChanged: (values) => setState(() {
            chronics = values;
          }),
        ),
        const SizedBox(height: Constants.SPACING),
      ],
    );
  }
}
