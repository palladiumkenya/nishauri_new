import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user_programs/data/models/user_program.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class ProgramUpdateScreen extends StatefulWidget {
  const ProgramUpdateScreen({super.key});

  @override
  State<ProgramUpdateScreen> createState() => _ProgramUpdateScreenState();
}

class _ProgramUpdateScreenState extends State<ProgramUpdateScreen> {
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
        //   title: const Text("Remove program"),
        // ),
        body: Column(
      children: [
        CustomAppBar(
          color: Constants.programsColor,
          title: "Remove program 📋",
          // icon: Icons.remove_done_sharp,
          subTitle: "Kindly select the program you want\nto remove",
          // color: Colors.white30,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final asyncUserPrograms =
                              ref.watch(userProgramProvider);

                          return asyncUserPrograms.when(
                            data: (userPrograms) => Column(
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
                                const SizedBox(height: Constants.SPACING),
                                FormBuilderDropdown<String>(
                                  name: "program_id",
                                  decoration: inputDecoration(
                                    prefixIcon: Icons.read_more_outlined,
                                    label: "Program",
                                  ),
                                  items: _getRegisteredPrograms(userPrograms),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                  onChanged: (value) {
                                    setState(() {
                                      _program = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: Constants.SPACING),
                                Button(
                                  backgroundColor: Constants.programsColor,
                                  textColor: Colors.white,
                                  title: "Remove Program",
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
                                          .updateProgram(
                                              _formKey.currentState!.value)
                                          .then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(value),
                                          ),
                                        );
                                        // context.go("/");
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
                                      }).whenComplete(() => setState(() {
                                                _loading = false;
                                              }));
                                    }
                                  },
                                ),
                              ],
                            ),
                            error: (error, _) =>
                                Center(child: Text(error.toString())),
                            loading: () => const Center(
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
    ));
  }
}

List<DropdownMenuItem<String>> _getRegisteredPrograms(
    List<UserProgram> programs) {
  // Filter out active programs
  final activePrograms =
      programs.where((program) => program.isActive == true).toList();

  // Generate dropdown menu items for active programs
  return ProgramCodeNameIds.SUPPOTED_PROGRAM_CODES
      .where((code) => activePrograms.any((program) => program.id == code))
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(
                ProgramCodeNameIds.getProgramNameByCode(e) ?? "Not Supported"),
          ))
      .toList();
}
