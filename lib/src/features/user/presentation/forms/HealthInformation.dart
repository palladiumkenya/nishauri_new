import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';

class HealthInformation extends StatelessWidget {
  const HealthInformation({Key? key}) : super(key: key);

  static const _headerStyle = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    final MultiSelectController _controller = MultiSelectController();
    List<dynamic>? chronicIllnesses = [];
    List<dynamic>? allergies = [];
    List<dynamic>? disabilities = [];
    return Consumer(
      builder: (context, ref, child) {
        final asyncUser = ref.watch(userProvider);

        return asyncUser.when(
          data: (user) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: Constants.SPACING),
              FormBuilderDropdown(
                initialValue: user.bloodGroup,
                name: "blood_group",
                decoration: inputDecoration(
                  label: "Blood group",
                  prefixIcon: Icons.bloodtype,
                ),
                items: const [
                  DropdownMenuItem(value: "A", child: Text("A")),
                  DropdownMenuItem(value: "B", child: Text("B")),
                  DropdownMenuItem(value: "AB", child: Text("AB")),
                  DropdownMenuItem(value: "O", child: Text("O")),
                  DropdownMenuItem(value: "O+", child: Text("O+")),
                  DropdownMenuItem(value: "O-", child: Text("O-")),
                  DropdownMenuItem(value: "A+", child: Text("A+")),
                  DropdownMenuItem(value: "A-", child: Text("A-")),
                  DropdownMenuItem(value: "B+", child: Text("B+")),
                  DropdownMenuItem(value: "B-", child: Text("B-")),
                  DropdownMenuItem(value: "AB+", child: Text("AB+")),
                  DropdownMenuItem(value: "AB-", child: Text("AB-")),
                ],
              ),
              const SizedBox(height: Constants.SPACING),
              // FormBuilderCheckboxGroup(
              //   initialValue: user.allergies?.split(",")?.toList() ?? [],
              //   name: "allergies",
              //   decoration: InputDecoration(
              //     labelText: "Allergy",
              //     prefixIcon: const Icon(Icons.ac_unit),
              //   ),
              //   options: const [
              //     FormBuilderFieldOption(value: "Dust", child: Text("Dust")),
              //     FormBuilderFieldOption(value: "Cold", child: Text("Cold")),
              //     FormBuilderFieldOption(value: "Fish", child: Text("Fish")),
              //     FormBuilderFieldOption(
              //         value: "Cephalosporins", child: Text("Cephalosporins")),
              //   ],
              // ),

              FormBuilderField(
                name: "allergies",
                initialValue: allergies,
                builder: (_) {
                  debugPrint("Initial value for allergies:");
                  debugPrint(allergies.toString());
                  return const SizedBox.shrink(); // Invisible widget
                },
              ),

              const SizedBox(height: Constants.SPACING),
              Row(
                children: [
                  Icon(
                    Icons.ac_unit, // Replace Icons.assessment with the icon you want
                    color: Colors.grey, // Change the color as per your preference
                  ),
                  Text(
                    'ALLERGIES',
                    style: _headerStyle,
                  ),

                ],
              ),
              MultiSelectDropDown(
                clearIcon: const Icon(Icons.clear),
                onOptionSelected: (List<ValueItem> selectedOptions) {
                  allergies.clear();
                  allergies.addAll(selectedOptions.map((item) => item.value.toString()).toList());// Add newly selected options
                  debugPrint(allergies.map((item) => item.value).toList().toString()); // Print selected options
                },
                // disabledOptions: user.allergies?.split(",")?.map((item) => ValueItem(label: item, value: item)).toList() ?? [],
                options: const <ValueItem>[
                  ValueItem(label: 'Dust', value: 'Dust'),
                  ValueItem(label: 'Fish', value: 'Fish'),
                  ValueItem(label: 'Cold', value: 'Cold'),
                  ValueItem(label: 'Cephalosporins', value: 'Cephalosporins'),
                  ValueItem(label: 'Peanuts', value: 'Peanuts'),
                ],
                searchEnabled: true,
                selectedOptions: user.allergies?.split(",")?.map((item) => ValueItem(label: item, value: item)).toList() ?? [],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                optionTextStyle: const TextStyle(fontSize: 14),
                dropdownHeight: 300,
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),

              const SizedBox(height: Constants.SPACING),
              // FormBuilderCheckboxGroup(
              //   initialValue: user.disabilities?.split(",")?.toList() ?? [],
              //   name: "disabilities",
              //   decoration: InputDecoration(
              //     prefixIcon: const Icon(Icons.accessible_forward),
              //     labelText: "Disabilities",
              //   ),
              //   options: const [
              //     FormBuilderFieldOption(value: "Blind", child: Text("Blind")),
              //     FormBuilderFieldOption(value: "Cripple", child: Text("Cripple")),
              //     FormBuilderFieldOption(value: "Deaf", child: Text("Deaf")),
              //   ],
              // ),

              FormBuilderField(
                name: "disabilities",
                initialValue: disabilities,
                builder: (_) {
                  debugPrint("Initial value for disabilities:");
                  debugPrint(disabilities.toString());
                  return const SizedBox.shrink(); // Invisible widget
                },
              ),

              const SizedBox(height: Constants.SPACING),
              Row(
                children: [
                  Icon(
                    Icons.accessible_forward, // Replace Icons.assessment with the icon you want
                    color: Colors.grey, // Change the color as per your preference
                  ),
                  Text(
                    'DISABILITIES',
                    style: _headerStyle,
                  ),

                ],
              ),
              MultiSelectDropDown(
                clearIcon: const Icon(Icons.clear),
                onOptionSelected: (List<ValueItem> selectedOptions) {
                  disabilities.clear();
                  disabilities.addAll(selectedOptions.map((item) => item.value.toString()).toList());// Add newly selected options
                  debugPrint(disabilities.map((item) => item.value).toList().toString()); // Print selected options
                },
                // disabledOptions: user.disabilities?.split(",")?.map((item) => ValueItem(label: item, value: item)).toList() ?? [],
                options: const <ValueItem>[
                  ValueItem(label: 'Blind', value: 'Blind'),
                  ValueItem(label: 'Deaf', value: 'Deaf'),
                  ValueItem(label: 'Mental', value: 'Mental'),
                ],
                searchEnabled: true,
                selectedOptions: user.disabilities?.split(",")?.map((item) => ValueItem(label: item, value: item)).toList() ?? [],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                optionTextStyle: const TextStyle(fontSize: 14),
                dropdownHeight: 300,
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),

              FormBuilderField(
                name: "chronics",
                initialValue: chronicIllnesses,
                builder: (_) {
                  debugPrint("Initial value for chronics:");
                  debugPrint(chronicIllnesses.toString());
                  return const SizedBox.shrink(); // Invisible widget
                },
              ),

              const SizedBox(height: Constants.SPACING),
              Row(
                children: [
                  Icon(
                    Icons.sick, // Replace Icons.assessment with the icon you want
                    color: Colors.grey, // Change the color as per your preference
                  ),
                  Text(
                    'CHRONIC ILLNESS',
                    style: _headerStyle,
                  ),

                ],
              ),

              // const Text('CHRONIC ILLNESS', style: _headerStyle),
              MultiSelectDropDown(
                clearIcon: const Icon(Icons.clear),
                onOptionSelected: (List<ValueItem> selectedOptions) {
                  chronicIllnesses.clear();
                  chronicIllnesses.addAll(selectedOptions.map((item) => item.value.toString()).toList());// Add newly selected options
                  debugPrint(selectedOptions.map((item) => item.value).toList().toString()); // Print selected options
                },
                // disabledOptions: user.chronics?.split(",")?.map((item) => ValueItem(label: item, value: item)).toList() ?? [],
                options: const <ValueItem>[
                  ValueItem(label: 'Diabetes', value: 'Diabetes'),
                  ValueItem(label: 'Cancer', value: 'Cancer'),
                  ValueItem(label: 'Asthma', value: 'Asthma'),
                  ValueItem(label: 'TB', value: 'TB'),
                  ValueItem(label: 'HIV', value: 'HIV'),
                ],
                searchEnabled: true,
                selectedOptions: user.chronics?.split(",")?.map((item) => ValueItem(label: item, value: item)).toList() ?? [],
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                optionTextStyle: const TextStyle(fontSize: 14),
                dropdownHeight: 300,
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),
            ],
          ),
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
