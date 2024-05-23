import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/presentation/pages/VerifyResetPasswordScreen.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/display/label_input_container.dart';
import 'package:nishauri/src/shared/display/scafold_stack_body.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

import '../../../../shared/display/Logo.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  // var username = TextEditingController();
  bool _loading = false;

  // var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var theme = Theme.of(context);

        void handleSubmit() async {
          if (_formKey.currentState != null &&
              _formKey.currentState!.saveAndValidate()) {
            final formState = _formKey.currentState!.value;
            setState(() {
              _loading = true;
            });
            final authStateNotifier = ref.read(authStateProvider.notifier);
            final userStateNotifier = ref.read(resetPasswordProvider.notifier);
            userStateNotifier.resetPassword(formState).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(value)),
              );
              context.goNamed(RouteNames.VERIFY_RESET_PASSWORD_SCREEN,
                  extra: formState['user_name']);
            }).catchError((err) {
              handleResponseError(context, _formKey.currentState!.fields, err,
                  authStateNotifier.logout);
            }).whenComplete(() {
              setState(() {
                _loading = false;
              });
            });
          }
        }

        return Scaffold(
          body: ScaffoldStackedBody(
              body: Column(
            children: [
              AppBar(
                // title: const Text("Sign Up"),
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: SvgPicture.asset(
                    "assets/images/reply-dark.svg",
                    semanticsLabel: "Doctors",
                    fit: BoxFit.contain,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              Expanded(
                  child: FormBuilder(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Constants.SMALL_SPACING),
                        const DecoratedBox(
                          decoration: BoxDecoration(),
                          child: Logo(
                            size: 100,
                          ),
                        ),
                        const SizedBox(height: Constants.SMALL_SPACING),
                        const Text(
                          "Forgot Password 😯",
                          style: TextStyle(fontSize: 40),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        Text(
                          "No worries! Enter your phone number below and we will send you code to reset password",
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: Constants.SPACING * 3),
                        LabelInputContainer(
                          label: "Phone number",
                          child: FormBuilderTextField(
                            name: "user_name",
                            decoration: outLineInputDecoration(
                              placeholder: "Enter your phone number",
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(10,
                                  errorText:
                                      'Phone number must be 10 digits long'),
                              FormBuilderValidators.maxLength(10,
                                  errorText:
                                      'Phone number must be 10 digits long'),
                              (value) {
                                if (value != null &&
                                    value.isNotEmpty &&
                                    !value.startsWith('0')) {
                                  return 'Phone number must start with zero';
                                }
                                return null;
                              },
                            ]),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(height: Constants.SPACING*6),
                        Button(
                          title: "Submit Request",
                          backgroundColor: theme.colorScheme.primary,
                          textColor: Colors.white,
                          onPress: handleSubmit,
                          loading: _loading,
                        ),
                        const SizedBox(
                          height: Constants.SPACING,
                        ),
                        LinkedRichText(

                          linked: "",
                          unlinked: "Back to login",
                          onPress: () =>
                              context.goNamed(RouteNames.LOGIN_SCREEN),
                        )
                      ],
                    ),
                  ),
                ),
              ))
            ],
          )),
        );
      },
    );
  }
}
