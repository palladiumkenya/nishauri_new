import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/form/AppFormTextInput.dart';
import 'package:nishauri/src/shared/form/RiverpodForm.dart';
import 'package:nishauri/src/shared/form/RiverpodFormField.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/shared/states/AppFormStateNotifier.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:form_validator/form_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  AppFormState _formState = AppFormState(values: {
    "username": "",
    "password": "",
  }, validators: {
    "username": [ValidationBuilder().required().build()],
    "password": [ValidationBuilder().required().build()],
  });

  @override
  Widget build(BuildContext context) {
    void handleFormFieldChange(String name, String value) {
      setState(() {
        _formState =
            _formState.copyWith(values: {..._formState.values, name: value});
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (BuildContext context, Color? color) => SafeArea(
            child: Form(
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
                children: [
                  const SizedBox(height: Constants.SPACING),
                  DecoratedBox(
                    decoration: const BoxDecoration(),
                    child: SvgPicture.asset(
                      "assets/images/doctors.svg",
                      semanticsLabel: "Doctors",
                      fit: BoxFit.contain,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: Constants.SPACING),
                  AppFormTextInput(
                    name: "username",
                    onChangeText: handleFormFieldChange,
                    formState: _formState,
                    prefixIcon: Icons.account_circle,
                    label: "Username",
                    placeholder: "e.g john",
                  ),
                  const SizedBox(height: Constants.SPACING),
                  AppFormTextInput(
                    name: "password",
                    onChangeText: handleFormFieldChange,
                    formState: _formState,
                    prefixIcon: Icons.lock,
                    label: "Password",
                    password: true,
                    placeholder: "********",
                  ),
                  const SizedBox(height: Constants.SPACING * 2),
                  LinkedRichText(
                    linked: "Don't have account?  ",
                    unlinked: 'Register   ',
                    onPress: () => context.goNamed(RouteNames.REGISTER_SCREEN),
                  ),
                  const SizedBox(height: Constants.SPACING),
                  Consumer(
                    builder: (context, ref, child) {
                      return Button(
                        title: "LOGIN",
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snack-bar. In the real world,
                            // you'd often call a server or save the information in a database.
                            setState(() {
                              _formState =
                                  _formState.copyWith(submitting: true);
                            });
                            ref
                                .read(authStateProvider.notifier)
                                .login(_formState.values)
                                .then((value) {
                              setState(() {
                                _formState =
                                    _formState.copyWith(submitting: false);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Login successfully!,')),
                              );
                            }).catchError((error) {
                              setState(() {
                                _formState =
                                    _formState.copyWith(submitting: false);
                              });
                              switch (error) {
                                case ValidationException e:
                                  setState(() {
                                    _formState = _formState.copyWith(
                                        errors: Map.castFrom(e.errors));
                                  });
                                  break;
                                default:
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(
                                  //   SnackBar(
                                  //       content: Text(error.toString())),
                                  // );
                                  throw error;
                              }
                            });
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: Constants.SPACING,
                  ),
                  LinkedRichText(
                    linked: "Forgot password ? ",
                    unlinked: "Reset",
                    onPress: () =>
                        context.goNamed(RouteNames.RESET_PASSWORD_SCREEN),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
