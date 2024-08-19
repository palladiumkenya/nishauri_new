import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/hooks/uset_timer.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/display/scafold_stack_body.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:pinput/pinput.dart';
import '../../../../shared/display/Logo.dart';
import '../../../../utils/routes.dart';

class ProgramVerificationScreen extends HookConsumerWidget {
  final Map<String, dynamic> payload;

  const ProgramVerificationScreen({super.key, required this.payload});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final programResetStateNotifier = ref.read(userProgramProvider.notifier);
    final authStateNotifier = ref.read(authStateProvider.notifier);
    final timer = useTime(const Duration(seconds: 60));
    final loading = useState(false);
    final otp = useState<String?>(null);

    void handleSubmit(String? otp) {
      if (otp != null) {
        loading.value = true;

        // Form payload
        final otpCode = {"program_otp": otp};
        final payLoad = {...payload, ...otpCode};

        programResetStateNotifier.registerProgram(payLoad).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(value)),
          );
          context.goNamed(RouteNames.PROGRAM_MENU);
        }).catchError((err) {
          handleResponseError(context, formKey.currentState!.fields, err, authStateNotifier.logout);
        }).whenComplete(() {
          loading.value = false;
        });
      }
    }

    var theme = Theme.of(context);

    final defaultPinTheme = PinTheme(
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
    );

    return Scaffold(
      body: ScaffoldStackedBody(
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: SvgPicture.asset(
                  "assets/images/reply-dark.svg",
                  semanticsLabel: "Back",
                  fit: BoxFit.contain,
                  width: 40,
                  height: 40,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          "Verify Program ✅",
                          style: TextStyle(fontSize: 40),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        RichText(
                          text: TextSpan(
                            text: "Code has been sent to ",
                            style: TextStyle(color: theme.colorScheme.onSurface),
                            children: [
                              TextSpan(
                                text: payload['phone'],
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const TextSpan(
                                text: "\n\nEnter the code to verify Program",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Constants.SPACING * 3),
                        Pinput(
                          length: 5,
                          defaultPinTheme: defaultPinTheme,
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
                          onChanged: (value) {
                            otp.value = value;
                          },
                          onCompleted: (value) {
                            otp.value = value;
                          },
                          validator: (value) {
                            if (value == null || value.length != 5) {
                              return 'Check the code should be 5 digits';
                            }
                            return null;
                          },
                          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        ),
                        const SizedBox(height: Constants.SPACING * 6),
                        Button(
                          title: "Verify Program",
                          backgroundColor: theme.colorScheme.primary,
                          textColor: Colors.white,
                          onPress: () => handleSubmit(otp.value),
                          loading: loading.value,
                        ),
                        const SizedBox(height: Constants.SPACING * 2),
                        if (timer.remainingTime == 0)
                          LinkedRichText(
                            linked: "Don't receive code?",
                            unlinked: "Resend code",
                            mainAxisAlignment: MainAxisAlignment.start,
                            onPress: () {
                              timer.reset();
                              loading.value = true;
                              programResetStateNotifier.resendOTP(payload).then(
                                    (value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value)),
                                  );
                                },
                              ).whenComplete(() {
                                loading.value = false;
                              });
                            },
                          ),
                        const SizedBox(height: Constants.SPACING),
                        LinkedRichText(
                          linked: "Don't receive code? Resend code in ",
                          unlinked: "00:${timer.remainingTime}",
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        const SizedBox(height: Constants.SPACING),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
