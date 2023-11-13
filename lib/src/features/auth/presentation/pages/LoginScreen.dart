import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/form/RiverpodFormField.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/shared/states/AppFormStateNotifier.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:form_validator/form_validator.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<AppFormStateNotifier, AppFormState>(
        (ref) => AppFormStateNotifier(initialValues: {
              "username": "omosh",
              "password": "1234"
            }, validators: {
              'username': [ValidationBuilder().required().build()],
              "password": [ValidationBuilder().required().build()],
            }));

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  RiverpodFormField(
                    name: "username",
                    prefixIcon: Icons.account_circle,
                    label: "Username",
                    provider: loginFormProvider,
                    placeholder: "e.g john",
                  ),
                  const SizedBox(height: Constants.SPACING),
                  RiverpodFormField(
                    name: "password",
                    prefixIcon: Icons.lock,
                    label: "Password",
                    password: true,
                    provider: loginFormProvider,
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
                          final loginState = ref.watch(loginFormProvider);
                          ref.read(authStateProvider.notifier).login(
                              loginState.values["username"],
                              loginState.values["password"]);
                          debugPrint(
                              "*********************| ${loginState} |**********************");
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
        ),
      ),
    );
  }
}
