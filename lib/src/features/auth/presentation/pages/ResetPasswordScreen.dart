import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/presentation/pages/VerifyResetPasswordScreen.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  // var username = TextEditingController();
  bool _loading = false;
  // var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        void handleSubmit() async {
          if (_formKey.currentState != null && _formKey.currentState!.saveAndValidate()) {
            final formState = _formKey.currentState!.value;
            setState(() {
              _loading = true;
            });
            final authStateNotifier = ref.read(authStateProvider.notifier);
            final userStateNotifier = ref.read(resetPasswordProvider.notifier);
            userStateNotifier.resetPassword(formState).then((value) {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(value)),
              );
              context.goNamed(RouteNames.VERIFY_RESET_PASSWORD_SCREEN,  extra:formState['user_name'] );
            }).catchError((err) {
              handleResponseError(context, _formKey.currentState!.fields, err, authStateNotifier.logout);
            }).whenComplete(() {
              setState(() {
                _loading = false;
              });
            });

          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Forgot password"),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: Constants.SPACING),
                          DecoratedBox(
                            decoration: const BoxDecoration(),
                            child: SvgPicture.asset(
                              "assets/images/forgot_password.svg",
                              semanticsLabel: "Doctors",
                              fit: BoxFit.contain,
                              height: 150,
                            ),
                          ),
                          const SizedBox(height: Constants.SPACING),
                          const Text(
                            "Forgot Password",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Kindly provide your phone number!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onTertiaryContainer,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: Constants.SPACING),
                          FormBuilderTextField(
                            name: "user_name",
                            decoration: inputDecoration(
                              placeholder: "e.g 0712345678",
                              prefixIcon: Icons.phone,
                              label: "Phone number",
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(10, errorText: 'Phone number must be 10 digits long'),
                              FormBuilderValidators.maxLength(10, errorText: 'Phone number must be 10 digits long'),
                                  (value) {
                                if (value != null && value.isNotEmpty && !value.startsWith('0')) {
                                  return 'Phone number must start with zero';
                                }
                                return null;
                              },
                            ]),
                          ),
                          const SizedBox(height: Constants.SPACING),
                          const SizedBox(height: Constants.SPACING),
                          Button(
                            title: "Submit",
                            onPress: handleSubmit,
                            loading: _loading,
                          ),
                          const SizedBox(
                            height: Constants.SPACING,
                          ),
                          LinkedRichText(
                            linked: "",
                            unlinked: "Back to login",
                            onPress: () => context.goNamed(RouteNames.LOGIN_SCREEN),
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
      },
    );
  }
}
