import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/features/visits/data/providers/visits_provider.dart';
import 'package:nishauri/src/hooks/uset_timer.dart';
import 'package:nishauri/src/shared/display/AppSearch.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
import 'package:nishauri/src/shared/display/label_input_container.dart';
import 'package:nishauri/src/shared/display/scafold_stack_body.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:pinput/pinput.dart';

class FacilityVisitsScreen extends HookConsumerWidget {
  const FacilityVisitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthRepository _repository;
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final requestVerificationStateNotifier = ref.read(userProvider.notifier);
    final authStateNotifier = ref.read(authStateProvider.notifier);
    final userAsync = ref.watch(userProvider);
    final timer = useTime(const Duration(seconds: 60));
    final loading = useState(false);

    final user = userAsync.when(data: (data) => data.phoneNumber, error: (error, _) => "", loading: () => null);

    final otpController = useTextEditingController();

    // Call the getOTPCode method when the form opens
    useEffect(() {
      requestVerificationStateNotifier.getOTPCode("sms");
      return null;
    }, []);

    void handleSubmit() {
      context.goNamed(
          RouteNames.FACILITY_VISIT_DETAIL,
          pathParameters: {"visitId": "1"});
      // if (formKey.currentState!.saveAndValidate()) {
        // loading.value = true;
        // final userStateNotifier = ref.read(userProvider.notifier);
        // userStateNotifier.verify({
        //   "otp": otpController.text,
        //   "mode": "sms"
        // }).then((value) {
        //   context.goNamed(
        //       RouteNames.FACILITY_VISIT_DETAIL,
        //       pathParameters: {"visitId": "1"});
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(value)),
        //   );
        // }) .whenComplete(() {
        //   loading.value = false;
        // });
        //     .catchError((err) {
        //   handleResponseError(context, formKey.currentState!.fields, err,
        //       authStateNotifier.logout);
        // }).whenComplete(() {
        //   loading.value = false;
        // });
      // }
    }

    var theme = Theme.of(context);

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
                          "SHR Pull ✅",
                          style: TextStyle(fontSize: 40),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        RichText(
                          text: TextSpan(
                            text: "Code has been sent to ",
                            style: TextStyle(color: theme.colorScheme.onSurface),
                            children: [
                              TextSpan(
                                text: user,
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const TextSpan(
                                text: "\n\nEnter the code to pull Your Facility visit",
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
                          title: "Verify OTP",
                          backgroundColor: theme.colorScheme.primary,
                          textColor: Colors.white,
                          onPress: handleSubmit,
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
                              requestVerificationStateNotifier
                                  .getOTPCode("sms")
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(value)),
                                );
                              }).whenComplete(() {
                                loading.value = false;
                              });
                            },
                          ),
                        const SizedBox(height: Constants.SPACING),
                        LinkedRichText(
                          linked: "Send code in ",
                          unlinked: "00:${timer.remainingTime}",
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        const SizedBox(height: Constants.SPACING),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}