import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';


class BMICalculatorResultsScreen extends StatelessWidget {
  final double bmi;

  const BMICalculatorResultsScreen({super.key, required this.bmi});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(children: [
        const CustomAppBar(title: "BMI Calculator", icon: Icons.calculate),
        Expanded(
          child: SingleChildScrollView(
            child: AppCard(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Your BMI is",
                                      style: theme.textTheme.titleMedium),
                                  Text(
                                    getBMIStatus(bmi),
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      color: Colors.green,
                                    ),
                                  ),
                                ]),
                            Padding(
                              padding: const EdgeInsets.all(Constants.SPACING),
                              child: Text(
                                bmi.toStringAsFixed(1),
                                style: theme.textTheme.displayLarge?.copyWith(
                                    color: theme.colorScheme.primary),
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
                    Text(
                      getBMIStatus(bmi),
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
                    // Markdown(data: "data")
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
