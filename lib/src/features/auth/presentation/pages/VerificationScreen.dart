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

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _loading = false;

  bool _sent = false;

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
            final authStateNotifier = ref.read(authStateProvider.notifier);
            authStateNotifier
                .verify(_formKey.currentState!.value)
                .then((value) {
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
                                    decoration: const InputDecoration(label: Text("Want to receive OTP code through?")),
                                    options: [
                                      FormBuilderFieldOption(
                                        value: "email",
                                        child: ListTile(
                                            title: Text(user.email),
                                            trailing: const Icon(Icons.email)),
                                      ),
                                      FormBuilderFieldOption(
                                        value: "phone",
                                        child: ListTile(
                                            title: Text(user.phoneNumber),
                                            trailing: const Icon(Icons.phone)),
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
                                      surfixIcon: Text(
                                        _sent ? "Resend Code" : "Get code",
                                      ),
                                      onSurfixIconPressed: () {
                                        setState(() {
                                          _sent = true;
                                          // _formState = _formState.copyWith(values: {..._formState.values,"otp": "1234"});
                                        });
                                      },
                                      label: "OTP verification ode",
                                    ),
                                    // readOnly: !(_formKey.currentState!.value["mode"].isNotEmpty == true && _sent),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  const SizedBox(height: Constants.SPACING),
                                  Button(
                                    title: "Verify",
                                    onPress:handleSubmit,
                                    loading: _loading,
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
