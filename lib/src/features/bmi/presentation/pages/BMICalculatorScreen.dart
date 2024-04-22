import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/GenderPicker.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/HeightPicker.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/HeightUnitsPicker.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class BMICalculatorScreen extends HookWidget {
  const BMICalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gender = useState<GenderPickerChoices>(GenderPickerChoices.male);
    final height = useState<double>(18);
    final heightUnits = useState<HeightUnitsPickerOptions>(HeightUnitsPickerOptions.In);

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
                    GenderPicker(
                      gender: gender.value,
                      onGenderChange: (gender_) => gender.value = gender_,
                    ),
                    const SizedBox(height: Constants.SPACING),
                    HeightPicker(
                      height: height.value,
                      heightUnits: heightUnits.value,
                      onHeightChange: (height_) {
                        height.value = height_;
                      },
                      onHeightUnitsChange: (units) {
                        heightUnits.value = units;
                      },
                    ),
                    const SizedBox(height: Constants.SPACING),
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
