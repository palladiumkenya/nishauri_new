import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

class BMICalculatorScreen extends HookWidget {
  const BMICalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
              title: "BMI Calculator",
              subTitle: "Empower Your Health Journey \nWith BMI Insights",
              icon: Icons.calculate_outlined),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Constants.SPACING),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose your gender",
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: Constants.SPACING),
                    const Row(
                      children: [
                        AppCard(
                          child: Column(
                            children: [
                              Icon(Icons.male),
                              Text("Male"),
                            ],
                          ),
                        ),AppCard(
                          child: Column(
                            children: [
                              Icon(Icons.female),
                              Text("Female"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
