import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';

class Identifications extends StatelessWidget {
  const Identifications({super.key});

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
                initialValue: user.national_id,
                name: "national_id",
                keyboardType: TextInputType.text,
                decoration: inputDecoration(
                  placeholder: "Enter your National Identification Number",
                  prefixIcon: Icons.card_membership,
                  label: "National ID",
                ),
                validator: FormBuilderValidators.compose([
                  // FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderTextField(
                name: "sha_id",
                initialValue: user.sha_id,
                keyboardType: TextInputType.text,
                maxLength: 10,
                decoration: inputDecoration(
                  placeholder: "Enter your Social Health Authority ID Number",
                  prefixIcon: Icons.card_membership,
                  label: "SHA Number",
                ),
                validator: FormBuilderValidators.compose([
                      (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        !value.startsWith('0')) {
                      return 'SHA Number must have not less than 10 values';
                    }
                    return null;
                  },
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
