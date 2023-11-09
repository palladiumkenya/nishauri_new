import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/user/presentation/forms/AccountInformation.dart';
import 'package:nishauri/src/features/user/presentation/forms/PersonalInformation.dart';

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
            title: const Text("Account Info"),
            subtitle: const Text("Unique account information"),
            content: AccountInformation(
              username: username,
              phoneNumber: phoneNumber,
              email: email,
            ),
            isActive: currentStep == 0),
        Step(
            title: const Text("Personal Info"),
            subtitle: const Text("Reasons for collecting information"),
            content: PersonalInformation(
              image: image,
                firstName: firstName,
                dateOfBirth: dateOfBirth,
                gender: gender,
                lastName: lastName),
            isActive: currentStep == 1),
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
    image.addListener(() { debugPrint("*********|${image.text}|*******");});
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
