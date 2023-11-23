import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user/presentation/forms/forms.dart';
import 'package:nishauri/src/shared/states/AppFormState.dart';
import 'package:nishauri/src/utils/routes.dart';

class ProfileWizardFormScreen extends StatefulWidget {
  const ProfileWizardFormScreen({super.key});

  @override
  State<ProfileWizardFormScreen> createState() =>
      _ProfileWizardFormScreenState();
}

class _ProfileWizardFormScreenState extends State<ProfileWizardFormScreen> {
  final _formKey = GlobalKey<FormState>();
  AppFormState formState = AppFormState(
    values: {
      "image": null,
      "username": "",
      "firstName": "",
      "lastName": "",
      "dateOfBirth": null,
      "gender": "",
      "email": "",
      "phoneNumber": "",
      "country": "",
      "constituency": "",
      "bloodGroup": "",
      "allergies": [],
      "disabilities": [],
      "chronics": [],
      "weight": "",
      "height": "",
      "maritalStatus": "",
      "primaryLanguage": "",
      "educationLevel": "",
      "occupation": ""
    },
  );

  void _handleFormFieldChanged(name, value) {
    setState(() {
      formState =
          formState.copyWith(values: {...formState.values, name: value});
    });
  }

  List<Step> get steps => [
        Step(
          title: const Text("Account setup"),
          subtitle: const Text(
            "Create your account to personalize your healthcare experience.",
          ),
          content: AccountInformation(
            formState: formState,
            onFormFieldChanged: _handleFormFieldChanged,
          ),
          isActive: currentStep == 0,
        ),
        Step(
          title: const Text("Personal Information"),
          subtitle: const Text(
            "Provide basic personal details for a comprehensive profile.",
          ),
          content: PersonalInformation(
            formState: formState,
            onFormFieldChanged: _handleFormFieldChanged,
          ),
          isActive: currentStep == 1,
        ),
        Step(
          title: const Text("Contact Details"),
          subtitle: const Text(
              "Share your contact information for communication purposes."),
          content: ContactInformation(
              onFormFieldChanged: _handleFormFieldChanged,
              formState: formState),
          isActive: currentStep == 2,
        ),
        Step(
          title: const Text("Health Information"),
          subtitle: const Text(
              " Share important health details for better healthcare assistance."),
          content: HealthInformation(
            formState: formState,
            onFormFieldChanged: _handleFormFieldChanged,
          ),
          isActive: currentStep == 3,
        ),
        Step(
          title: const Text("Physical Characteristics"),
          subtitle: const Text(
              "Provide information about your physical attributes for a more comprehensive"),
          content: PhysicalCharacteristicInformation(
            onFormFieldChanged: _handleFormFieldChanged,
            formState: formState,
          ),
          isActive: currentStep == 4,
        ),
        Step(
          title: const Text("Social Information"),
          subtitle: const Text(
              "Share aspects of your lifestyle that may influence your health."),
          content: LifeStyleInformation(
              formState: formState,
              onFormFieldChanged: _handleFormFieldChanged),
          isActive: currentStep == 5,
        ),
        Step(
          title: const Text("Review and Submit"),
          subtitle: const Text(
            "Thank you for completing your patient profile! Your information will help us provide you with better healthcare."
            "Review your information for accuracy before submission.",
          ),
          content: ReviewAndSubmit(formState: formState),
          isActive: currentStep == 6,
        ),
      ];

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
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
                    if (authState.isProfileComplete) {
                      context.goNamed(RouteNames.PROFILE_SETTINGS);
                    }
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
          child: Form(
            key: _formKey,
            child: Consumer(
              builder: (context, ref, child) {
                return Stepper(
                  currentStep: currentStep,
                  onStepCancel: () {
                    currentStep == 0
                        ? null
                        : setState(() {
                            currentStep -= 1;
                          });
                  },
                  onStepContinue: () {
                    bool isLastStep = (currentStep == steps.length - 1);
                    // Validate the current step
                    if (isLastStep) {
                      // Do something with the information on the last step
                      ref.read(authStateProvider.notifier).updateProfile(true);
                    } else {
                      setState(() {
                        currentStep += 1;
                      });
                    }
                  },
                  onStepTapped: (step) => setState(() {
                    currentStep = step;
                  }),
                  steps: steps,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
