import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/input/MultiChoiceCheckList.dart';
import 'package:nishauri/src/utils/constants.dart';

class HealthInformation extends StatefulWidget {
  const HealthInformation({super.key});

  @override
  State<HealthInformation> createState() => _HealthInformationState();
}

class _HealthInformationState extends State<HealthInformation> {
  List<MultiChoiceCheckListChoice> allergies = [];
  List<MultiChoiceCheckListChoice> disabilities =[];
  List<MultiChoiceCheckListChoice> chronics =[];

  @override
  Widget build(BuildContext context) {
    final List<String> bloodGroups = <String>[
      'A',
      'B',
      'AB',
      'O',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: Constants.SPACING),
        SizedBox(
          width: double.infinity,
          child: DropdownMenu<String>(
            leadingIcon: const IconButton(
              onPressed: null,
              icon: Icon(Icons.read_more_outlined),
            ),
            initialSelection: bloodGroups.first,
            label: const Text("Blood group"),
            onSelected: (String? value) {
              setState(() {
                // dropdownValue = value!;
              });
            },
            dropdownMenuEntries:
                bloodGroups.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
        ),
        const SizedBox(height: Constants.SPACING),
        MultiChoiceCheckList(
          items: [
            MultiChoiceCheckListChoice(label: "Dust", value: "dust"),
            MultiChoiceCheckListChoice(label: "Feather", value: "feather"),
            MultiChoiceCheckListChoice(label: "Cold", value: "cold"),
            MultiChoiceCheckListChoice(label: "Husk", value: "husk"),
          ],
          label: "Select your allergies if any",
          value: allergies,
          onValueChanged: (values)=>setState(() {
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
          label: "Select your disabilities if any",
          value: disabilities,
          onValueChanged: (values)=>setState(() {
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
          label: "Select your disabilities if any",
          value: chronics,
          onValueChanged: (values)=>setState(() {
            chronics = values;
          }),
        ),
        const SizedBox(height: Constants.SPACING),
      ],
    );
  }
}
