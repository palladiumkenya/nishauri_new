import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/presentation/widgets/ResponsiveWidget.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        void handleSubmit() async {
          if (_formKey.currentState!.validate()) {
            // If the form is valid, display a snack-bar. In the real world,
            // you'd often call a server or save the information in a database.
            ref.read(authProvider.notifier).login(username.text, password.text);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successfully!,')),
            );
            final credentials = {
              "username": username.text,
              "password": password.text
            };
            // context.go('/');
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Sign in"),
            leading: IconButton(
              onPressed: () => context.go("/"),
              icon: const Icon(Icons.chevron_left),
            ),
          ),
          body: ResponsiveWidget(
            buildPageContent: (BuildContext context, Color? color) => SafeArea(
              child: Container(
                padding: const EdgeInsets.all(Constants.SPACING * 3),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
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
                          controler: username,
                          placeholder: "Enter username or email",
                          prefixIcon: Icons.account_circle,
                          label: "Username",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Constants.SPACING),
                        FormInputTextField(
                          controler: password,
                          placeholder: "********",
                          prefixIcon: Icons.lock,
                          label: "Password",
                          password: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        LinkedRichText(
                          linked: "Don't have account?  ",
                          unlinked: 'Register   ',
                          onPress: () => context.go(RouteNames.REGISTER_SCREEN),
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
                              context.go(RouteNames.RESET_PASSWORD_SCREEN),
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
