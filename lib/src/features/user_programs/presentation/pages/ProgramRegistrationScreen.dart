import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
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
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.chevron_left),
      //     onPressed: () => context.pop(),
      //   ),
      //   title: const Text("Register to a program"),
      // ),
      body: Column(
        children: [
          const CustomAppBar(
            title: "Add program",
            icon: Icons.add_task_sharp,
            // color: Colors.white30,
            subTitle: "Kindly provide program details \n bellow to verify yourself",
            color: Constants.programsColor,
          ),
          Expanded(child:       ResponsiveWidgetFormLayout(
            buildPageContent: (context, color) =>
                SafeArea(
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
                          child: Consumer(
                            builder: (context, ref, child) {
                              void handleSubmit(){
                                if (_formKey.currentState!.saveAndValidate()) {
                                  setState(() {
                                    _loading = true;
                                  });
                                  // final userStateNotifier = ref.read(userProvider.notifier);
                                  final programsNotifier = ref.read(userProgramProvider.notifier);
                                  programsNotifier
                                      .registerProgram(_formKey.currentState!.value)
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${value}')),
                                    );
                                  }).catchError((err) {
                                    handleResponseError(context, _formKey.currentState!.fields, err,
                                        ref.read(authStateProvider.notifier).logout);
                                  }).whenComplete(() {
                                    setState(() {
                                      _loading = false;
                                    });
                                  });
                                }
                              }
                              final asyncUserPrograms = ref.watch(userProgramProvider);
                              
                              return asyncUserPrograms.when(
                                data: (userPrograms) =>
                                    Column(
                                      children: [
                                        const SizedBox(height: Constants.SPACING),
                                        DecoratedBox(
                                          decoration: const BoxDecoration(),
                                          child: SvgPicture.asset(
                                            "assets/images/add-appointment-large.svg",
                                            semanticsLabel: "Doctors",
                                            fit: BoxFit.contain,
                                            // height: 150,
                                          ),
                                        ),
                                        const SizedBox(height: Constants.SPACING*3),

                                        FormBuilderDropdown<String>(
                                          name: "program_id",
                                          decoration: inputDecoration(
                                            prefixIcon: Icons.read_more_outlined,
                                            label: "Program",
                                          ),
                                          items: _getUnregisteredPrograms(
                                              userPrograms),
                                          validator: FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                          ]),
                                          onChanged: (value) {
                                            setState(() {
                                              _program = value;
                                            });
                                          },
                                        ),
                                        // const SizedBox(height: Constants.SPACING),
                                        // FormBuilderTextField(
                                        //   name: "mflCode",
                                        //   decoration: inputDecoration(
                                        //     prefixIcon: Icons.local_hospital,
                                        //     label: "Facility code",
                                        //   ),
                                        //   validator: FormBuilderValidators.compose([
                                        //     FormBuilderValidators.required(),
                                        //   ]),
                                        // ),
                                        const SizedBox(height: Constants.SPACING),
                                        Visibility(
                                          visible: _program == ProgramCodeNameIds.HIV, // Show if HIV program is selected
                                          child: FormBuilderTextField(
                                            name: "ccc_no",
                                            decoration: inputDecoration(
                                              placeholder: "e.g 1234567890",
                                              prefixIcon: Icons.verified_user,
                                              label: _getProgramId(_program),
                                            ),
                                            validator: FormBuilderValidators.compose([
                                              FormBuilderValidators.required()
                                            ]),
                                          ),
                                        ),

                                        const SizedBox(height: Constants.SPACING),
                                        Visibility(
                                          visible: _program == ProgramCodeNameIds.HIV, // Show if HIV program is selected
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

                                        // FormBuilderTextField(
                                        //   name: "ccc_no",
                                        //   decoration: inputDecoration(
                                        //     placeholder: "e.g 1234567890",
                                        //     prefixIcon: Icons.verified_user,
                                        //     label: _getProgramId(_program),
                                        //   ),
                                        //   validator: FormBuilderValidators.compose([
                                        //     FormBuilderValidators.required()
                                        //   ]),
                                        // ),
                                        // const SizedBox(height: Constants.SPACING),
                                        // FormBuilderTextField(
                                        //   name: "firstname",
                                        //   decoration: inputDecoration(
                                        //     placeholder: "e.g John",
                                        //     prefixIcon: Icons.person,
                                        //     label: "First Name",
                                        //   ),
                                        //   validator: FormBuilderValidators.compose([
                                        //     FormBuilderValidators.required(),
                                        //   ]),
                                        // ),
                                        const SizedBox(height: Constants.SPACING),
                                        Button(
                                          title: "Add Program",
                                          backgroundColor: Constants.programsColor,
                                          textColor: Colors.white,
                                          surfixIcon: const FaIcon(FontAwesomeIcons.plus),
                                          loading: _loading,
                                          onPress: () {
                                            final programsNotifier =
                                            ref.read(userProgramProvider.notifier);
                                            if (_formKey.currentState!
                                                .saveAndValidate()) {
                                              setState(() {
                                                _loading = true;
                                              });
                                              programsNotifier
                                                  .registerProgram(
                                                  _formKey.currentState!.value)
                                                  .then((value) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text(value)),
                                                );
                                                context.pop();

                                              }).catchError((err) {
                                                handleResponseError(
                                                    context,
                                                    _formKey.currentState!.fields,
                                                    err,
                                                    ref
                                                        .read(
                                                        authStateProvider.notifier)
                                                        .logout);
                                              }).whenComplete(() =>
                                                  setState(() {
                                                    _loading = false;
                                                  }));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                error: (error, _) =>
                                    BackgroundImageWidget(
                                      svgImage: 'assets/images/patient.svg',
                                      notFoundText: error.toString(),
                                    ),
                                loading: () =>
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
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
      )
    );
  }
}

List<DropdownMenuItem<String>> _getUnregisteredPrograms(
    List<UserProgram> programs) {
  print(programs);
  return ProgramCodeNameIds.SUPPOTED_PROGRAM_CODES
      .where((code) =>
  !programs.any((program) => program.id == code && program.isActive))
      .map((e) =>
      DropdownMenuItem(
          value: e,
          child: Text(
              ProgramCodeNameIds.getProgramNameByCode(e) ?? "Not Supported")))
      .toList();
}

String _getProgramId(program) {
  switch (program) {
    case ProgramCodeNameIds.HIV:
      return "CCC Number";
    default:
      return "Unique Program Identifier";
  }
}