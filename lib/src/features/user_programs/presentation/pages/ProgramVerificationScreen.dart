// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
// import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
// import 'package:nishauri/src/hooks/uset_timer.dart';
// import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
// import 'package:nishauri/src/shared/display/LinkedRichText.dart';
// import 'package:nishauri/src/shared/display/label_input_container.dart';
// import 'package:nishauri/src/shared/display/scafold_stack_body.dart';
// import 'package:nishauri/src/shared/input/Button.dart';
// import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
// import 'package:nishauri/src/shared/styles/input_styles.dart';
// import 'package:nishauri/src/utils/constants.dart';
// import 'package:nishauri/src/utils/helpers.dart';
// import 'package:pinput/pinput.dart';
//
// import '../../../../shared/display/Logo.dart';
// import '../../../../utils/routes.dart';
//
// class ProgramVerificationScreen extends HookConsumerWidget {
//
//   const ProgramVerificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
//     final passwordResetStateNotifier = ref.read(resetPasswordProvider.notifier);
//     final authStateNotifier = ref.read(authStateProvider.notifier);
//     final timer = useTime(const Duration(seconds: 60));
//     final loading = useState(false);
//     void handleSubmit() {
//       if (formKey.currentState!.saveAndValidate()) {
//         loading.value = true;
//
//         // Form payload
//         final payload = {
//           "user_name": username,
//           "otp": formKey.currentState!.value['otp'],
//         };
//
//         passwordResetStateNotifier.verifyResetPassword(payload).then((value) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(value)),
//           );
//           context.goNamed(RouteNames.VERIFIED_RESET_PASSWORD_SCREEN,
//               extra: username);
//           // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPassword(user_name: widget.user_name)));
//         }).catchError((err) {
//           handleResponseError(context, formKey.currentState!.fields, err,
//               authStateNotifier.logout);
//         }).whenComplete(() {
//           loading.value = false;
//         });
//       }
//     }
//
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//         fontSize: 22,
//         color: Color.fromRGBO(30, 60, 87, 1),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(19),
//         border: Border.all(color: Constants.programsColor),
//       ),
//     );
//
//     String? otp;
//
//     var theme = Theme.of(context);
//
//     return Scaffold(
//         body: ScaffoldStackedBody(
//           body: Column(
//             children: [
//               // AppBar(
//               //   // title: const Text("Sign Up"),
//               //   backgroundColor: Colors.transparent,
//               //   leading: IconButton(
//               //     onPressed: () => context.pop(),
//               //     icon: SvgPicture.asset(
//               //       "assets/images/reply-dark.svg",
//               //       semanticsLabel: "Doctors",
//               //       fit: BoxFit.contain,
//               //       width: 40,
//               //       height: 40,
//               //     ),
//               //   ),
//               // ),
//               const CustomAppBar(
//                   title: "Verify Your Program",
//                   icon: Icons.add_task_sharp,
//                   subTitle: "Use the code provided to verify program",
//                   color:Constants.programsColor),
//               Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     RichText(
//                       text: TextSpan(
//                         text: 'A code has been sent to ',
//                         style: const TextStyle(
//                           color: Constants.programsColor,
//                           fontSize: 15,
//                         ),
//                         children: [
//                           TextSpan(
//                             text: responseMessage,
//                             style: TextStyle(
//                               color: theme.primaryColorDark,
//                               fontWeight: FontWeight.w300,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: Constants.SPACING),
//                     Pinput(
//                       length: 5,
//                       defaultPinTheme: defaultPinTheme,
//                       cursor: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 9),
//                             width: 22,
//                             height: 1,
//                             color: Constants.programsColor,
//                           ),
//                         ],
//                       ),
//                       onChanged: (value) {
//                         otp = value;
//                       },
//                       onCompleted: (value) {
//                         otp = value;
//                       },
//                       validator: (value) {
//                         if (value == null || value.length != 5) {
//                           return 'Please enter a valid 5-digit OTP';
//                         }
//                         return null;
//                       },
//                       pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                     ),
//                   ],
//
//                 ),
//
//                   // child: FormBuilder(
//                   //   key: formKey,
//                   //   child: SingleChildScrollView(
//                   //     child: Padding(
//                   //       padding:
//                   //       const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                   //       child: Column(
//                   //         crossAxisAlignment: CrossAxisAlignment.start,
//                   //         children: [
//                   //           const SizedBox(height: Constants.SMALL_SPACING),
//                   //           const DecoratedBox(
//                   //             decoration: BoxDecoration(),
//                   //             child: Logo(
//                   //               size: 100,
//                   //             ),
//                   //           ),
//                   //           const SizedBox(height: Constants.SMALL_SPACING),
//                   //           const Text(
//                   //             "Verify Account ✅",
//                   //             style: TextStyle(fontSize: 40),
//                   //           ),
//                   //           const SizedBox(height: Constants.SPACING),
//                   //           RichText(
//                   //             text: TextSpan(
//                   //               text: "Code has been sent to ",
//                   //               style: TextStyle(color: theme.colorScheme.onSurface),
//                   //               children: [
//                   //                 TextSpan(
//                   //                   text: username,
//                   //                   style: TextStyle(
//                   //                     color: theme.colorScheme.primary,
//                   //                   ),
//                   //                 ),
//                   //                 const TextSpan(
//                   //                   text: "\n\nEnter the code to verify account",
//                   //                 ),
//                   //               ],
//                   //             ),
//                   //           ),
//                   //           const SizedBox(height: Constants.SPACING * 3),
//                   //           LabelInputContainer(
//                   //             label: "Enter Code",
//                   //             child: FormBuilderTextField(
//                   //               name: "otp",
//                   //               decoration: outLineInputDecoration(
//                   //                 placeholder: "5 Digit Code",
//                   //               ),
//                   //               validator: FormBuilderValidators.compose([
//                   //                 FormBuilderValidators.required(),
//                   //               ]),
//                   //               keyboardType: TextInputType.number,
//                   //             ),
//                   //           ),
//                   //           const SizedBox(height: Constants.SPACING * 6),
//                   //           Button(
//                   //             title: "Verify Account",
//                   //             backgroundColor: theme.colorScheme.primary,
//                   //             textColor: Colors.white,
//                   //             onPress: handleSubmit,
//                   //             loading: loading.value,
//                   //           ),
//                   //           const SizedBox(height: Constants.SPACING * 2),
//                   //           if(timer.remainingTime == 0)
//                   //             LinkedRichText(
//                   //                 linked: "Don't receive code?",
//                   //                 unlinked: "Resend code",
//                   //                 mainAxisAlignment: MainAxisAlignment.start,
//                   //                 onPress: () {
//                   //                   timer.reset();
//                   //                   loading.value =true;
//                   //                   passwordResetStateNotifier
//                   //                       .resetPassword({"user_name": username}).then(
//                   //                         (value) {
//                   //                       ScaffoldMessenger.of(context).showSnackBar(
//                   //                         SnackBar(content: Text(value)),
//                   //                       );
//                   //                     },
//                   //                   ).whenComplete(() {
//                   //                     loading.value = false;
//                   //                   });
//                   //                 }),
//                   //           const SizedBox(height: Constants.SPACING),
//                   //           LinkedRichText(linked: "Send code in ", unlinked: "00:${timer.remainingTime}", mainAxisAlignment: MainAxisAlignment.start),
//                   //           const SizedBox(height: Constants.SPACING),
//                   //           // Consumer(
//                   //           //   builder: (context, ref, child) {
//                   //           //     return LinkedRichText(
//                   //           //       linked: "",
//                   //           //       unlinked: "Back to login",
//                   //           //       onPress: () =>
//                   //           //           ref.read(authStateProvider.notifier).logout(),
//                   //           //     );
//                   //           //   },
//                   //           // )
//                   //         ],
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ))
//             ],
//           ),
//         ));
//   }
// }
