import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/presentation/pages/ResetPasswordScreen.dart';
import 'package:nishauri/src/features/auth/presentation/pages/resetPasswordScreen.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class VerifyResetPasswordScreen extends StatefulWidget {
  final String user_name;
  const VerifyResetPasswordScreen({Key? key, required this.user_name}) : super(key: key);

  @override
  State<VerifyResetPasswordScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerifyResetPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer(
        builder: (context, ref, child) {
          void handleSubmit() {
            if (_formKey.currentState!.saveAndValidate()) {
              setState(() {
                _loading = true;
              });
              final passwordResetStateNotifier = ref.read(resetPasswordProvider.notifier);
              final authStateNotifier = ref.read(authStateProvider.notifier);

              // Form payload
              final payload = {
                "user_name": widget.user_name,
                "otp": _formKey.currentState!.value['otp'],
              };

              passwordResetStateNotifier.verifyResetPassword(payload).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(value)),
                );
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPassword(user_name: widget.user_name)));
              }).catchError((err) {
                handleResponseError(context, _formKey.currentState!.fields, err, authStateNotifier.logout);
              }).whenComplete(() {
                setState(() {
                  _loading = false;
                });
              });
          }
        }
        return Scaffold(
          body: ResponsiveWidgetFormLayout(
            buildPageContent: (context, color) => SafeArea(
              child:Container(
                    child: FormBuilder(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: Constants.SPACING),
                              DecoratedBox(
                                decoration: const BoxDecoration(),
                                child: SvgPicture.asset(
                                  "assets/images/security.svg",
                                  semanticsLabel: "Security",
                                  fit: BoxFit.contain,
                                  height: 150,
                                ),
                              ),
                              const SizedBox(height: Constants.SPACING),
                              const Text(
                                "Password Reset Verification",
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: Constants.SPACING),
                              Text(
                                "Kindly use the OTP Code sent to you\n to complete password reset",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: Constants.SPACING),
                              FormBuilderTextField(
                                name: "otp",
                                decoration: widgetSurfixIconDecoration(
                                  placeholder: "Enter OTP Verification code",
                                  prefixIcon: Icons.abc,
                                  label: "OTP verification code",
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              const SizedBox(height: Constants.SPACING),
                              const SizedBox(height: Constants.SPACING),
                              Button(
                                title: "Verify",
                                onPress: handleSubmit,
                                loading: _loading,
                              ),
                              const SizedBox(height: Constants.SPACING),
                              Consumer(
                                builder: (context, ref, child) {
                                  return LinkedRichText(
                                    linked: "",
                                    unlinked: "Back to login",
                                    onPress: () => ref.read(authStateProvider.notifier).logout(),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            ),
          ),
        );
      },
    );
  }
}
