import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/shared/display/label_input_container.dart';
import 'package:nishauri/src/shared/display/scafold_stack_body.dart';

import '../../../../shared/display/Logo.dart';
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
        body: ScaffoldStackedBody(
      body: Column(
        children: [
          AppBar(
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
          Expanded(
              child: FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Constants.SMALL_SPACING),
                    const DecoratedBox(
                      decoration: BoxDecoration(),
                      child: Logo(
                        size: 100,
                      ),
                    ),
                    const SizedBox(height: Constants.SMALL_SPACING),
                    const Text(
                      "Reset Password 🔒",
                      style: TextStyle(fontSize: 40),
                    ),
                    const SizedBox(height: Constants.SPACING * 3),
                    LabelInputContainer(
                      label: "Password",
                      child: FormBuilderTextField(
                        name: "new_password",
                        obscureText: hidePassword.value,
                        decoration: outLineInputDecoration(
                            placeholder: "Enter you password",

                            surfixIcon: hidePassword.value
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onSurfixIconPressed: () =>
                                hidePassword.value = !hidePassword.value),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.min(8),
                          FormBuilderValidators.minLength(8),
                        ]),
                      ),
                    ),
                    const SizedBox(height: Constants.SPACING),
                    LabelInputContainer(
                      label: "Confirm New Password",
                      child: FormBuilderTextField(
                        obscureText: hidePassword.value,
                        name: "confirm_password",
                        decoration: outLineInputDecoration(
                            placeholder: "Confirm your password",
                            surfixIcon: hidePassword.value
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
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
                    ),
                    const SizedBox(height: Constants.SPACING * 6),
                    Button(
                      title: "Reset Password",
                      backgroundColor: theme.colorScheme.primary,
                      textColor: Colors.white,
                      onPress: handleSubmit,
                    )
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    ));
  }
}
