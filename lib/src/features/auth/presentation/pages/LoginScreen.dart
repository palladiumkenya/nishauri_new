import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/data/respositories/credential_storage_repository.dart';
import 'package:nishauri/src/features/auth/data/services/BiometricAuthService.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/features/user_preference/data/providers/settings_provider.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
import 'package:nishauri/src/shared/display/label_input_container.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<String> version() async {
  final packageInfo = await PackageInfo.fromPlatform();
  final version = packageInfo.version;
  return version;
}

Future<String> getFCM() async {
  final fcmToken = await LocalStorage.get("FCM_Token");
  debugPrint("Get FCM: $fcmToken");
  return fcmToken;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _appVersion = "Loading...";
  final _formKey = GlobalKey<FormBuilderState>();
  bool _hidePassword = true;
  bool _loading = false;
  final BiometricAuthService _biometricAuthService = BiometricAuthService();
  final CredentialStorageRepository _credentialStorageRepository =
      CredentialStorageRepository();

  void _togglePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadVersion();
    _initializeBiometricAuthService();
  }

  Future<void> _loadVersion() async {
    final appVersion = await version();
    setState(() {
      _appVersion = appVersion;
    });
  }

  bool canCheckBiometrics = false;

  Future<void> _initializeBiometricAuthService() async {
    var checkBiometrics = await _biometricAuthService.hasSavedBiometrics();
    setState(() {
      canCheckBiometrics = checkBiometrics;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
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
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (BuildContext context, Color? color) => SafeArea(
            child: FormBuilder(
          key: _formKey,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Constants.SPACING),
                  const DecoratedBox(
                    decoration: BoxDecoration(),
                    child: Logo(size: 100),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Hello, Welcome back 👋",
                    style: TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: Constants.SPACING),
                  LabelInputContainer(
                    label: "Phone Number",
                    child: FormBuilderTextField(
                      name: "user_name",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(10,
                            errorText: 'Phone number must be 10 digits long'),
                        FormBuilderValidators.maxLength(10,
                            errorText: 'Phone number must be 10 digits long'),
                        (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              !value.startsWith('0')) {
                            return 'Phone number must start with zero';
                          }
                          return null;
                        },
                      ]),
                      decoration: outLineInputDecoration(
                        // prefixIcon: Icons.account_circle,
                        // label: "Phone Number",
                        placeholder: "Enter your number",
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                  ),
                  const SizedBox(height: Constants.SPACING),
                  LabelInputContainer(
                    label: "Password",
                    child: FormBuilderTextField(
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      name: "password",
                      obscureText: _hidePassword,
                      decoration: outLineInputDecoration(
                          // prefixIcon: Icons.lock,
                          // label: "Password",
                          placeholder: "Enter your password",
                          onSurfixIconPressed: _togglePassword,
                          surfixIcon: _hidePassword
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                    ),
                  ),
                  const SizedBox(height: Constants.SPACING * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LinkedRichText(
                        unlinked: "Forgot password ? ",
                        linked: "",
                        onPress: () =>
                            context.goNamed(RouteNames.RESET_PASSWORD_SCREEN),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.SPACING),
                  Consumer(
                    builder: (context, ref, child) {
                      return Button(
                        title: "LOGIN",
                        loading: _loading,
                        backgroundColor: theme.colorScheme.primary,
                        textColor: Colors.white,
                        onPress: () async {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.saveAndValidate()) {
                            setState(() {
                              _loading = true;
                            });
                            final authNotifier =
                                ref.read(authStateProvider.notifier);
                            final settings =
                                ref.read(settingsNotifierProvider.notifier);
                            var version = {"app_version": _appVersion};
                            final fcmToken = await getFCM();
                            debugPrint(
                                "Login FCM token: ${fcmToken.toString()}");
                            var mergedData = {
                              ..._formKey.currentState!.value,
                              ...version
                            };
                            authNotifier.login(mergedData, null).then((_) {
                              //     Update user state
                              ref.read(userProvider.notifier).getUser();
                            }).then(
                              (_) {
                                settings.patchSettings(
                                  firstTimeInstallation: false,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login successful!'),
                                  ),
                                );
                              },
                            ).catchError((error) {
                              handleResponseError(
                                context,
                                _formKey.currentState!.fields,
                                error,
                                authNotifier.logout,
                              );
                            }).whenComplete(
                              () {
                                if (mounted) {
                                  setState(() {
                                    _loading = false;
                                  });
                                }
                              },
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: Constants.SPACING),
                  //  Biometric icon button
                  Consumer(
                    builder: (context, ref, child) {
                      return canCheckBiometrics
                          ? Button(
                              title: "Login with Biometrics",
                              backgroundColor: theme.colorScheme.primary,
                              textColor: Colors.white,
                              onPress: () async {
                                final canCheckBiometrics =
                                    await _biometricAuthService
                                        .hasSavedBiometrics();
                                if (canCheckBiometrics) {
                                  final isAuthenticated =
                                      await _biometricAuthService
                                          .authenticateWithBiometrics();
                                  if (isAuthenticated) {
                                    try {
                                      final credentials =
                                          await _credentialStorageRepository
                                              .fetchCredentials();
                                      debugPrint("Credentials: $credentials");
                                      final authNotifier =
                                          ref.read(authStateProvider.notifier);
                                      final settings = ref.read(
                                          settingsNotifierProvider.notifier);
                                      final phoneNumber =
                                          credentials['username'] ?? '';
                                      final password =
                                          credentials['password'] ?? '';

                                      var version = {
                                        "app_version": _appVersion
                                      };
                                      final fcmToken = getFCM();
                                      debugPrint("Login FCM token: $fcmToken");
                                      var biometricData = {
                                        "user_name": phoneNumber,
                                        "password": password,
                                        ...version
                                      };

                                      authNotifier
                                          .login(biometricData, 'biometric')
                                          .then((_) {
                                        //     Update user state
                                        ref
                                            .read(userProvider.notifier)
                                            .getUser();
                                      }).then(
                                        (_) {
                                          settings.patchSettings(
                                            firstTimeInstallation: false,
                                            isBiometricEnabled: true,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('Login successful!'),
                                            ),
                                          );
                                        },
                                      ).whenComplete(
                                        () async {
                                          if (mounted) {
                                            setState(() {
                                              _loading = false;
                                            });
                                          }
                                        },
                                      );
                                    } catch (error) {
                                      debugPrint(
                                          "Biometric login failed: $error");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Biometric login failed!'),
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "No user registered for Biometric authentication on this device"),
                                    ),
                                  );
                                }
                              },
                              surfixIcon: const Icon(Icons.fingerprint),
                            )
                          : SizedBox(height: Constants.SPACING);
                    },
                  ),

                  const SizedBox(
                    height: Constants.SPACING * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LinkedRichText(
                        linked: "Don't have account?  ",
                        unlinked: 'Register',
                        onPress: () =>
                            context.goNamed(RouteNames.REGISTER_SCREEN),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('App Version: $_appVersion',
                      style: theme.textTheme.titleSmall!
                      // .copyWith(color: Constants.labResultsColor),
                      ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
