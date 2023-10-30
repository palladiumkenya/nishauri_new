import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/presentation/widgets/ResponsiveWidget.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
  var currentPassword = TextEditingController();

  @override
  void dispose() {
    confirmPassword.dispose();
    currentPassword.dispose();
    newPassword.dispose();

    super.dispose();
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snack-bar. In the real world,
      // you'd often call a server or save the information in a database.

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully!,')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: ResponsiveWidget(
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
                          "assets/images/security.svg",
                          semanticsLabel: "Doctors",
                          fit: BoxFit.contain,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      const Text(
                        "Change password",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      FormInputTextField(
                        controler: currentPassword,
                        placeholder: "********",
                        prefixIcon: Icons.lock,
                        label: "Current Password",
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
                        controler: newPassword,
                        placeholder: "********",
                        prefixIcon: Icons.lock,
                        label: "New Password",
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
                        onPress: () => context.go(RouteNames.LOGIN_SCREEN),
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
