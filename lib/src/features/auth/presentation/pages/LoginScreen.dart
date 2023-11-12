import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
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
  String? _username;
  String? _password;

  @override
  Widget build(BuildContext context) {
    final buildContext = context;
    return Consumer(
      builder: (context, ref, child) {
        void handleSubmit() async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _formKey.currentState!.save();
            });
            try {
              await ref
                  .read(authStateProvider.notifier)
                  .login(_username!, _password!);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login successfully!,')),
              );
            } on Exception catch (e) {
              // Handle errors from the controller
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
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
              child: Container(
                padding: const EdgeInsets.all(Constants.SPACING * 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
                ),
                child: Form(
                  key: _formKey,
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
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        FormInputTextField(
                          onSaved: (username) => _username = username,
                          placeholder: "Enter username or email",
                          prefixIcon: Icons.account_circle,
                          label: "Username",
                          validator: ValidationBuilder().required().build(),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        FormInputTextField(
                            onSaved: (password) => _password = password,
                            placeholder: "********",
                            prefixIcon: Icons.lock,
                            label: "Password",
                            password: true,
                            validator: ValidationBuilder().required().build()),
                        const SizedBox(height: 20),
                        LinkedRichText(
                          linked: "Don't have account?  ",
                          unlinked: 'Register   ',
                          onPress: () =>
                              context.goNamed(RouteNames.REGISTER_SCREEN),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        Button(
                          title: "LOGIN",
                          onPress: handleSubmit,
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
              ),
            ),
          ),
        );
      },
    );
  }
}
