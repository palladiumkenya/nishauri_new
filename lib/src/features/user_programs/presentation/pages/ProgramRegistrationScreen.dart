import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/features/user_programs/presentation/forms/HIVProgramRegistration.dart';
import 'package:nishauri/src/shared/form/AppDropDownInput.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class ProgramRegistrationScreen extends StatefulWidget {
  const ProgramRegistrationScreen({super.key});

  @override
  State<ProgramRegistrationScreen> createState() =>
      _ProgramRegistrationScreenState();
}

class _ProgramRegistrationScreenState extends State<ProgramRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  AppFormState _formState = AppFormState(values: {
    "program": null
  }, validators: {
    "program": [ValidationBuilder().required().build()],
    "cccNumber": [ValidationBuilder().required().build()],
    "firstName": [ValidationBuilder().required().build()]
  });

  final List<String> programs = <String>[
    'HIV Program',
    'Hypertension Program',
    'Diabetes program',
    'Tuberculosis program',
    'Cancer program',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void _handleFormFieldChange(String name, String? value) {
      setState(() {
        _formState =
            _formState.copyWith(values: {..._formState.values, name: value});
      });
    }

    void _handleInitializeProgramormState(String programCode) {
      Map<String, dynamic> form = {};
      if (programCode == ProgramCodeNames.HIV) {
        form = {"cccNumber": "", "firstName": ""};
      }
      if (programCode == ProgramCodeNames.HYPERTENSION) {}
      if (programCode == ProgramCodeNames.CANCER) {}
      if (programCode == ProgramCodeNames.DIABETES) {}
      if (programCode == ProgramCodeNames.TB) {}
      if (programCode == ProgramCodeNames.ASTHMA) {}

      setState(() {
        _formState =
            _formState.copyWith(values: {"program": programCode, ...form});
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.pop(),
        ),
        title: const Text("Register to a program"),
      ),
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (context, color) => SafeArea(
          child: Container(
            padding: const EdgeInsets.all(Constants.SPACING * 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: Constants.SPACING),
                      DecoratedBox(
                        decoration: const BoxDecoration(),
                        child: SvgPicture.asset(
                          "assets/images/patient.svg",
                          semanticsLabel: "Doctors",
                          fit: BoxFit.contain,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      const Text(
                        "Add program",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      Text(
                        "Kindly provide program details bellow to verify yourself.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Constants.SPACING),
                      const SizedBox(height: Constants.SPACING),
                      Consumer(
                        builder: (context, ref, child) {
                          final programs = ref.watch(programProvider);
                          return programs.when(
                            data: (data) => AppDropDownInput(
                              name: "program",
                              prefixIcon: Icons.read_more_outlined,
                              onItemSelected: (name, value) {
                                _handleFormFieldChange(name, value);
                                _handleInitializeProgramormState(value);
                              },
                              formState: _formState,
                              items: _getUnregisteredPrograms(data),
                              label: "Program",
                            ),
                            error: (error, _) => Text(error.toString()),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: Constants.SPACING),
                      if (_formState.values['program'] != null)
                        _getProgramRegistrationForm(
                            _formState, _handleFormFieldChange),
                      if (_formState.values['program'] != null)
                        Consumer(
                          builder: (context, ref, child) {
                            final programsNotifier =
                                ref.read(programProvider.notifier);
                            return Button(
                              title: "Register",
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  programsNotifier
                                      .registerProgram(_formState.values)
                                      .then((value) {
                                    context.pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "${ProgramCodeNames.getProgramNameByCode(_formState.values['program'])} Program Registered successfully"),
                                      ),
                                    );
                                  });
                                }
                              },
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
      ),
    );
  }
}

List<DropdownMenuEntry> _getUnregisteredPrograms(List<UserProgram> programs) {
  return ProgramCodeNames.SUPPOTED_PROGRAM_CODES
      .where((code) =>
          !programs.any((program) => program.program.programCode == code))
      .map((e) => DropdownMenuEntry(
          value: e,
          label: ProgramCodeNames.getProgramNameByCode(e) ?? "Not Supported"))
      .toList();
}

Widget _getProgramRegistrationForm(
    AppFormState formState, void Function(String, String?) onFormFieldChange) {
  final program = formState.values["program"];
  if (program == ProgramCodeNames.HIV) {
    return HIVProgramRegistration(
      formState: formState,
      onFormFieldChange: onFormFieldChange,
    );
  }
  return Padding(
    padding: const EdgeInsets.all(Constants.SPACING),
    child: Text("${ProgramCodeNames.getProgramNameByCode(program)} form here"),
  );
}
