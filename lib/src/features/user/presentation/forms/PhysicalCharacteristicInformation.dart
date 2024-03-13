import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';

class PhysicalCharacteristicInformation extends StatelessWidget {
  const PhysicalCharacteristicInformation({super.key});

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
                initialValue: user.weight,
                name: "weight",
                decoration: inputDecoration(
                  placeholder: "Enter your weight",
                  prefixIcon: Icons.monitor_weight_outlined,
                  label: "Weight (Kg)",
                ),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  // FormBuilderValidators.required(),
                  // FormBuilderValidators.numeric(),
                ]),
              ),
              const SizedBox(height: Constants.SPACING),
              FormBuilderTextField(
                initialValue: user.height,
                keyboardType: TextInputType.number,
                name: "height",
                decoration: inputDecoration(
                  placeholder: "Enter your height",
                  prefixIcon: Icons.height,
                  label: "Height (Cm)",
                ),
                validator: FormBuilderValidators.compose([
                  // FormBuilderValidators.required(),
                  // FormBuilderValidators.numeric(),
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
