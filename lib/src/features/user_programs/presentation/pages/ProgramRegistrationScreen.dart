import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:pinput/pinput.dart';

class ProgramRegistrationScreen extends StatefulWidget {
  const ProgramRegistrationScreen({super.key});

  @override
  State<ProgramRegistrationScreen> createState() => _ProgramRegistrationScreenState();
}

class _ProgramRegistrationScreenState extends State<ProgramRegistrationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  int? _program;
  bool _loading = false;
  bool _isValidation = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Future<void> validateOtp(String? otp, ref, Map<String, dynamic> payload) async {
      if (otp != null) {
        final validateOtpNotifier = ref.read(userProgramProvider.notifier);
        var programOtp = {"program_otp" : otp};
        var mergedData = {...payload, ...programOtp};
        print(mergedData);

        try {
          final response = await validateOtpNotifier.registerProgram(mergedData);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));
        } catch (err) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
        }
      }
    }

    Future<void> showOtpDialog(ref, Map<String, dynamic> payload, String responseMessage) async {
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
                    style: TextStyle(
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
                        await validateOtp(otp, ref, payload);
                      },
                      child: const Text('Validate'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    Future<void> handleProgramVerification(ref, Map<String, dynamic> payload) async {
      final programsNotifier = ref.read(userProgramProvider.notifier);

      try {
        final response = await programsNotifier.programVerification(payload);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['msg'])));
        await showOtpDialog(ref, payload, response['data']['phoneno']);
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
      }
    }

    void handleSubmit(ref) async {
      if (_formKey.currentState!.saveAndValidate()) {
        setState(() {
          _loading = true;
        });
        final payload = _formKey.currentState!.value;

        try {
          if (_isValidation) {
            await handleProgramVerification(ref, payload);
          } else {
            final programsNotifier = ref.read(userProgramProvider.notifier);
            final response = await programsNotifier.registerProgram(payload);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$response')));
          }
        } catch (err) {
          handleResponseError(context, _formKey.currentState!.fields, err, ref.read(authStateProvider.notifier).logout);
        } finally {
          setState(() {
            _loading = false;
          });
        }
      }
    }

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Add program",
            icon: Icons.add_task_sharp,
            subTitle: "Kindly provide program details \n below to verify yourself",
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
                                      setState(() {
                                        _program = value;
                                        _isValidation = value == 1;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  Visibility(
                                    visible: _isValidation,
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
                                    visible: _isValidation,
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
                                    loading: _loading,
                                    onPress: () => handleSubmit(ref),
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
          )
        ],
      ),
    );
  }
}
