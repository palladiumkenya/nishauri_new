import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/appointment/art_appointment.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/orders/forms/DeliveryInformation.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/orders/forms/DeliveryPreference.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/orders/forms/GettingStated.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/orders/forms/ReviewAndSubmit.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';

class DrugOrderWizardFormScreen extends HookConsumerWidget {
  final ARTAppointment? artAppointment;
  final ARTEvent? artEvent;
  final String? type;

  const DrugOrderWizardFormScreen(
      {super.key, this.artAppointment, this.artEvent, this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final currentStep = useState<int>(0);
    final theme = Theme.of(context);
    final loading = useState<bool>(false);

    final stepFieldsToValidate = [
      ["mode", "type", "event", "appointment", "careReceiver"],
      [
        "deliveryMethod",
        "courierService",
        "deliveryPersonFullName",
        "deliveryPersonNationalId",
        "deliveryPersonPhoneNumber",
        'pickupTime'
      ],
      ["phoneNumber", "deliveryLocation"],
    ];

    List<Step> steps = [
      Step(
        title: const Text("Getting Started"),
        subtitle: const Text(
          "Please confirm the details",
        ),
        content: GettingStarted(
          artAppointment: artAppointment,
          artEvent: artEvent,
          type: type,
        ),
        isActive: currentStep.value == 0,
      ),
      Step(
        title: const Text("Delivery preference"),
        subtitle: const Text(
          "These information will help us know how you prefer you drugs delivered",
        ),
        content: const DeliveryPreference(),
        isActive: currentStep.value == 1,
      ),
      Step(
        title: const Text("Delivery Information"),
        subtitle: const Text(
          "These information will help delivery person locate you and reach out",
        ),
        content: const DeliveryInformation(),
        isActive: currentStep.value == 2,
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
                  "Thank you for filling your request details! Your information will help us deliver your drugs to you door step at you convenience",
                ),
                const SizedBox(height: Constants.SPACING),
                const Text(
                    "Review your information for accuracy before submission.")
              ],
            ),
          ),
        ),
        isActive: currentStep.value == 3,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Request drug delivery"),
      ),
      body: FormBuilder(
        key: formKey,
        child: Stepper(
          currentStep: currentStep.value,
          steps: steps,
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
              formKey.currentState!.fields[field]?.validate() == false)) {
                return; //Don't move to next step if current step not valid
              }
            }
            if (isLastStep) {
              // Submit form
              // handleSubmit();
            } else {
              currentStep.value += 1;
            }
          },
          onStepTapped: (step) {
            currentStep.value = step;
          },
          controlsBuilder: (context, details) {
            return Row(
              children: [
                Expanded(
                  child: Builder(builder: (context) {
                    bool isLastStep = (currentStep.value == steps.length - 1);
                    if (isLastStep) {
                      return Button(
                        onPress: () async {
                          final results = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Confirm Details Entered"),
                              content: SizedBox(
                                width: double.maxFinite,
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
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
    );
  }
}
