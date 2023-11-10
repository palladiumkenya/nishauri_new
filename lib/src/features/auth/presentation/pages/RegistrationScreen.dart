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

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  var username = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var phoneNumber = TextEditingController();
  var email = TextEditingController();

  @override
  void dispose() {
    confirmPassword.dispose();
    phoneNumber.dispose();
    email.dispose();
    username.dispose();
    password.dispose();

    super.dispose();
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snack-bar. In the real world,
      // you'd often call a server or save the information in a database.
      ref.read(authStateProvider.notifier).register(username.text, phoneNumber.text,
          email.text, password.text, confirmPassword.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successfully!,')),
      );
      final credentials = {
        "username": username.text,
        "password": password.text
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
                        child: SvgPicture.asset(
                          "assets/images/patient.svg",
                          semanticsLabel: "Doctors",
                          fit: BoxFit.contain,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      const Text(
                        "Sign Up",
                        style:
                            TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                        controler: phoneNumber,
                        placeholder: "e.g 0712345678",
                        prefixIcon: Icons.phone,
                        label: "Phone number",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: Constants.SPACING),
                      FormInputTextField(
                        controler: email,
                        placeholder: "e.g abc@gmail.com",
                        prefixIcon: Icons.email,
                        label: "Email address",
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
                      const SizedBox(height: Constants.SPACING),
                      FormInputTextField(
                        controler: confirmPassword,
                        placeholder: "********",
                        prefixIcon: Icons.lock,
                        label: "Confirm Password",
                        password: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: Constants.SPACING),
                      LinkedRichText(
                        linked: "Already have account? ",
                        unlinked: "Login",
                        onPress: () => context.goNamed(RouteNames.LOGIN_SCREEN),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      Button(
                        title: "Register",
                        onPress: handleSubmit,
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
