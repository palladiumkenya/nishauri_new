import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/user/data/models/user.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/features/user/presentation/forms/forms.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/utils/routes.dart';

final _data = {
  "username": "omosh",
  "image": null,
  "firstName": "",
  "lastName": "",
  "dateOfBirth": null,
  "gender": null,
  "email": "lawiomosh3@gmail.com",
  "phoneNumber": "254793889658",
  "county": null,
  "constituency": null,
  "bloodGroup": null,
  "allergies": [],
  "disabilities": [],
  "chronics": [],
  "weight": null,
  "height": null,
  "maritalStatus": null,
  "educationLevel": null,
  "primaryLanguage": null,
  "occupation": null
};

class ProfileWizardFormScreen extends HookConsumerWidget {
  const ProfileWizardFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final currentStep = useState<int>(0);

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
        subtitle: const Text(
          "Thank you for completing your patient profile! Your information will help us provide you with better healthcare."
          "Review your information for accuracy before submission.",
        ),
        content: const ReviewAndSubmit(),
        isActive: currentStep.value == 6,
      ),
    ];

    void handleSubmit() async {
      if (formKey.currentState!.saveAndValidate()) {
        try {
          await ref
              .read(userProvider.notifier)
              .updateUser(User.fromJson(formKey.currentState!.value))
              .then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Profile updated successfully!")),
                ),
              );
          ref.read(authStateProvider.notifier).markProfileAsUpdated();
        } on ValidationException catch (e) {
          for (var err in e.errors.entries) {
            formKey.currentState!.fields[err.key]?.invalidate(err.value);
          }
        } catch (e) {
          debugPrint("[PROFILE-WIZARD]: ${e.toString()}");
        }
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
          child: FormBuilder(
            key: formKey,
            child: Stepper(
              currentStep: currentStep.value,
              onStepCancel: () {
                currentStep.value == 0 ? null : currentStep.value -= 1;
              },
              onStepContinue: () {
                formKey.currentState?.saveAndValidate();
                debugPrint(formKey.currentState?.value.toString());
                debugPrint(formKey.currentState?.errors.toString());

                bool isLastStep = (currentStep.value == steps.length - 1);
                // Validate the current step
                if (isLastStep) {
                  // Submit form
                  handleSubmit();
                } else {
                  // if (formKey.currentState!.validate()) {
                  currentStep.value += 1;
                  // }
                }
              },
              onStepTapped: (step) => currentStep.value = step,
              steps: steps,

            ),
          ),
        ),
      ),
    );
  }
}
