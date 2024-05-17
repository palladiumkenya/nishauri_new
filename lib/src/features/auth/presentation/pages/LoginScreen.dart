import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/CustomButton.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (BuildContext context, Color? color) => SafeArea(
            child: FormBuilder(
          key: _formKey,
          child: Container(
            // padding: const EdgeInsets.all(Constants.SPACING * 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Constants.SPACING),
                  const DecoratedBox(
                    decoration: BoxDecoration(),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Logo(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Hello, Welcome back 👋",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FormBuilderTextField(
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
                    decoration: inputDecoration(
                      prefixIcon: Icons.account_circle,
                      label: "Enter your number",
                      placeholder: "e.g 0700000000",
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: Constants.SPACING),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FormBuilderTextField(
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    name: "Password",
                    obscureText: _hidePassword,
                    decoration: inputDecoration(
                        prefixIcon: Icons.lock,
                        label: "Password",
                        placeholder: "********",
                        onSurfixIconPressed: _togglePassword,
                        surfixIcon: _hidePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LinkedRichText(
                        linked: "",
                        unlinked: "Forgot password ? ",
                        onPress: () =>
                            context.goNamed(RouteNames.RESET_PASSWORD_SCREEN),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.SPACING),
                  Consumer(
                    builder: (context, ref, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          title: "Login",
                          loading: _loading,
                          backgroundColor: const Color.fromRGBO(64, 87, 162, 1),
                          textColor: Colors.white,
                          titleStyle: const TextStyle(
                            fontWeight: FontWeight.w200,
                          ),
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
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: Constants.SPACING,
                  ),
                  const SizedBox(height: Constants.SPACING),
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
                  const SizedBox(
                    height: Constants.SPACING * 6,
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
