import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/utils/constants.dart';

class HIVProgramRegistration extends StatefulWidget {
  const HIVProgramRegistration({super.key});

  @override
  State<HIVProgramRegistration> createState() => _HIVProgramRegistrationState();
}

class _HIVProgramRegistrationState extends State<HIVProgramRegistration> {
  final _formKey = GlobalKey<FormState>();
  var _cccNumber;
  var _firstName;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        void handleSubmit() async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              this._formKey.currentState!.save();
            });
            final credentials = {"username": _cccNumber, "password": _firstName};
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Program verification"),
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.chevron_left),
            ),
          ),
          body: ResponsiveWidgetFormLayout(
            buildPageContent: (BuildContext context, Color? color) => SafeArea(
              child: Container(
                padding: const EdgeInsets.all(Constants.SPACING * 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: Constants.SPACING),
                        DecoratedBox(
                          decoration: const BoxDecoration(),
                          child: SvgPicture.asset(
                            "assets/images/verify.svg",
                            semanticsLabel: "Doctors",
                            fit: BoxFit.contain,
                            height: 150,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Program Verification",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        Text(
                          "Kindly provide your HIV program details bellow to verify yourself.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: Constants.SPACING),
                        FormInputTextField(
                          onSaved: (ccc) => _cccNumber = ccc,
                          placeholder: "e.g 1234567890",
                          prefixIcon: Icons.verified_user,
                          label: "CCC Number",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Constants.SPACING),
                        FormInputTextField(
                          onSaved: (name)=>_firstName = name,
                          placeholder: "e.g John",
                          prefixIcon: Icons.person,
                          label: "First Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Constants.SPACING),
                        Button(
                          title: "Verify",
                          onPress: handleSubmit,
                        ),
                        const SizedBox(
                          height: Constants.SPACING,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
