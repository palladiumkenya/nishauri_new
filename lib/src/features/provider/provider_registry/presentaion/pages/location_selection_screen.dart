import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/provider/provider_registry/data/providers/provider_registry_provider.dart';
import 'package:nishauri/src/features/provider/provider_registry/presentaion/forms/forms.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';

class LocationSelectionScreen extends HookConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final theme = Theme.of(context);
    final currentStep = useState<int>(0);
    final loading = useState<bool>(false);
    final usrProvider = ref.watch(getProviderDetailsProvider);

    final providerName = usrProvider.when(data: (data) => data.family_name, error: (error, stack) => false,
      loading: () => false);
    final salutation = usrProvider.when(data: (data) => data.salutation, error: (error, stack) => false,
        loading: () => false);

    List<Step> steps = [
      Step(
        title: const Text("Provider Information"),
        subtitle: const Text("Confirm your Registration details"),
        content: const ProviderRegistry(),
        isActive: currentStep.value == 0,
      ),
      Step(
        title: const Text("Provider Information"),
        subtitle: const Text("Confirm your Registration details"),
        content: const LocationInformation(),
        isActive: currentStep.value == 1,
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
                  "Thank you for selecting your service facility!",
                ),
                const SizedBox(height: Constants.SPACING),
                const Text(
                    "Review your information for accuracy before submission.")
              ],
            ),
          ),
        ),
        isActive: currentStep.value == 2,
      ),
    ];

    final stepFieldsToValidate = [
      ["family_name"],
      ["facility_mfl"],
    ];

    void handleSubmit() {
      // Implement form submission logic here
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView( // Wrap in SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                title: "Provider Profile Update 📋",
                color: Constants.providerBgColor,
              ),
              const SizedBox(height: 10),
              Text("Welcome ${salutation} ${providerName}", style: theme.textTheme.titleMedium),
              const SizedBox(height: 20),
              Text("Confirm your details and update your current location/facility.", style: theme.textTheme.bodyLarge),
              const SizedBox(height: 20),
              FormBuilder(
                key: formKey,
                child: Stepper(
                  connectorColor: MaterialStateProperty.resolveWith((states) {
                    // Return a color based on the states, or null for default
                    if (states.contains(MaterialState.selected)) {
                      return Constants.providerBgColor; // Color when selected
                    }
                    return Colors.grey; // Default color
                  }),
                  // connectorColor: MaterialStateProperty.all(Constants.providerBgColor),
                  currentStep: currentStep.value,
              onStepCancel: () {
                if (currentStep.value > 0) {
                  currentStep.value -= 1;
                }
              },
              onStepContinue: () {
                bool isLastStep = (currentStep.value == steps.length - 1);

                // Validate fields
                if (!isLastStep) {
                  final currentStepFields = stepFieldsToValidate[currentStep.value];
                  if (currentStepFields.any((field) => !formKey.currentState!.fields[field]!.validate())) {
                    return;
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
                        bool isLastStep = (currentStep.value == steps.length - 1);
                        if (isLastStep) {
                          return Button(
                            onPress: () async {
                              final results = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Confirm Location Details Entered"),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    height: MediaQuery.of(context).size.height * 0.5,
                                    child: SingleChildScrollView(
                                      child: ReviewAndSubmitLocation(
                                        formState: formKey.currentState!.instantValue,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Button(
                                            title: "Submit",
                                            onPress: () {
                                              context.pop(1);
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Button(
                                            title: "Cancel",
                                            onPress: context.pop,
                                            titleStyle: theme.textTheme.titleLarge?.copyWith(
                                              color: Constants.providerBgColor,
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
                              color: Constants.providerBgColor,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return Button(
                          onPress: details.onStepContinue,
                          title: 'Next',
                          disabled: loading.value,
                          titleStyle: theme.textTheme.titleSmall?.copyWith(
                            color: Constants.providerBgColor,
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
                        titleStyle: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: Constants.SPACING),
                    const Expanded(child: SizedBox()), // Placeholder for alignment
                  ],
                );
              },
            ),
          ),
        ],
      ),
      ),
    ),
    );
  }
}
