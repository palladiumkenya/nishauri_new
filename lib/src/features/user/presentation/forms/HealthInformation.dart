import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';

class HealthInformation extends StatelessWidget {
  const HealthInformation({super.key});

  @override
  Widget build(BuildContext context) {
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
                name: "bloodGroup",
                decoration: inputDecoration(
                  label: "Blood group",
                  prefixIcon: Icons.bloodtype,
                ),
                items: const [
                  DropdownMenuItem(value: "A", child: Text("A")),
                  DropdownMenuItem(value: "B", child: Text("B")),
                  DropdownMenuItem(value: "AB", child: Text("AB")),
                  DropdownMenuItem(value: "O", child: Text("O")),
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderFilterChip(
                initialValue: user.allergies,
                name: "allergies",
                spacing: Constants.SPACING,
                decoration: inputDecoration(
                  label: "Do you suffer from any allergies?",
                  prefixIcon: Icons.ac_unit,
                ),
                options: const [
                  FormBuilderChipOption(value: "dust", child: Text("Dust")),
                  FormBuilderChipOption(
                      value: "feather", child: Text("Feather")),
                  FormBuilderChipOption(value: "cold", child: Text("Cold")),
                  FormBuilderChipOption(value: "husk", child: Text("Husk")),
                ],

              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderCheckboxGroup(
                initialValue: user.disabilities,
                name: "disabilities",
                decoration: inputDecoration(
                  prefixIcon: Icons.accessible_forward,
                  label: "Do you have any disabilities?",
                ),
                options: const [
                  FormBuilderFieldOption(value: "blind", child: Text("Blind")),
                  FormBuilderFieldOption(
                      value: "cripple", child: Text("Cripple")),
                  FormBuilderFieldOption(value: "deaf", child: Text("Deaf")),
                ],
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderCheckboxGroup(
                initialValue: user.chronics,
                name: "chronics",
                options: const [
                  FormBuilderFieldOption(
                      value: "TB", child: Text("Tuberculosis")),
                  FormBuilderFieldOption(
                      value: "asthma", child: Text("Asthma")),
                  FormBuilderFieldOption(
                      value: "cancer", child: Text("Cancer")),
                  FormBuilderFieldOption(
                      value: "diabetes", child: Text("Diabetes")),
                ],
                decoration: inputDecoration(
                  prefixIcon: Icons.sick,
                  label: "Do you suffer from any chronic illness?",
                ),
              ),
              const SizedBox(height: Constants.SPACING),
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
