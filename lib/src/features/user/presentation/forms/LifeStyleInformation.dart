import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';

class LifeStyleInformation extends StatelessWidget {
  const LifeStyleInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final asyncUser = ref.watch(userProvider);
        return asyncUser.when(
          data: (user) => Column(
            children: [
              const SizedBox(height: Constants.SPACING),
              FormBuilderDropdown(
                initialValue: user.maritalStatus,
                name: "maritalStatus",
                decoration: inputDecoration(
                  prefixIcon: Icons.accessibility_sharp,
                  label: "Marital status",
                ),
                items: const [
                  DropdownMenuItem(value: "married", child: Text("Married")),
                  DropdownMenuItem(value: "single", child: Text("Single")),
                  DropdownMenuItem(value: "divorced", child: Text("Divorced")),
                  DropdownMenuItem(
                      value: "widow-widower", child: Text("Widow/Widower")),
                ],
                // validator: FormBuilderValidators.compose([
                //   FormBuilderValidators.required(),
                // ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderDropdown(
                initialValue: user.educationLevel,
                name: "educationLevel",
                decoration: inputDecoration(
                  prefixIcon: Icons.school_outlined,
                  label: "Education level",
                ),
                items: const [
                  DropdownMenuItem(value: "primary", child: Text("Primary")),
                  DropdownMenuItem(
                      value: "secondary", child: Text("Secondary")),
                  DropdownMenuItem(
                      value: "post-secondary", child: Text("Post secondary")),
                  DropdownMenuItem(
                      value: "undergraduate",
                      child: Text("Undergraduate degree")),
                  DropdownMenuItem(
                      value: "postgraduate",
                      child: Text("Postgraduate degree")),
                ],
                // validator: FormBuilderValidators.compose([
                //   FormBuilderValidators.required(),
                // ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderRadioGroup(
                initialValue: user.primaryLanguage,
                name: "primaryLanguage",
                decoration: inputDecoration(
                  prefixIcon: Icons.language,
                  label: "Primary Language",
                ),
                options: const [
                  FormBuilderFieldOption(
                      value: "swahili", child: Text("Swahili")),
                  FormBuilderFieldOption(
                      value: "english", child: Text("English")),
                ],
                // validator: FormBuilderValidators.compose([
                //   FormBuilderValidators.required(),
                // ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderRadioGroup(
                initialValue: user.occupation,
                name: "occupation",
                decoration: inputDecoration(
                  prefixIcon: Icons.work,
                  label: "Occupation",
                ),
                options: const [
                  FormBuilderFieldOption(
                      value: "employed", child: Text("Employed")),
                  FormBuilderFieldOption(
                      value: "self-employed", child: Text("Self Employed")),
                  FormBuilderFieldOption(
                      value: "unemployed", child: Text("Unemployed")),
                ],
                // validator: FormBuilderValidators.compose([
                //   FormBuilderValidators.required(),
                // ]),
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
