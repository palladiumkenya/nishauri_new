import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final asyncUser = ref.watch(userProvider);
        return asyncUser.when(
          data: (user) => Column(
            children: [
              const SizedBox(height: Constants.SPACING),
              FormBuilderTextField(
                initialValue: user.firstName,
                name: "firstName",
                decoration: inputDecoration(
                  placeholder: "Enter your firstname",
                  prefixIcon: Icons.account_circle_outlined,
                  label: "First name",
                ),
                // validator: FormBuilderValidators.compose([
                //   FormBuilderValidators.required(),
                // ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderTextField(
                initialValue: user.lastName,
                name: "lastName",
                decoration: inputDecoration(
                  placeholder: "Enter your last name",
                  prefixIcon: Icons.account_circle_outlined,
                  label: "Last name",
                ),
                validator: FormBuilderValidators.compose([
                  // FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderDateTimePicker(
                initialValue: DateTime.tryParse(user.dateOfBirth ?? ""),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100),
                name: "dateOfBirth",
                format: DateFormat('yyy-MMM-dd'),
                inputType: InputType.date,
                decoration: inputDecoration(
                  placeholder: "Enter your date of birth",
                  prefixIcon: Icons.calendar_month_rounded,
                  label: "Date of birth",
                ),
                validator: FormBuilderValidators.compose([
                  // FormBuilderValidators.required(),
                ]),
                valueTransformer: (date) => date?.toIso8601String(),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderDropdown(
                initialValue: user.gender == "M" ? "Male" : "Female",
                name: "gender",
                decoration: inputDecoration(
                  prefixIcon: Icons.accessibility,
                  label: "Gender",
                ),
                // validator: FormBuilderValidators.compose([
                //   FormBuilderValidators.required(),
                // ]),
                items: const [
                  DropdownMenuItem(
                    value: "Male",
                    child: Text("Male"),
                  ),
                  DropdownMenuItem(
                    value: "Female",
                    child: Text("Female"),
                  ),
                ],
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
