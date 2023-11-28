import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/form/AppFormTextInput.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  AppFormState _formState = AppFormState(values: {
    "username": "omosh",
    "phoneNumber": "0793889658",
    "email": "omosh@gmail.com",
    "password": "1234",
    "confirmPassword": "1234"
  }, validators: {
    "username": [ValidationBuilder().required().build()],
    "phoneNumber": [ValidationBuilder().required().phone().build()],
    "email": [ValidationBuilder().required().email().build()],
    "password": [ValidationBuilder().required().build()],
    "confirmPassword": [ValidationBuilder().required().build()],
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    void handleFormFieldChange(String name, String value) {
      setState(() {
        _formState =
            _formState.copyWith(values: {..._formState.values, name: value});
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (context, color) => SafeArea(
          child: Container(
            padding: const EdgeInsets.all(Constants.SPACING * 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: Constants.SPACING),
                      DecoratedBox(
                        decoration: const BoxDecoration(),
                        child: Logo(),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      AppFormTextInput(
                        name: "username",
                        onChangeText: handleFormFieldChange,
                        formState: _formState,
                        placeholder: "Enter username or email",
                        prefixIcon: Icons.account_circle,
                        label: "Username",
                      ),
                      const SizedBox(height: Constants.SPACING),
                      AppFormTextInput(
                        name: "phoneNumber",
                        onChangeText: handleFormFieldChange,
                        formState: _formState,
                        placeholder: "e.g 0712345678",
                        prefixIcon: Icons.phone,
                        label: "Phone number",
                      ),
                      const SizedBox(height: Constants.SPACING),
                      AppFormTextInput(
                        name: "email",
                        onChangeText: handleFormFieldChange,
                        formState: _formState,
                        placeholder: "e.g abc@gmail.com",
                        prefixIcon: Icons.email,
                        label: "Email address",
                      ),
                      const SizedBox(height: Constants.SPACING),
                      AppFormTextInput(
                        name: "password",
                        onChangeText: handleFormFieldChange,
                        formState: _formState,
                        placeholder: "********",
                        prefixIcon: Icons.lock,
                        label: "Password",
                        password: true,
                      ),
                      const SizedBox(height: Constants.SPACING),
                      AppFormTextInput(
                        name: "confirmPassword",
                        onChangeText: handleFormFieldChange,
                        formState: _formState,
                        placeholder: "********",
                        prefixIcon: Icons.lock,
                        label: "Confirm Password",
                        password: true,
                      ),
                      const SizedBox(height: Constants.SPACING),
                      LinkedRichText(
                        linked: "Already have account? ",
                        unlinked: "Login",
                        onPress: () => context.goNamed(RouteNames.LOGIN_SCREEN),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      Consumer(
                        builder: (context, ref, child) {
                          final authState = ref.watch(authStateProvider);
                          return Button(
                            loading: _formState.submitting,
                            title: "Register",
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
                                    .register(_formState.values)
                                    .then((value) {
                                  setState(() {
                                    _formState =
                                        _formState.copyWith(submitting: false);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Registration successfull!,')),
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(error.toString())),
                                      );
                                  }
                                });
                              }
                            },
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
  }
}
