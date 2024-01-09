import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:pinput/pinput.dart';

import '../../../../utils/helpers.dart';
import '../../data/models/program_verification_detail.dart';

class ProgramVerificationScreen extends HookConsumerWidget {
  final ProgramVerificationDetail verificationDetail;

  const ProgramVerificationScreen(
      {super.key, required this.verificationDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final pinController = useTextEditingController();
    final theme = Theme.of(context);
    final loading = useState<bool>(false);
    final sent = useState<bool>(false);
    final submittingRequest = useState<bool>(false);

    final focusedBorderColor = theme.colorScheme.primary.withOpacity(0.5);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    final borderColor = theme.colorScheme.primary;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: theme.colorScheme.secondary,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      body: FormBuilder(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container()),
              const Icon(Icons.security, size: 80),
              const SizedBox(height: Constants.SPACING),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Text(
                  verificationDetail.message,
                  style: theme.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              FormBuilderRadioGroup(
                name: "mode",
                decoration: const InputDecoration(border: InputBorder.none),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: "Kindly choose verification method"),
                ]),
                options: verificationDetail.contacts
                    .map(
                      (e) => FormBuilderFieldOption(
                        value: e.contact,
                        child: ListTile(
                          title: Text(e.type),
                          subtitle: Text(e.contact),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: Constants.SPACING),
              if (!loading.value)
                FormBuilderField<String>(
                    builder: (state) {
                      pinController.text = state.value ?? "";
                      return Directionality(
                        // Specify direction if desired
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          controller: pinController,
                          focusNode: focusNode,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: defaultPinTheme,
                          separatorBuilder: (index) => const SizedBox(width: 8),
                          // onClipboardFound: (value) {
                          //   debugPrint('onClipboardFound: $value');
                          //   pinController.setText(value);
                          // },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            loading.value = true;
                            final programNotifier =
                                ref.watch(programProvider.notifier);
                            programNotifier.verifyProgramOTP({
                              "otp": pinController.text,
                              "program": verificationDetail.programCode
                            }).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "${ProgramCodeNames.getProgramNameByCode(verificationDetail.programCode)} Program Registered successfully"),
                                ),
                              );
                              context.go("/");
                            }).catchError((err) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Invalid OTP")));
                            }).whenComplete(() => loading.value = false);
                          },
                          onChanged: (value) {
                            debugPrint('onChanged: $value');
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                color: focusedBorderColor,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(19),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(color: theme.colorScheme.error),
                          ),
                        ),
                      );
                    },
                    name: "code"),
              if (loading.value) const CircularProgressIndicator(),
              if (!loading.value)
                Consumer(
                  builder: (context, ref, child) {
                    final programNotifier = ref.watch(programProvider.notifier);
                    return submittingRequest.value
                        ? const CircularProgressIndicator()
                        : TextButton(
                            onPressed: () {
                              if (formKey.currentState != null &&
                                  formKey.currentState!.saveAndValidate()) {
                                submittingRequest.value = true;
                                programNotifier
                                    .getVerificationCode(
                                        formKey.currentState!.value)
                                    .then(
                                  (message) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(message),
                                      ),
                                    );
                                  },
                                ).catchError((error) {
                                  handleResponseError(
                                    context,
                                    formKey.currentState!.fields,
                                    error,
                                    ref
                                        .watch(authStateProvider.notifier)
                                        .logout,
                                  );
                                }).whenComplete(
                                  () {
                                    submittingRequest.value = false;
                                  },
                                );
                              }

                              pinController.clear();
                              focusNode.requestFocus();
                              sent.value = true;
                            },
                            child:
                                Text(sent.value ? 'Resend code' : "Get code"),
                          );
                  },
                ),
              Flexible(flex: 2, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
