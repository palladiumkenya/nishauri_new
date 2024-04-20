import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/input/Button.dart';
import '../../../../shared/layouts/ResponsiveWidgetFormLayout.dart';
import '../../../../shared/styles/input_styles.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/routes.dart';
import '../../../user/data/providers/user_provider.dart';
import '../../data/providers/auth_provider.dart';

class VerifiedResetPassword extends HookConsumerWidget {
  final String username;

  const VerifiedResetPassword({super.key, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final hidePassword = useState(true);
    final loading = useState(false);
    final theme = Theme.of(context);

    void handleSubmit() async {
      if (_formKey.currentState!.saveAndValidate()) {
        loading.value = true;
        final passwordResetStateNotifier =
            ref.read(resetPasswordProvider.notifier);
        final authStateNotifier = ref.read(authStateProvider.notifier);

        // Form payload
        final payload = {
          "user_name": username,
          "new_password": _formKey.currentState!.value['new_password'],
        };

        passwordResetStateNotifier.changePassword(payload).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(value)),
          );
          context.goNamed(RouteNames.LOGIN_SCREEN);
        }).catchError((err) {
          handleResponseError(context, _formKey.currentState!.fields, err,
              authStateNotifier.logout);
        }).whenComplete(() {
          loading.value = false;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
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
            child: FormBuilder(
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
                        child: Image.asset(
                          "assets/images/reset_password.png",
                          // semanticsLabel: "Doctors",
                          fit: BoxFit.contain,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      const Text(
                        "Reset password",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      const SizedBox(height: Constants.SPACING),
                      FormBuilderTextField(
                        name: "new_password",
                        obscureText: hidePassword.value,
                        decoration: inputDecoration(
                            placeholder: "********",
                            prefixIcon: Icons.lock,
                            label: "Password",
                            surfixIcon: hidePassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onSurfixIconPressed: () =>
                                hidePassword.value = !hidePassword.value),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.min(8),
                          FormBuilderValidators.minLength(8),
                        ]),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      FormBuilderTextField(
                        obscureText: hidePassword.value,
                        name: "confirm_password",
                        decoration: inputDecoration(
                            placeholder: "********",
                            prefixIcon: Icons.lock,
                            label: "Confirm Password",
                            surfixIcon: hidePassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onSurfixIconPressed: () =>
                                hidePassword.value = !hidePassword.value),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.min(8),
                          FormBuilderValidators.minLength(8),
                          (value) =>
                              _formKey.currentState!.value["new_password"] !=
                                      value
                                  ? "Password didn't match"
                                  : null
                        ]),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      Button(
                        title: "Reset Password",
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
