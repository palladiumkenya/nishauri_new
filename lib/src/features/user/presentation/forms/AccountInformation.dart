import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/features/user/presentation/widgets/profile_avatar.dart';
import 'package:nishauri/src/shared/input/ImagePicker.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final asyncUser = ref.watch(userProvider);
        return asyncUser.when(
          data: (user) => Column(
            children: [
              const SizedBox(height: Constants.SPACING),
              ProfileAvatar(),
              const SizedBox(height: Constants.SPACING),
              FormBuilderTextField(
                initialValue: (user.username == 'null null' || user.username == null || user.username == '' || user.username == 'Null Null') ? "" : user.username,
                name: "username",
                enabled: false,
                decoration: inputDecoration(
                  placeholder: "Enter your username",
                  prefixIcon: Icons.account_circle_outlined,
                  label: "Username",
                ),
                validator: FormBuilderValidators.compose([
                  // FormBuilderValidators.required(),
                ]),
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
