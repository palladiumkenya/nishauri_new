import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({super.key});

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
                initialValue: user.email,
                name: "email",
                keyboardType: TextInputType.emailAddress,
                decoration: inputDecoration(
                  placeholder: "Enter your email",
                  prefixIcon: Icons.email,
                  label: "Email",
                ),
                validator: FormBuilderValidators.compose([
                  // FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderTextField(
                name: "phone_no",
                initialValue: user.phoneNumber,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: inputDecoration(
                  placeholder: "Enter your phone number",
                  prefixIcon: Icons.phone,
                  label: "Phone number",
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.minLength(10,
                      errorText: 'Phone number must be 10 digits long'),
                  FormBuilderValidators.maxLength(10,
                      errorText: 'Phone number must be 10 digits long'),
                  (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        !value.startsWith('0')) {
                      return 'Phone number must start with zero';
                    }
                    return null;
                  },
                ]),
              ),
              // const SizedBox(height: Constants.SPACING),
              // FormBuilderTextField(
              //   name: "county",
              //   initialValue: user.county,
              //   decoration: inputDecoration(
              //     placeholder: "Enter your county",
              //     prefixIcon: Icons.location_city,
              //     label: "County",
              //   ),
              //   validator: FormBuilderValidators.compose([
              //     // FormBuilderValidators.required(),
              //   ]),
              // ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderTextField(
                initialValue: user.constituency,
                name: "landmark",
                decoration: inputDecoration(
                  placeholder: "Enter nearby landmark",
                  prefixIcon: Icons.map,
                  label: "Landmark/Village/School",
                ),
                validator: FormBuilderValidators.compose([
                  // FormBuilderValidators.required(),
                ]),
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
