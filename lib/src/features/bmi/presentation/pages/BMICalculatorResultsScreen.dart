import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/bmi/data/providers/bmi_status_nutrition_provider.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class BMICalculatorResultsScreen extends HookConsumerWidget {
  final double bmi;

  const BMICalculatorResultsScreen({super.key, required this.bmi});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final bmiStatusNutritionAsync = ref.watch(bmiNutritionProvider);
    return Scaffold(
      body: Column(children: [
        const CustomAppBar(
            title: "BMI Calculator",
            icon: Icons.calculate,
            color: Constants.bmiCalculatorColor),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Constants.SPACING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Results",
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(Constants.SPACING),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Your BMI is",
                                    style: theme.textTheme.titleMedium),
                                Text(
                                  getBMIStatusSimplified(bmi),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: Constants.activeSelectionColor,
                                  ),
                                ),
                              ]),
                          Padding(
                            padding: const EdgeInsets.all(Constants.SPACING),
                            child: Text(
                              bmi.toStringAsFixed(1),
                              style: theme.textTheme.displayLarge
                                  ?.copyWith(color: theme.colorScheme.primary),
                            ),
                          ),
                          Slider(
                            value: bmi,
                            onChanged: (value) {},
                            min: 0,
                            max: 60,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Constants.SPACING),
                  bmiStatusNutritionAsync.when(
                    data: (data) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getBMIStatusSimplified(bmi),
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        Text(
                          "Diet & Nutrition",
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        Text(
                          data
                                  .where((element) =>
                                      element.status ==
                                      getBMIStatusSimplified(bmi))
                                  .first
                                  .description ??
                              "",
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    error: (e, stackTrace) => Align(
                        alignment: Alignment.center,
                        child: Text(e.toString())),
                    loading: () => const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  ),

                  // Markdown(data: "data")
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
