import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/features/user/presentation/forms/forms.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class ProfileWizardFormScreen extends HookConsumerWidget {
  const ProfileWizardFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final currentStep = useState<int>(0);
    final theme = Theme.of(context);
    final loading = useState<bool>(false);

    final stepFieldsToValidate = [
      ["image", "username"],
      ["f_name", "l_name", "dob", "gender"],
      ["email", "phone_no", "county", "landmark"],
      ["blood_group", "allergies", "disabilities", "chronics"],
      ["weight", "height"],
      ["marital", "education", "primary_language", "occupation"],
    ];

    List<Step> steps = [
      Step(
        title: const Text("Account setup"),
        subtitle: const Text(
          "Create your account to personalize your healthcare experience.",
        ),
        content: const AccountInformation(),
        isActive: currentStep.value == 0,
      ),
      Step(
        title: const Text("Personal Information"),
        subtitle: const Text(
          "Provide basic personal details for a comprehensive profile.",
        ),
        content: const PersonalInformation(),
        isActive: currentStep.value == 1,
      ),
      Step(
        title: const Text("Contact Details"),
        subtitle: const Text(
            "Share your contact information for communication purposes."),
        content: const ContactInformation(),
        isActive: currentStep.value == 2,
      ),
      Step(
        title: const Text("Health Information"),
        subtitle: const Text(
            " Share important health details for better healthcare assistance."),
        content: const HealthInformation(),
        isActive: currentStep.value == 3,
      ),
      Step(
        title: const Text("Physical Characteristics"),
        subtitle: const Text(
            "Provide information about your physical attributes for a more comprehensive"),
        content: const PhysicalCharacteristicInformation(),
        isActive: currentStep.value == 4,
      ),
      Step(
        title: const Text("Social Information"),
        subtitle: const Text(
            "Share aspects of your lifestyle that may influence your health."),
        content: const LifeStyleInformation(),
        isActive: currentStep.value == 5,
      ),
      Step(
        title: const Text("Review and Submit"),
        content: AppCard(
          child: Padding(
            padding: const EdgeInsets.all(Constants.SPACING),
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/images/review.svg",
                  semanticsLabel: "Security",
                  fit: BoxFit.contain,
                  height: 150,
                ),
                const SizedBox(height: Constants.SPACING),
                const Text(
                  "Thank you for completing your patient profile! Your information will help us provide you with better healthcare.",
                ),
                const SizedBox(height: Constants.SPACING),
                const Text(
                    "Review your information for accuracy before submission.")
              ],
            ),
          ),
        ),
        isActive: currentStep.value == 6,
      ),
    ];

    void handleSubmit() {
      if (formKey.currentState!.validate()) {
        loading.value = true;
        final dateOfBirth = formKey.currentState!.instantValue["dob"];
        ref
            .read(userProvider.notifier)
            .updateUser(User.fromJson({
              ...formKey.currentState!.instantValue,
              "dob": dateOfBirth is DateTime
                  ? dateOfBirth.toIso8601String()
                  : dateOfBirth
            }))
            .then((value) {
          //     Update auth state and redirect to home
          return ref.read(authStateProvider.notifier).markProfileAsUpdated();
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully!")));
        }).catchError((e) {
          switch (e) {
            case BadRequestException e:
              handleResponseError(context, formKey.currentState!.fields, e, ref.read(authStateProvider.notifier).logout);
              //   Navigate to 1st step with the error
              final fieldStep = stepFieldsToValidate.indexWhere((fields) =>
                  fields.any((field) => e.errors.containsKey(field)));
              currentStep.value = fieldStep;
              break;
            default:
              handleResponseError(context, formKey.currentState!.fields, e, ref.read(authStateProvider.notifier).logout);
              debugPrint("[PROFILE-WIZARD]: ${e.toString()}");
          }
        }).whenComplete(() => loading.value = false);
      } else {
        //   if invalid then navigate to the 1st step with errors
        final fieldStep = stepFieldsToValidate.indexWhere((fields) => fields
            .any((field) => formKey.currentState!.fields[field]!.hasError));
        currentStep.value = fieldStep;
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Consumer(
            builder: (context, ref, child) {
              final authState = ref.watch(authStateProvider);
              return IconButton(
                onPressed: () {
                  try {
                    authState.whenData((value){
                      if (value.isProfileComplete) {
                        context.goNamed(RouteNames.PROFILE_SETTINGS);
                      }
                    });
                  } on GoError catch (e) {
                    debugPrint("[DEBUG-PROFILE-WIZARD]: $e");
                  }
                },
                icon: const Icon(Icons.chevron_left),
              );
            },
          ),
          title: const Text("Update profile"),
        ),
        body: SafeArea(
          child: FormBuilder(
            key: formKey,
            child: Stepper(
              currentStep: currentStep.value,
              onStepCancel: () {
                currentStep.value == 0 ? null : currentStep.value -= 1;
              },
              onStepContinue: () {
                bool isLastStep = (currentStep.value == steps.length - 1);
                // 1.validate current step fields and prevent continue encase of any error in current step
                if (!isLastStep) {
                  final currentStepFields =
                      stepFieldsToValidate[currentStep.value];

                  if (currentStepFields.any((field) =>
                      !formKey.currentState!.fields[field]!.validate())) {
                    return; //Don't move to next step if current step not valid
                  }
                }
                if (isLastStep) {
                  // Submit form
                  handleSubmit();
                } else {
                  currentStep.value += 1;
                }
              },
              onStepTapped: (step) {
                currentStep.value = step;
              },
              steps: steps,
              controlsBuilder: (context, details) {
                return Row(
                  children: [
                    Expanded(
                      child: Builder(builder: (context) {
                        bool isLastStep =
                            (currentStep.value == steps.length - 1);
                        if (isLastStep) {
                          return Button(
                            onPress: () async {
                              final results = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Confirm Details Entered"),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: SingleChildScrollView(
                                      child: ReviewAndSubmit(
                                        formState:
                                            formKey.currentState!.instantValue,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    Button(
                                      title: "Submit",
                                      onPress: () {
                                        context.pop(1);
                                      },
                                    ),
                                    Button(
                                      title: "Cancel",
                                      onPress: context.pop,
                                      titleStyle: theme.textTheme.titleLarge
                                          ?.copyWith(
                                              color: theme.colorScheme.error),
                                    ),
                                  ],
                                ),
                              );
                              if (results == 1) {
                                details.onStepContinue!();
                              }
                            },
                            title: 'Review',
                            loading: loading.value,
                            titleStyle: theme.textTheme.titleSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return Button(
                          onPress: details.onStepContinue,
                          title: 'Next',
                          disabled: loading.value,
                          titleStyle: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: Constants.SPACING),
                    Expanded(
                      child: Button(
                        onPress: details.onStepCancel,
                        title: 'Cancel',
                        disabled: loading.value,
                        titleStyle: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: Constants.SPACING),
                    Expanded(child: Container())
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
