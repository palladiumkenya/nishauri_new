import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/dawa_drop/data/providers/drug_order_provider.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/request_order/forms/DeliveryInformation.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/request_order/forms/DeliveryPreference.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/request_order/forms/GettingStated.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/request_order/forms/ReviewAndSubmit.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

import '../../../../../shared/exeptions/http_exceptions.dart';
import '../../../../../utils/helpers.dart';
import '../../../../auth/data/providers/auth_provider.dart';

class DrugOrderWizardFormScreen extends HookConsumerWidget {
  final Appointment? artAppointment;
  final ARTEvent? artEvent;
  final String? type;

  const DrugOrderWizardFormScreen(
      {super.key, this.artAppointment, this.artEvent, this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final currentStep = useState<int>(1);
    final theme = Theme.of(context);
    final loading = useState<bool>(false);

    final stepFieldsToValidate = [
      ["mode", "order_type", "appointment"],
      [
        "delivery_method",
        "courier_service",
        "delivery_person",
        "delivery_person_id",
        "delivery_person_contact",
        "delivery_pickup_time"
      ],
      [
        "client_phone_no",
        "delivery_address",
        "delivery_estate",
        "delivery_apartment"
      ],
    ];

    List<Step> steps = [
      Step(
        // title: const Text("Getting Started"),
        title: const Text("Appointment Details"),
        // subtitle: const Text(
        //   "Please confirm the details",
        // ),
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

    void handleSubmit() {
      final deliveryEstate =
          formKey.currentState!.instantValue["delivery_estate"].toString();
      final deliveryApartment =
          formKey.currentState!.instantValue["delivery_apartment"].toString();
      final deliveryAddress =
          formKey.currentState!.instantValue["delivery_address"] +
              ", $deliveryEstate, $deliveryApartment";
      if (formKey.currentState!.validate()) {
        debugPrint(
            "=====================>${formKey.currentState?.instantValue}");
        loading.value = true;
        final pickupTime =
            formKey.currentState!.instantValue["delivery_pickup_time"];
        final courierService =
            formKey.currentState!.instantValue["courier_service"].toString();

        ref.read(drugOrderProvider.notifier).createOrder({
          ...formKey.currentState!.instantValue,
          "delivery_address": deliveryAddress,
          "delivery_pickup_time": pickupTime is DateTime
              ? pickupTime.toIso8601String()
              : pickupTime,
          "delivery_lat": "",
          "delivery_long": "",
          ...(formKey.currentState?.instantValue["delivery_method"] == "parcel"
              ? {
                  // "delivery_person": "",
                  // "delivery_person_id": "",
                  // "delivery_person_contact": "",
                  // "delivery_pickup_time":"",
                  "courier_service": courierService,
                  "delivery_method": "In Parcel",
                }
              : {
                  "courier_service": "",
                  "delivery_method": "In Person",
                }),
          ...(formKey.currentState?.instantValue["delivery_method"] == "person"
              ? {
                  "deliveryPerson": {
                    "fullName":
                        formKey.currentState!.instantValue["delivery_person"],
                    "nationalId": formKey
                        .currentState!.instantValue["delivery_person_id"],
                    "phoneNumber": formKey
                        .currentState!.instantValue["delivery_person_contact"],
                    "pickupTime": formKey
                        .currentState!.instantValue["delivery_pickup_time"],
                  }
                }
              : {})
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Drug delivery request was a success!")));
          context.goNamed(
            RouteNames.HIV_DRUG_ORDERS,
          );
        }).catchError((e) {
          switch (e) {
            case BadRequestException e:
              handleResponseError(context, formKey.currentState!.fields, e,
                  ref.read(authStateProvider.notifier).logout);
              //   Navigate to 1st step with the error
              final fieldStep = stepFieldsToValidate.indexWhere((fields) =>
                  fields.any((field) => e.errors.containsKey(field)));
              currentStep.value = fieldStep;
              break;
            default:
              handleResponseError(context, formKey.currentState!.fields, e,
                  ref.read(authStateProvider.notifier).logout);
              debugPrint("[DRUG-ORDER-WIZARD]: ${e.toString()}");
          }
        }).whenComplete(() => loading.value = false);
      } else {
        //   if invalid then navigate to the 1st step with errors
        final fieldStep = stepFieldsToValidate.indexWhere((fields) =>
            fields.any((field) =>
                formKey.currentState!.fields[field]?.hasError == true));
        currentStep.value = fieldStep;
      }
    }

    debugPrint("${currentStep.value}");
    return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     onPressed: () => context.pop(),
        //     icon: const Icon(Icons.chevron_left),
        //   ),
        //   title: const Text("Request drug delivery"),
        // ),
        body: Column(
      children: [
        CustomAppBar(
          title: "Request drug delivery",
          icon: Icons.shopping_cart,
          color: Constants.dawaDropColor.withOpacity(0.5),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: formKey,
              child: Stepper(
                currentStep: currentStep.value,
                steps: steps,
                onStepCancel: () {
                  currentStep.value == 1 ? null : currentStep.value -= 1;
                },
                onStepContinue: () {
                  bool isLastStep = (currentStep.value == steps.length - 1);
                  // 1.validate current step fields and prevent continue encase of any error in current step
                  if (!isLastStep) {
                    final currentStepFields =
                        stepFieldsToValidate[currentStep.value];

                    if (currentStepFields.any((field) =>
                        formKey.currentState!.fields[field]?.validate() ==
                        false)) {
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
                                    title:
                                        const Text("Confirm Details Entered"),
                                    content: SizedBox(
                                      width: double.maxFinite,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      child: SingleChildScrollView(
                                        child: ReviewAndSubmit(
                                          formState: formKey
                                              .currentState!.instantValue,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      Row(
                                        // Wrap buttons inside a Row
                                        children: [
                                          Expanded(
                                            // Ensures buttons take equal width
                                            child: Button(
                                              title: "Submit",
                                              onPress: () {
                                                context.pop(1);
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                              width: Constants
                                                  .SPACING), // Add some space between buttons
                                          Expanded(
                                            child: Button(
                                              title: "Cancel",
                                              onPress: context.pop,
                                              titleStyle: theme
                                                  .textTheme.titleLarge
                                                  ?.copyWith(
                                                color: theme.colorScheme.error,
                                              ),
                                            ),
                                          ),
                                        ],
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
      ],
    ));
  }
}
