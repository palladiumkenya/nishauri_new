import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:pinput/pinput.dart';

class ProgramRegistrationScreen extends HookConsumerWidget {
  const ProgramRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormBuilderState>();
    final _program = useState<int?>(null);
    final _loading = useState<bool>(false);
    final _isValidation = useState<bool>(false);
    final _countdownSeconds = useState<int>(60);
    final _sent = useState<bool>(false);
    Timer? _countdownTimer;

    void _startCountdownTimer() {
      _countdownSeconds.value = 60;
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_countdownSeconds.value > 0) {
          _countdownSeconds.value--;
          print(' counting down: -> ${_countdownSeconds.value}');
        } else {
          _countdownTimer?.cancel();
        }
      });
    }

    Future<void> validateOtp(String? otp, Map<String, dynamic> payload) async {
      if (otp != null) {
        final validateOtpNotifier = ref.read(userProgramProvider.notifier);
        var programOtp = {"program_otp": otp};
        var mergedData = {...payload, ...programOtp};

        try {
          final response = await validateOtpNotifier.registerProgram(mergedData);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
          context.pop();
        } catch (err) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
        }
      }
    }

    void _handleResendOTP(BuildContext context, Map<String, dynamic> payload) {
      if (!_sent.value && _countdownSeconds.value <= 0) {
        _startCountdownTimer();
        _loading.value = true;

        final resendOTPNotifier = ref.read(userProgramProvider.notifier);

        resendOTPNotifier.resendOTP(payload).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(value)),
          );
        }).whenComplete(() {
          _loading.value = false;
        });
      }
    }

    Future<void> showOtpDialog(Map<String, dynamic> payload, String responseMessage) async {
      if (_sent.value || _countdownSeconds.value > 0) {
        _startCountdownTimer();
        _sent.value = true;
      }

      return showDialog(
        context: context,
        builder: (context) {
          final theme = Theme.of(context);
          String? otp;
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

          return AlertDialog(
            title: const Text('Please enter the OTP code to verify your program'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'A code has been sent to ',
                    style: const TextStyle(
                      color: Constants.programsColor,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: responseMessage,
                        style: TextStyle(
                          color: theme.primaryColorDark,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Constants.SPACING),
                Pinput(
                  length: 5,
                  defaultPinTheme: defaultPinTheme,
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: Constants.programsColor,
                      ),
                    ],
                  ),
                  onChanged: (value) {
                    otp = value;
                  },
                  onCompleted: (value) {
                    otp = value;
                  },
                  validator: (value) {
                    if (value == null || value.length != 5) {
                      return 'Please enter a valid 5-digit OTP';
                    }
                    return null;
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                ),
              ],
            ),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await validateOtp(otp, payload);
                      },
                      child: const Text('Validate'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Constants.SPACING * 2),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinkedRichText(
                      linked: "Don't receive code?",
                      unlinked: " Resend code",
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPress: () => _handleResendOTP(context, payload),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    Future<void> handleProgramVerification(Map<String, dynamic> payload) async {
      final programsNotifier = ref.read(userProgramProvider.notifier);

      try {
        final response = await programsNotifier.programVerification(payload);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['msg'])));
        await showOtpDialog(payload, response['data']['phoneno']);
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
      }
    }

    void handleSubmit() async {
      if (_formKey.currentState!.saveAndValidate()) {
        _loading.value = true;
        final payload = _formKey.currentState!.value;

        try {
          if (_isValidation.value) {
            await handleProgramVerification(payload);
          } else {
            final programsNotifier = ref.read(userProgramProvider.notifier);
            final response = await programsNotifier.registerProgram(payload);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$response')));
            context.pop();
          }
        } catch (err) {
          handleResponseError(
            context,
            _formKey.currentState!.fields,
            err,
            ref.read(authStateProvider.notifier).logout,
          );
        } finally {
          _loading.value = false;
        }
      }
    }

    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Add program",
            icon: Icons.add_task_sharp,
            subTitle: "Kindly provide program details below to verify yourself",
            color: Constants.programsColor,
          ),
          Expanded(
            child: ResponsiveWidgetFormLayout(
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
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Consumer(
                          builder: (context, ref, child) {
                            final asyncPrograms = ref.watch(programsProvider);

                            return asyncPrograms.when(
                              data: (programs) => Column(
                                children: [
                                  const SizedBox(height: Constants.SPACING),
                                  DecoratedBox(
                                    decoration: const BoxDecoration(),
                                    child: SvgPicture.asset(
                                      "assets/images/add-appointment-large.svg",
                                      semanticsLabel: "Doctors",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(height: Constants.SPACING * 3),
                                  FormBuilderDropdown<int>(
                                    name: "program_id",
                                    decoration: inputDecoration(
                                      prefixIcon: Icons.read_more_outlined,
                                      label: "Program",
                                    ),
                                    items: programs.map((program) => DropdownMenuItem(
                                      value: program.id,
                                      child: Text(program.name ?? ''),
                                    )).toList(),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                    onChanged: (value) {
                                      _program.value = value;
                                      _isValidation.value = value == 1;
                                    },
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  Visibility(
                                    visible: _isValidation.value,
                                    child: FormBuilderTextField(
                                      name: "ccc_no",
                                      decoration: inputDecoration(
                                        placeholder: "e.g 1234567890",
                                        prefixIcon: Icons.verified_user,
                                        label: "CCC Number",
                                      ),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  Visibility(
                                    visible: _isValidation.value,
                                    child: FormBuilderTextField(
                                      name: "firstname",
                                      decoration: inputDecoration(
                                        placeholder: "e.g John",
                                        prefixIcon: Icons.person,
                                        label: "First Name",
                                      ),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  Button(
                                    title: "Add Program",
                                    backgroundColor: Constants.programsColor,
                                    textColor: Colors.white,
                                    surfixIcon: const FaIcon(FontAwesomeIcons.plus),
                                    loading: _loading.value,
                                    onPress: handleSubmit,
                                  ),
                                ],
                              ),
                              error: (error, _) => Center(child: Text('Error: $error')),
                              loading: () => const Center(child: CircularProgressIndicator()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
