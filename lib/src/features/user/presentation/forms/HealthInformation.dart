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
                  DropdownMenuItem(value: "O+", child: Text("O+")),
                  DropdownMenuItem(value: "O-", child: Text("O-")),
                  DropdownMenuItem(value: "A+", child: Text("A+")),
                  DropdownMenuItem(value: "A-", child: Text("A-")),
                  DropdownMenuItem(value: "B+", child: Text("B+")),
                  DropdownMenuItem(value: "B-", child: Text("B-")),
                  DropdownMenuItem(value: "AB+", child: Text("AB+")),
                  DropdownMenuItem(value: "AB-", child: Text("AB-")),
                ],
                // validator: FormBuilderValidators.compose([
                //   FormBuilderValidators.required(),
                // ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderDropdown(
                initialValue: user.allergies,
                name: "allergies",
                decoration: inputDecoration(
                  label: "Allergy",
                  prefixIcon: Icons.ac_unit,
                ),
                items: const [
                  DropdownMenuItem(value: "Dust",
                      child: Text("Dust")),
                  DropdownMenuItem(value: "Cold",
                      child: Text("Cold")),
                  DropdownMenuItem(value: "Fsh",
                      child: Text("Fish")),
                  DropdownMenuItem(value: "Cephalosporins",
                      child: Text("Cephalosporins")),
                  // FormBuilderChipOption(value: "dust", child: Text("Dust")),
                  // FormBuilderChipOption(
                  //     value: "feather", child: Text("Feather")),
                  // FormBuilderChipOption(value: "cold", child: Text("Cold")),
                  // FormBuilderChipOption(value: "husk", child: Text("Husk")),
                ],

              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderDropdown(
                initialValue: user.disabilities,
                name: "disabilities",
                decoration: inputDecoration(
                  prefixIcon: Icons.accessible_forward,
                  label: "Disabilities",
                ),
                items: const [
                  DropdownMenuItem(value: "Blind", child: Text("Blind")),
                  DropdownMenuItem(value: "Cripple", child: Text("Cripple")),
                  DropdownMenuItem(value: "Deaf", child: Text("Deaf")),
                  // FormBuilderFieldOption(value: "blind", child: Text("Blind")),
                  // FormBuilderFieldOption(
                  //     value: "cripple", child: Text("Cripple")),
                  // FormBuilderFieldOption(value: "deaf", child: Text("Deaf")),
                ],
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderDropdown(
                initialValue: user.chronics,
                name: "chronics",
                items: const [
                  DropdownMenuItem(value: "TB", child: Text("Tuberculosis")),
                  DropdownMenuItem(value: "Asthma", child: Text("Asthma")),
                  DropdownMenuItem(value: "Cancer", child: Text("Cancer")),
                  DropdownMenuItem(value: "Diabetes", child: Text("Diabetes")),
                  // FormBuilderFieldOption(
                  //     value: "TB", child: Text("Tuberculosis")),
                  // FormBuilderFieldOption(
                  //     value: "asthma", child: Text("Asthma")),
                  // FormBuilderFieldOption(
                  //     value: "cancer", child: Text("Cancer")),
                  // FormBuilderFieldOption(
                  //     value: "diabetes", child: Text("Diabetes")),
                ],
                decoration: inputDecoration(
                  prefixIcon: Icons.sick,
                  label: "Chronic Illness",
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
