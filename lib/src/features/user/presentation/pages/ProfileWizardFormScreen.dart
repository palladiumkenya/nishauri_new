import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/user/presentation/forms/forms.dart';

class ProfileWizardFormScreen extends StatefulWidget {
  const ProfileWizardFormScreen({super.key});

  @override
  State<ProfileWizardFormScreen> createState() =>
      _ProfileWizardFormScreenState();
}

class _ProfileWizardFormScreenState extends State<ProfileWizardFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController phoneNumber;
  late TextEditingController email;
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController dateOfBirth;
  late TextEditingController gender;
  late TextEditingController image;

  String? _image;

  List<Step> get steps => [
        Step(
          title: const Text("Account setup"),
          subtitle: const Text(
            "Create your account to personalize your healthcare experience.",
          ),
          content: AccountInformation(
            username: username,
            phoneNumber: phoneNumber,
            email: email,
          ),
          isActive: currentStep == 0,
        ),
        Step(
          title: const Text("Personal Information"),
          subtitle: const Text(
            "Provide basic personal details for a comprehensive profile.",
          ),
          content: PersonalInformation(
              image: image,
              firstName: firstName,
              dateOfBirth: dateOfBirth,
              gender: gender,
              lastName: lastName),
          isActive: currentStep == 1,
        ),
        Step(
          title: const Text("Contact Details"),
          subtitle: const Text(
              "Share your contact information for communication purposes."),
          content: const ContactInformation(),
          isActive: currentStep == 2,
        ),
        Step(
          title: const Text("Health Information"),
          subtitle: const Text(
              " Share important health details for better healthcare assistance."),
          content: const HealthInformation(),
          isActive: currentStep == 3,
        ),
        Step(
          title: const Text("Physical Characteristics"),
          subtitle: const Text(
              "Provide information about your physical attributes for a more comprehensive"),
          content: const PhysicalCharacteristicInformation(),
          isActive: currentStep == 4,
        ),
        Step(
          title: const Text("Medical History"),
          subtitle:
              const Text("Share your medical history for personalized care"),
          content: const MedicalHistoryInformation(),
          isActive: currentStep == 5,
        ),
        Step(
          title: const Text(" Location Details"),
          subtitle: const Text(
              " Inform us about your residence for context-specific healthcare information."),
          content: const LocationInformation(),
          isActive: currentStep == 6,
        ),
        Step(
          title: const Text("Lifestyle Information"),
          subtitle: const Text(
              "Share aspects of your lifestyle that may influence your health."),
          content: const LifeStyleInformation(),
          isActive: currentStep == 7,
        ),
        Step(
          title: const Text("Emergency Contacts"),
          subtitle: const Text(
              "Provide contact details for individuals we can reach in emergencies."),
          content: const EmergencyContactInformation(),
          isActive: currentStep == 8,
        ),
        Step(
          title: const Text("Review and Submit"),
          subtitle: const Text(
            "Thank you for completing your patient profile! Your information will help us provide you with better healthcare."
            "Review your information for accuracy before submission.",
          ),
          content: const ReviewAndSubmit(),
          isActive: currentStep == 9,
        ),
      ];

  @override
  void initState() {
    super.initState();
    firstName = TextEditingController();
    username = TextEditingController();
    lastName = TextEditingController();
    phoneNumber = TextEditingController();
    email = TextEditingController();
    dateOfBirth = TextEditingController();
    gender = TextEditingController();
    image = TextEditingController();
    image.addListener(() {
      debugPrint("*********|${image.text}|*******");
    });
  }

  @override
  void dispose() {
    firstName.dispose();
    username.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    email.dispose();
    dateOfBirth.dispose();
    image.dispose();
    gender.dispose();
    super.dispose();
  }

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Update profile"),
      ),
      body: Form(
        child: Stepper(
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
            if (isLastStep) {
              //Do something with this information
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
        ),
      ),
    );
  }
}
