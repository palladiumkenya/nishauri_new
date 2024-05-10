import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

import '../../../../utils/routes.dart';

class ResetPasswordVerificationScreen extends HookConsumerWidget {
  final String username;
  const ResetPasswordVerificationScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final loading = useState(false);
    void handleSubmit() {
      if (formKey.currentState!.saveAndValidate()) {
        loading.value = true;
        final passwordResetStateNotifier =
            ref.read(resetPasswordProvider.notifier);
        final authStateNotifier = ref.read(authStateProvider.notifier);

        // Form payload
        final payload = {
          "user_name": username,
          "otp": formKey.currentState!.value['otp'],
        };

        passwordResetStateNotifier.verifyResetPassword(payload).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(value)),
          );
          context.goNamed(RouteNames.VERIFIED_RESET_PASSWORD_SCREEN,
              extra: username);
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPassword(user_name: widget.user_name)));
        }).catchError((err) {
          handleResponseError(context, formKey.currentState!.fields, err,
              authStateNotifier.logout);
        }).whenComplete(() {
          loading.value = false;
        });
      }
    }

    return Scaffold(
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (context, color) => SafeArea(
          child: FormBuilder(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    const SizedBox(height: Constants.SPACING),
                    DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: SvgPicture.asset(
                        "assets/images/security.svg",
                        semanticsLabel: "Security",
                        fit: BoxFit.contain,
                        height: 150,
                      ),
                    ),
                    const SizedBox(height: Constants.SPACING),
                    const Text(
                      "Password Reset Verification",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Constants.SPACING),
                    Text(
                      "Kindly use the OTP Code sent to you\n to complete password reset",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Constants.SPACING),
                    FormBuilderTextField(
                      name: "otp",
                      decoration: widgetSurfixIconDecoration(
                        placeholder: "Enter OTP Verification code",
                        prefixIcon: Icons.abc,
                        label: "OTP verification code",
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: Constants.SPACING),
                    const SizedBox(height: Constants.SPACING),
                    Button(
                      title: "Verify",
                      onPress: handleSubmit,
                      loading: loading.value,
                    ),
                    const SizedBox(height: Constants.SPACING),
                    Consumer(
                      builder: (context, ref, child) {
                        return LinkedRichText(
                          linked: "",
                          unlinked: "Back to login",
                          onPress: () =>
                              ref.read(authStateProvider.notifier).logout(),
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
    );
  }
}
