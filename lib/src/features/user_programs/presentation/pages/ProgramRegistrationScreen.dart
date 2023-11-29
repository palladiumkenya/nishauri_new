import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/features/user_programs/presentation/forms/HIVProgramRegistration.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class ProgramRegistrationScreen extends StatefulWidget {
  const ProgramRegistrationScreen({super.key});

  @override
  State<ProgramRegistrationScreen> createState() =>
      _ProgramRegistrationScreenState();
}

class _ProgramRegistrationScreenState extends State<ProgramRegistrationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? _program;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            child: FormBuilder(
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
                          final asyncUserPrograms = ref.watch(programProvider);
                          return asyncUserPrograms.when(
                            data: (userPrograms) => FormBuilderDropdown<String>(
                              name: "program",
                              decoration: inputDecoration(
                                prefixIcon: Icons.read_more_outlined,
                                label: "Program",
                              ),
                              items: _getUnregisteredPrograms(userPrograms),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              onChanged: (value) {
                                setState(() {
                                  _program = value;
                                });
                              },
                            ),
                            error: (error, _) => Text(error.toString()),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: Constants.SPACING),
                      if (_program != null)
                        _getProgramRegistrationForm(
                            _program),
                      Consumer(
                        builder: (context, ref, child) {
                          final programsNotifier =
                              ref.read(programProvider.notifier);
                          return Button(
                            title: "Register",
                            onPress: () {
                              if (_formKey.currentState!.saveAndValidate()) {
                                programsNotifier
                                    .registerProgram(
                                        _formKey.currentState!.value)
                                    .then((value) {
                                  context.pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "${ProgramCodeNames.getProgramNameByCode(_formKey.currentState!.value['program'])} Program Registered successfully"),
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

List<DropdownMenuItem<String>> _getUnregisteredPrograms(
    List<UserProgram> programs) {
  return ProgramCodeNames.SUPPOTED_PROGRAM_CODES
      .where((code) =>
          !programs.any((program) => program.program.programCode == code))
      .map((e) => DropdownMenuItem(
          value: e,
          child: Text(
              ProgramCodeNames.getProgramNameByCode(e) ?? "Not Supported")))
      .toList();
}

Widget _getProgramRegistrationForm(program) {
  if (program == ProgramCodeNames.HIV) {
    return const HIVProgramRegistration();
  }
  return Padding(
    padding: const EdgeInsets.all(Constants.SPACING),
    child: Text("${ProgramCodeNames.getProgramNameByCode(program)} form here"),
  );
}
