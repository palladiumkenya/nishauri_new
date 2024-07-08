import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/hooks/uset_timer.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/display/label_input_container.dart';
import 'package:nishauri/src/shared/display/scafold_stack_body.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:pinput/pinput.dart';

import '../../../../shared/display/Logo.dart';

class VerificationScreen extends HookConsumerWidget {
  final String username;

  const VerificationScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final requestVerificationStateNotifier = ref.read(userProvider.notifier);
    final authStateNotifier = ref.read(authStateProvider.notifier);
    final timer = useTime(const Duration(seconds: 60));
    final loading = useState(false);

    final otpController = useTextEditingController();

    void handleSubmit() {
          if (formKey.currentState!.saveAndValidate()) {
              loading.value = true;
            final userStateNotifier = ref.read(userProvider.notifier);
            userStateNotifier.verify({
              "otp": otpController.text,
              "mode": "sms"
            }).then((value) {
              authStateNotifier.markProfileAsAccountVerified();
              authStateNotifier.markProfileAsUpdated();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(value)),
              );
            }).catchError((err) {
              handleResponseError(context, formKey.currentState!.fields, err,
                  authStateNotifier.logout);
            }).whenComplete(() {
              loading.value = false;
            });
          }
        }
    var theme = Theme.of(context);

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
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                              "Verify Account ✅",
                              style: TextStyle(fontSize: 40),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            RichText(
                              text: TextSpan(
                                text: "Code has been sent to ",
                                style: TextStyle(color: theme.colorScheme.onSurface),
                                children: [
                                  TextSpan(
                                    text: username,
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "\n\nEnter the code to verify account",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Constants.SPACING * 3),
                            LabelInputContainer(
                              label: "Enter Code",
                              child: Pinput(
                                length: 5,
                                controller: otpController,
                                defaultPinTheme: PinTheme(
                                  width: 56,
                                  height: 56,
                                  textStyle: const TextStyle(
                                    fontSize: 22,
                                    color: Color.fromRGBO(30, 60, 87, 1),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(19),
                                    border: Border.all(color: Constants.programsColor),
                                  ),
                                ),

                                androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                                cursor: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 9),
                                      width: 22,
                                      height: 1,
                                      color: Constants.programsColor,
                                    )
                                  ],
                                ),
                                // onChanged: (value) {
                                //   otp.value = value;
                                // },
                                // onCompleted: (value) {
                                //   otp.value = value;
                                // },
                                validator: (value) {
                                  if (value == null || value.length != 5) {
                                    return 'Check the code should be 5 digits';
                                  }
                                  return null;
                                },
                                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                              ),
                            ),
                            const SizedBox(height: Constants.SPACING * 6),
                            Button(
                              title: "Verify Account",
                              backgroundColor: theme.colorScheme.primary,
                              textColor: Colors.white,
                              onPress: handleSubmit,
                              loading: loading.value,
                            ),
                            const SizedBox(height: Constants.SPACING * 2),
                            if(timer.remainingTime == 0)
                              LinkedRichText(
                                  linked: "Don't receive code?",
                                  unlinked: "Resend code",
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  onPress: () {
                                    timer.reset();
                                    loading.value =true;
                                    requestVerificationStateNotifier
                                        .getOTPCode("sms").then(
                                          (value) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(value)),
                                        );
                                      },
                                    ).whenComplete(() {
                                      loading.value = false;
                                    });
                                  }),
                            const SizedBox(height: Constants.SPACING),
                            LinkedRichText(linked: "Send code in ", unlinked: "00:${timer.remainingTime}", mainAxisAlignment: MainAxisAlignment.start),
                            const SizedBox(height: Constants.SPACING),
                            // Consumer(
                            //   builder: (context, ref, child) {
                            //     return LinkedRichText(
                            //       linked: "",
                            //       unlinked: "Back to login",
                            //       onPress: () =>
                            //           ref.read(authStateProvider.notifier).logout(),
                            //     );
                            //   },
                            // )
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



// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
// import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
// import 'package:nishauri/src/shared/display/LinkedRichText.dart';
// import 'package:nishauri/src/shared/input/Button.dart';
// import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
// import 'package:nishauri/src/shared/styles/input_styles.dart';
// import 'package:nishauri/src/utils/constants.dart';
// import 'package:nishauri/src/utils/helpers.dart';
// import 'package:pinput/pinput.dart';
//
// class VerificationScreen extends StatefulWidget {
//   const VerificationScreen({super.key});
//
//   @override
//   State<VerificationScreen> createState() => _VerificationScreenState();
// }
//
// class _VerificationScreenState extends State<VerificationScreen> {
//   final _formKey = GlobalKey<FormBuilderState>();
//   bool _loading = false;
//   bool _requestLoading = false;
//   bool _sent = false;
//   int _countdownSeconds = 60;
//   Timer? _countdownTimer;
//   String otp = "";
//
//   void _startCountdownTimer() {
//     _countdownSeconds = 60;
//     _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_countdownSeconds > 0) {
//           _countdownSeconds--;
//         } else {
//           _countdownTimer?.cancel();
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _countdownTimer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Consumer(
//       builder: (context, ref, child) {
//         void handleSubmit() {
//           if (_formKey.currentState!.saveAndValidate()) {
//             setState(() {
//               _loading = true;
//             });
//             final userStateNotifier = ref.read(userProvider.notifier);
//             final authStateNotifier = ref.read(authStateProvider.notifier);
//             userStateNotifier.verify({
//               "otp": otp,
//               "mode": _formKey.currentState!.value['mode']
//             }).then((value) {
//               authStateNotifier.markProfileAsAccountVerified();
//               authStateNotifier.markProfileAsUpdated();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(value)),
//               );
//             }).catchError((err) {
//               handleResponseError(context, _formKey.currentState!.fields, err,
//                   authStateNotifier.logout);
//             }).whenComplete(() {
//               setState(() {
//                 _loading = false;
//               });
//             });
//           }
//         }
//
//         final asyncUser = ref.watch(userProvider);
//         return Scaffold(
//           body: ResponsiveWidgetFormLayout(
//             buildPageContent: (context, color) => SafeArea(
//               child: asyncUser.when(
//                   data: (user) => Container(
//                     padding: const EdgeInsets.all(Constants.SPACING * 2),
//                     decoration: BoxDecoration(
//                       color: color,
//                       borderRadius:
//                       BorderRadius.circular(Constants.ROUNDNESS),
//                     ),
//                     child: FormBuilder(
//                       key: _formKey,
//                       child: SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 20),
//                           child: Column(
//                             children: [
//                               const SizedBox(height: Constants.SPACING),
//                               DecoratedBox(
//                                 decoration: const BoxDecoration(),
//                                 child: SvgPicture.asset(
//                                   "assets/images/security.svg",
//                                   semanticsLabel: "Security",
//                                   fit: BoxFit.contain,
//                                   height: 150,
//                                 ),
//                               ),
//                               const SizedBox(height: Constants.SPACING),
//                               const Text(
//                                 "Account Verification",
//                                 style: TextStyle(
//                                     fontSize: 30,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               const SizedBox(height: Constants.SPACING),
//                               Text(
//                                 "Kindly use the OTP Code sent to you\n to complete account verification.",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .onTertiaryContainer,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(height: Constants.SPACING),
//                               FormBuilderRadioGroup(
//                                 name: "mode",
//                                 initialValue: "sms",
//                                 decoration: const InputDecoration(
//                                   label: Text(
//                                       "Want to receive OTP code through?"),
//                                 ),
//                                 options: [
//                                   FormBuilderFieldOption(
//                                     value: "sms",
//                                     child: ListTile(
//                                       title: const Text("SMS"),
//                                       subtitle:
//                                       Text(user.phoneNumber ?? ''),
//                                       trailing: const Icon(Icons.sms),
//                                     ),
//                                   ),
//                                 ],
//                                 validator: FormBuilderValidators.compose([
//                                   FormBuilderValidators.required(),
//                                 ]),
//                               ),
//
//
//
//
//
//                               const SizedBox(width: 10),
//                               TextButton(
//                                 onPressed: _requestLoading
//                                     ? null
//                                     : () {
//                                   if (!_sent || _countdownSeconds <= 0) {
//                                     _startCountdownTimer();
//                                     setState(() {
//                                       _requestLoading = true;
//                                     });
//                                     ref
//                                         .read(userProvider.notifier)
//                                         .getOTPCode(_formKey.currentState
//                                         ?.instantValue["mode"])
//                                         .then((value) {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         SnackBar(
//                                           content: Text(value),
//                                         ),
//                                       );
//                                     }).catchError((err) {
//                                       handleResponseError(
//                                         context,
//                                         _formKey.currentState!.fields,
//                                         err,
//                                         ref
//                                             .read(authStateProvider
//                                             .notifier)
//                                             .logout,
//                                       );
//                                     }).whenComplete(() {
//                                       setState(() {
//                                         _requestLoading = false;
//                                         _sent = true;
//                                       });
//                                     });
//                                   }
//                                 },
//                                 child: _requestLoading
//                                     ? const CircularProgressIndicator()
//                                     : Text(
//                                   _sent
//                                       ? (_countdownSeconds > 0
//                                       ? "Resend Code ($_countdownSeconds)"
//                                       : "Resend Code")
//                                       : "Get code",
//                                 ),
//                               ),
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//                               const SizedBox(height: Constants.SPACING),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Pinput(
//                                       length: 5,
//                                       defaultPinTheme: PinTheme(
//                                         width: 56,
//                                         height: 56,
//                                         textStyle: const TextStyle(
//                                           fontSize: 22,
//                                           color: Color.fromRGBO(30, 60, 87, 1),
//                                         ),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(19),
//                                           border: Border.all(color: Constants.programsColor),
//                                         ),
//                                       ),
//                                       androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
//                                       cursor: Column(
//                                         mainAxisAlignment: MainAxisAlignment.end,
//                                         children: [
//                                           Container(
//                                             margin: const EdgeInsets.only(bottom: 9),
//                                             width: 22,
//                                             height: 1,
//                                             color: Constants.programsColor,
//                                           ),
//                                         ],
//                                       ),
//                                       onChanged: (value) {
//                                         otp = value;
//                                       },
//                                       onCompleted: (value) {
//                                         otp = value;
//                                       },
//                                       validator: (value) {
//                                         if (value == null || value.length != 5) {
//                                           return 'Please enter a valid 5-digit OTP';
//                                         }
//                                         return null;
//                                       },
//                                       pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                                     ),
//                                   ),
//                                   // const SizedBox(width: 10),
//                                   // TextButton(
//                                   //   onPressed: _requestLoading
//                                   //       ? null
//                                   //       : () {
//                                   //     if (!_sent || _countdownSeconds <= 0) {
//                                   //       _startCountdownTimer();
//                                   //       setState(() {
//                                   //         _requestLoading = true;
//                                   //       });
//                                   //       ref
//                                   //           .read(userProvider.notifier)
//                                   //           .getOTPCode(_formKey.currentState
//                                   //           ?.instantValue["mode"])
//                                   //           .then((value) {
//                                   //         ScaffoldMessenger.of(context)
//                                   //             .showSnackBar(
//                                   //           SnackBar(
//                                   //             content: Text(value),
//                                   //           ),
//                                   //         );
//                                   //       }).catchError((err) {
//                                   //         handleResponseError(
//                                   //           context,
//                                   //           _formKey.currentState!.fields,
//                                   //           err,
//                                   //           ref
//                                   //               .read(authStateProvider
//                                   //               .notifier)
//                                   //               .logout,
//                                   //         );
//                                   //       }).whenComplete(() {
//                                   //         setState(() {
//                                   //           _requestLoading = false;
//                                   //           _sent = true;
//                                   //         });
//                                   //       });
//                                   //     }
//                                   //   },
//                                   //   child: _requestLoading
//                                   //       ? const CircularProgressIndicator()
//                                   //       : Text(
//                                   //     _sent
//                                   //         ? (_countdownSeconds > 0
//                                   //         ? "Resend Code ($_countdownSeconds)"
//                                   //         : "Resend Code")
//                                   //         : "Get code",
//                                   //   ),
//                                   // ),
//                                 ],
//                               ),
//                               const SizedBox(height: Constants.SPACING),
//                               Button(
//                                 title: "Verify",
//                                 onPress: handleSubmit,
//                                 loading: _loading,
//                               ),
//                               const SizedBox(height: Constants.SPACING),
//                               Consumer(
//                                 builder: (context, ref, child) {
//                                   return LinkedRichText(
//                                     linked: "",
//                                     unlinked: "Back to login",
//                                     onPress: () => ref
//                                         .read(authStateProvider.notifier)
//                                         .logout(),
//                                   );
//                                 },
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   error: (error, _) => Center(child: Text(error.toString())),
//                   loading: () => const Center(
//                     child: CircularProgressIndicator(),
//                   )),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }