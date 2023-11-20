import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/user_programes/presentation/forms/HIVProgramRegistration.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/utils/constants.dart';

class ProgramRegistrationScreen extends StatefulWidget {
  const ProgramRegistrationScreen({super.key});

  @override
  State<ProgramRegistrationScreen> createState() =>
      _ProgramRegistrationScreenState();
}

class _ProgramRegistrationScreenState extends State<ProgramRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> programs = <String>[
    'HIV Program',
    'Hypertension Program',
    'Diabetes program',
    'Tuberculosis program',
    'Cancer program',
  ];

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snack-bar. In the real world,
      // you'd often call a server or save the information in a database.
    }
  }

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
                        "Kindly provide your HIV program details bellow to verify yourself.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Constants.SPACING),
                      const SizedBox(height: Constants.SPACING),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownMenu<String>(
                          leadingIcon: const IconButton(
                            onPressed: null,
                            icon: Icon(Icons.read_more_outlined),
                          ),
                          initialSelection: programs.first,
                          label: const Text("Program"),
                          onSelected: (String? value) {
                            setState(() {
                              // dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries: programs
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      const HIVProgramRegistration(),
                      Button(
                        title: "Register",
                        onPress: handleSubmit,
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


Widget getProgramRegistrationForm(String program){
  // if(program == "")
  return HIVProgramRegistration();
}
