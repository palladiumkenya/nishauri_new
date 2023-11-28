import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/display/RadioGroup.dart';
import 'package:nishauri/src/shared/form/AppFormTextInput.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  AppFormState _formState = AppFormState(values: {
    "otp": "",
    "mode": "email"
  }, validators: {
    "otp": [
      ValidationBuilder().required().maxLength(4).build(),
    ]
  },);
  bool _sent = false;
  bool _canSubmit = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer(
      builder: (context, ref, child) {
        void handleSubmit() {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _formState = _formState.copyWith(submitting: true);
            });
            final authStateNotifier = ref.read(authStateProvider.notifier);
            authStateNotifier.verify(_formState.values).then((value) {
              // Some code that runs when the verification is successful
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Verification successfully!,')),
              );
            }).catchError((onError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(onError.toString())),
              );
            }).whenComplete(() {
              // Set the submitting to false whether or not an exception is thrown
              setState(() {
                _formState = _formState.copyWith(submitting: false);
              });
            });
          }
        }

        final asyncUser = ref.watch(userProvider);
        return Scaffold(
          body: ResponsiveWidgetFormLayout(
            buildPageContent: (context, color) => SafeArea(
              child: asyncUser.when(
                  data: (user) => Container(
                        padding: const EdgeInsets.all(Constants.SPACING * 2),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius:
                              BorderRadius.circular(Constants.ROUNDNESS),
                        ),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
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
                                    "Account Verification",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  Text(
                                    "Kindly use the OTP Code sent to you\n to complete account verification.\n\nReceive code through:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiaryContainer,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  RadioGroup(
                                    items: [
                                      RadioGroupItem(
                                          value: "email",
                                          title: user.email,
                                          icon: Icons.email),
                                      RadioGroupItem(
                                          value: "phone",
                                          title: user.phoneNumber,
                                          icon: Icons.phone),
                                    ],
                                    value: _formState.values["mode"],
                                    onValueChanged: (value) {
                                      setState(() {
                                        _formState = _formState.copyWith(
                                            values: {
                                              ..._formState.values,
                                              "mode": value.toString()
                                            });
                                      });
                                    },
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  AppFormTextInput(
                                    name: "otp",
                                    formState: _formState,
                                    placeholder: "Enter OTP Verification code",
                                    prefixIcon: Icons.account_circle,
                                    readOnly: !(_formState
                                                .values["mode"].isNotEmpty ==
                                            true &&
                                        _sent),
                                    surfixIcon: Text(
                                      _sent ? "Resend Code" : "Get code",
                                    ),
                                    onsurfixIconPressed: () {
                                      setState(() {
                                        _sent = true;
                                        // _formState = _formState.copyWith(values: {..._formState.values,"otp": "1234"});
                                      });
                                    },
                                    label: "OTP verification ode",
                                    onChangeText: (name, value) {
                                      setState(() {
                                        _formState = _formState.copyWith(
                                            values: {
                                              ..._formState.values,
                                              name: value
                                            });
                                        _canSubmit = value.isNotEmpty;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  const SizedBox(height: Constants.SPACING),
                                  Button(
                                    title: "Verify",
                                    onPress: _canSubmit ? handleSubmit : null,
                                    loading: _formState.submitting,
                                  ),
                                  const SizedBox(
                                    height: Constants.SPACING,
                                  ),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      return LinkedRichText(
                                        linked: "",
                                        unlinked: "Back to login",
                                        onPress: () => ref
                                            .read(authStateProvider.notifier)
                                            .logout(),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  error: (error, _) => Center(child: Text(error.toString())),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      )),
            ),
          ),
        );
      },
    );
  }
}
