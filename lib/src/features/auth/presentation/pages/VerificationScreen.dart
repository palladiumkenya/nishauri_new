import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _loading = false;
  bool _requestLoading = false;
  bool _sent = false;
  int _countdownSeconds = 60;
  Timer? _countdownTimer;

  void _startCountdownTimer() {
    // const oneMinute = Duration(minutes: 1);
    _countdownSeconds = 60;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
        } else {
          // If the countdown is finished, cancel the timer
          _countdownTimer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    // Cancel the countdown timer when the widget is disposed
    _countdownTimer?.cancel();
    super.dispose();
  }

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
            final userStateNotifier = ref.read(userProvider.notifier);
            final authStateNotifier = ref.read(authStateProvider.notifier);
            userStateNotifier
                .verify(_formKey.currentState!.value)
                .then((value) {
              authStateNotifier.markProfileAsAccountVerified();
              authStateNotifier.markProfileAsUpdated();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(value)),
              );
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
                        child: FormBuilder(
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
                                    "Kindly use the OTP Code sent to you\n to complete account verification.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiaryContainer,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  FormBuilderRadioGroup(
                                    name: "mode",
                                    initialValue: "sms",
                                    decoration: const InputDecoration(
                                      label: Text(
                                          "Want to receive OTP code through?"),
                                    ),
                                    options: [
                                      // FormBuilderFieldOption(
                                      //   value: "email",
                                      //   child: ListTile(
                                      //     title: const Text('Email'),
                                      //     subtitle: Text(user.email ?? ''),
                                      //     trailing: const Icon(Icons.email),
                                      //   ),
                                      // ),
                                      // FormBuilderFieldOption(
                                      //   value: "watsapp",
                                      //   child: ListTile(
                                      //     title: const Text("WatsApp"),
                                      //     subtitle: Text(user.phoneNumber ?? ''),
                                      //     trailing: const Icon(Icons.chat_outlined),
                                      //   ),
                                      // ),
                                      FormBuilderFieldOption(
                                        value: "sms",
                                        child: ListTile(
                                          title: const Text("SMS"),
                                          subtitle:
                                              Text(user.phoneNumber ?? ''),
                                          trailing: const Icon(Icons.sms),
                                        ),
                                      ),
                                    ],
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  FormBuilderTextField(
                                    name: "otp",
                                    decoration: widgetSurfixIconDecoration(
                                      placeholder:
                                          "Enter OTP Verification code",
                                      prefixIcon: Icons.account_circle,
                                      surfixIcon: _requestLoading
                                          ? const CircularProgressIndicator()
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                color:
                                                    theme.colorScheme.primary,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  _sent
                                                      ? (_countdownSeconds > 0
                                                          ? "Resend Code ($_countdownSeconds)"
                                                          : "Resend Code")
                                                      : "Get code",
                                                  style: TextStyle(
                                                    backgroundColor: theme
                                                        .colorScheme.primary,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      onSurfixIconPressed: () {
                                        if (!_sent || _countdownSeconds <= 0) {
                                          // Start countdown timer if the code is not yet sent or timer is zero
                                          _startCountdownTimer();
                                          setState(() {
                                            _requestLoading = true;
                                          });
                                          ref
                                              .read(userProvider.notifier)
                                              .getOTPCode(_formKey.currentState
                                                  ?.instantValue["mode"])
                                              .then((value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(value),
                                              ),
                                            );
                                          }).catchError((err) {
                                            handleResponseError(
                                              context,
                                              _formKey.currentState!.fields,
                                              err,
                                              ref
                                                  .read(authStateProvider
                                                      .notifier)
                                                  .logout,
                                            );
                                          }).whenComplete(() {
                                            setState(() {
                                              _requestLoading = false;
                                              _sent = true;
                                            });
                                          });
                                        }
                                      },
                                      label: "OTP verification code",
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  const SizedBox(height: Constants.SPACING),
                                  Button(
                                    title: "Verify",
                                    onPress: handleSubmit,
                                    loading: _loading,
                                    backgroundColor: theme.colorScheme.primary,
                                    textColor: Colors.white,
                                  ),
                                  const SizedBox(height: Constants.SPACING),
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
