import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
import 'package:nishauri/src/shared/display/label_input_container.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _hidePassword = true;
  bool _loading = false;

  void _togglePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
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
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (BuildContext context, Color? color) => SafeArea(
            child: FormBuilder(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(Constants.SPACING * 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Constants.SPACING),
                  const DecoratedBox(
                    decoration: BoxDecoration(),
                    child: Logo(size: 100),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Hello, Welcome back 👋",
                    style: TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: Constants.SPACING),
                  LabelInputContainer(
                    label: "Phone Number",
                    child: FormBuilderTextField(
                      name: "user_name",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
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
                      decoration: outLineInputDecoration(
                        // prefixIcon: Icons.account_circle,
                        // label: "Phone Number",
                        placeholder: "Enter your number",
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                  ),
                  const SizedBox(height: Constants.SPACING),
                  LabelInputContainer(
                    label: "Password",
                    child: FormBuilderTextField(
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      name: "password",
                      obscureText: _hidePassword,
                      decoration: outLineInputDecoration(
                          // prefixIcon: Icons.lock,
                          // label: "Password",
                          placeholder: "Enter your password",
                          onSurfixIconPressed: _togglePassword,
                          surfixIcon: _hidePassword
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                    ),
                  ),
                  const SizedBox(height: Constants.SPACING * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LinkedRichText(
                        unlinked: "Forgot password ? ",
                        linked: "",
                        onPress: () =>
                            context.goNamed(RouteNames.RESET_PASSWORD_SCREEN),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.SPACING),
                  Consumer(
                    builder: (context, ref, child) {
                      return Button(
                        title: "LOGIN",
                        loading: _loading,
                        backgroundColor: theme.colorScheme.primary,
                        textColor: Colors.white,
                        onPress: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.saveAndValidate()) {
                            setState(() {
                              _loading = true;
                            });
                            final authNotifier =
                                ref.read(authStateProvider.notifier);
                            authNotifier
                                .login(_formKey.currentState!.value)
                                .then((_) {
                              //     Update user state
                              ref.read(userProvider.notifier).getUser();
                            }).then(
                              (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login successful!'),
                                  ),
                                );
                              },
                            ).catchError((error) {
                              handleResponseError(
                                context,
                                _formKey.currentState!.fields,
                                error,
                                authNotifier.logout,
                              );
                            }).whenComplete(
                              () {
                                if (mounted) {
                                  setState(() {
                                    _loading = false;
                                  });
                                }
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: Constants.SPACING * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LinkedRichText(
                        linked: "Don't have account?  ",
                        unlinked: 'Register   ',
                        onPress: () =>
                            context.goNamed(RouteNames.REGISTER_SCREEN),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
