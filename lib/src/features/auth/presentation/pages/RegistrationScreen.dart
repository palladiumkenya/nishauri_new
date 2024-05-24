import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/data/services/Terms.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/display/Logo.dart';
import 'package:nishauri/src/shared/display/label_input_container.dart';
import 'package:nishauri/src/shared/display/scafold_stack_body.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/shared/styles/input_styles.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _hidePassword = true;
  bool _loading = false;
  bool _termsAccepted = false;
  DateTime? _selectedDate;

  void _toggleShowPassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  int calculateAge(DateTime? dob) {
    if (dob == null) return 0;
    var now = DateTime.now();
    var age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        // title: const Text("Sign Up"),
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
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (BuildContext context, Color? color) => SafeArea(
          child: Container(
            padding: const EdgeInsets.all(Constants.SPACING * 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
            ),
            child: Column(
              children: [
                FormBuilder(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
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
                            "Create Account 👋",
                            style: TextStyle(fontSize: 40),
                          ),
                          const SizedBox(height: Constants.SPACING),
                          Row(
                            children: [
                              Expanded(
                                child: LabelInputContainer(
                                  label: "First Name",
                                  child: FormBuilderTextField(
                                    name: "f_name",
                                    decoration: outLineInputDecoration(
                                      placeholder: "John",
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.minLength(2),
                                    ]),
                                  ),
                                ),
                              ),
                              const SizedBox(width: Constants.SMALL_SPACING),
                              Expanded(
                                child: LabelInputContainer(
                                  label: "Last Name",
                                  child: FormBuilderTextField(
                                    name: "l_name",
                                    decoration: outLineInputDecoration(
                                      placeholder: "Doe",
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                      FormBuilderValidators.minLength(2),
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: Constants.SMALL_SPACING),
                          LabelInputContainer(
                            label: "Email",
                            child: FormBuilderTextField(
                              name: "email",
                              decoration: outLineInputDecoration(
                                placeholder: "e.g abc@gmail.com",
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: Constants.SMALL_SPACING),
                          LabelInputContainer(
                            label: "Date of Birth",
                            child: FormBuilderDateTimePicker(
                              firstDate: DateTime(1920),
                              lastDate: DateTime.now(),
                              name: "dob",
                              format: DateFormat('yyy MMM dd'),
                              inputType: InputType.date,
                              decoration: outLineInputDecoration(
                                placeholder: "Enter your date of birth",
                                surfixIcon: Text(
                                  _selectedDate != null
                                      ? '${calculateAge(_selectedDate!).toString()} years'
                                      : '',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                (date) {
                                  if (date == null)
                                    return "Date of birth is required";
                                  if (calculateAge(date) < 12)
                                    return "You must be at least 12 years old";
                                  return null;
                                },
                              ]),
                              onChanged: (date) {
                                setState(() {
                                  _selectedDate = date;
                                });
                              },
                              valueTransformer: (date) =>
                                  date?.toIso8601String(),
                            ),
                          ),
                          const SizedBox(height: Constants.SMALL_SPACING),
                          LabelInputContainer(
                            label: "Gender",
                            child: FormBuilderDropdown(
                              name: "gender",
                              decoration: outLineInputDecoration(
                                  placeholder: "Select your gender"),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              items: const [
                                DropdownMenuItem(
                                  value: "Male",
                                  child: Text("Male"),
                                ),
                                DropdownMenuItem(
                                  value: "Female",
                                  child: Text("Female"),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: Constants.SMALL_SPACING),
                          LabelInputContainer(
                            label: "Phone number",
                            child: FormBuilderTextField(
                              name: "msisdn",
                              decoration: outLineInputDecoration(
                                placeholder: "e.g 0712345678",
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(10,
                                    errorText:
                                        'Phone number must be 10 digits long'),
                                FormBuilderValidators.maxLength(10,
                                    errorText:
                                        'Phone number must be 10 digits long'),
                                (value) {
                                  if (value != null &&
                                      value.isNotEmpty &&
                                      !value.startsWith('0')) {
                                    return 'Phone number must start with zero';
                                  }
                                  return null;
                                },
                              ]),
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                            ),
                          ),
                          const SizedBox(height: Constants.SMALL_SPACING),
                          LabelInputContainer(
                            label: "Password",
                            child: FormBuilderTextField(
                              name: "password",
                              obscureText: _hidePassword,
                              decoration: outLineInputDecoration(
                                  placeholder: "Enter your password",
                                  surfixIcon: _hidePassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onSurfixIconPressed: _toggleShowPassword),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.min(8),
                                FormBuilderValidators.minLength(8),
                              ]),
                            ),
                          ),
                          const SizedBox(height: Constants.SMALL_SPACING),
                          LabelInputContainer(
                            label: "Confirm password",
                            child: FormBuilderTextField(
                              obscureText: _hidePassword,
                              name: "confirmPassword",
                              decoration: outLineInputDecoration(
                                  placeholder: "Confirm your password",
                                  surfixIcon: _hidePassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                  onSurfixIconPressed: _toggleShowPassword),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.min(8),
                                FormBuilderValidators.minLength(8),
                                (value) =>
                                    _formKey.currentState!.value["password"] !=
                                            value
                                        ? "Password didn't match"
                                        : null
                              ]),
                            ),
                          ),
                          FormBuilderCheckbox(
                            initialValue: _termsAccepted,
                            name: "termsAccepted",
                            onChanged: (value) {
                              setState(() {
                                _termsAccepted = value!;
                              });
                            },
                            title: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Accept terms and conditions",
                                    overflow: TextOverflow
                                        .ellipsis, // Handle overflow by ellipsis if needed
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => showTermsDialog(
                                      context), // Show terms dialog on tap
                                  child: const Text(
                                    " (Terms)",
                                    style: TextStyle(
                                      color: Colors
                                          .blue, // Change color to indicate it's a link
                                      decoration: TextDecoration
                                          .underline, // Add underline to indicate it's a link
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // FormBuilderCheckbox(
                          //   initialValue: false,
                          //   name: "termsAccepted",
                          //   validator: FormBuilderValidators.compose([
                          //     FormBuilderValidators.required(),
                          //     (value) => value == false
                          //         ? "You must accept terms and conditions"
                          //         : null
                          //   ]),
                          //   title: const Text("Accept terms and conditions"),
                          // ),

                          const SizedBox(height: Constants.SPACING),
                          Consumer(
                            builder: (context, ref, child) {
                              final authState = ref.watch(authStateProvider);
                              return Button(
                                loading: _loading,
                                title: "Register",
                                backgroundColor: theme.colorScheme.primary,
                                textColor: Colors.white,
                                onPress: () {
                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!
                                          .saveAndValidate()) {
                                    final formState =
                                        _formKey.currentState!.value;
                                    setState(() {
                                      _loading = true;
                                    });
                                    final authNotifier =
                                        ref.read(authStateProvider.notifier);
                                    authNotifier
                                        .register(formState)
                                        .then((value) {
                                      //     Update user state
                                      ref.read(userProvider.notifier).getUser();
                                    }).then((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Registration successful!,'),
                                        ),
                                      );
                                      // context.goNamed(RouteNames.VERIFY_ACCOUNT);
                                    }).catchError((error) {
                                      handleResponseError(
                                        context,
                                        _formKey.currentState!.fields,
                                        error,
                                        authNotifier.logout,
                                      );
                                    }).whenComplete(() {
                                      if (mounted) {
                                        setState(() {
                                          _loading = false;
                                        });
                                      }
                                    });
                                  }
                                },
                              );
                            },
                          ),
                          const SizedBox(height: Constants.SPACING),
                          LinkedRichText(
                            mainAxisAlignment: MainAxisAlignment.start,
                            linked: "Already have account? ",
                            unlinked: "Login",
                            onPress: () =>
                                context.goNamed(RouteNames.LOGIN_SCREEN),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
