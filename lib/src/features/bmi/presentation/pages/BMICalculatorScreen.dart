import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/GenderPicker.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/HeightPicker.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/HeightUnitsPicker.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/RadioGroup.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/QuanterSizer.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class BMICalculatorScreen extends HookWidget {
  const BMICalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const activeColor = Constants.activeSelectionColor;
    final gender = useState<GenderPickerChoices>(GenderPickerChoices.male);
    final isPregnant = useState(false);
    final height = useState<double>(180);
    final heightUnits =
        useState<HeightUnitsPickerOptions>(HeightUnitsPickerOptions.In);
    final weight = useState<int>(65);
    final age = useState<int>(27);
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "BMI Calculator ⚖️",
            subTitle: "Empower Your Health Journey \nWith BMI Insights",
            // icon: Icons.calculate_outlined,
            color: Constants.bmiCalculatorColor,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: AppCard(
                child: Padding(
                  padding: const EdgeInsets.all(Constants.SPACING * 0.5),
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
                        onGenderChange: (gender_) {
                          if (gender_ == GenderPickerChoices.female) {
                            showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                  title: const Text("Warning!"),
                                  content: SingleChildScrollView(
                                    child: Wrap(
                                      children: [
                                        const Text(
                                          "BMI Calculation for pregnant lady is highly discouraged and not supported to avoid drastic decisions.Please confirm your pregnancy status",
                                        ),
                                        RadioGroup(
                                          // value: pregnant.value ? "no":"yes",
                                          onValueChanged: (val) {
                                            context.pop(val == "no");
                                          },
                                          items: [
                                            RadioGroupItem(
                                                value: "yes",
                                                title: "Not Pregnant",
                                                icon: Icons.woman_rounded),
                                            RadioGroupItem(
                                                value: "no",
                                                title: "Pregnant",
                                                icon: Icons.pregnant_woman),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ).then((isPregnant_) {
                              if (isPregnant_ != null) {
                                if (isPregnant_ == false) {
                                  gender.value = gender_;
                                  isPregnant.value = false;
                                } else {
                                  gender.value = gender_;
                                  isPregnant.value = true;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "BMI calculation for pregnant lady ain't supported")));
                                }
                              }
                            });
                          } else {
                            gender.value = gender_;
                          }
                        },
                        activeColor: activeColor,
                      ),
                      const SizedBox(height: Constants.SPACING),
                      HeightPicker(
                        activeColor: activeColor,
                        height: height.value,
                        heightUnits: heightUnits.value,
                        onHeightChange: (height_) {
                          print(height.value);
                          height.value = height_;
                        },
                        onHeightUnitsChange: (units) {
                          print(heightUnits.value);
                          heightUnits.value = units;
                        },
                      ),
                      const SizedBox(height: Constants.SPACING),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Quantizer(
                            min: 20,
                            max: 300,
                            value: weight.value,
                            onValueChange: (value) => weight.value = value,
                            label: "Weight",
                            units: "Kgs",
                            activeColor: activeColor,
                          ),
                          Quantizer(
                            min: 5,
                            max: 100,
                            value: age.value,
                            onValueChange: (value) => age.value = value,
                            label: "Age",
                            units: "Years",
                            activeColor: activeColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: Constants.SPACING),
                      Button(
                        title: "Calculate",
                        surfixIcon: SvgPicture.asset(
                          "assets/images/refresh-circle.svg",
                          semanticsLabel: "Doctors",
                          fit: BoxFit.contain,
                        ),
                        disabled: isPregnant.value,
                        backgroundColor: activeColor,
                        textColor: theme.canvasColor,
                        onPress: () {             
                          // final bmi = calculateBMI(height.value, weight.value);
                          // context.goNamed(RouteNames.BMI_CALCULATOR_RESULTS,
                          //     extra: bmi);
                          showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Calculate BMI"),
                              content: const Text("Are you calculating BMI for yourself or someone else?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false); 
                                  },
                                  child: const Text("Someone Else"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true); 
                                  },
                                  child: const Text("Myself"),
                                ),
                              ],
                            ),
                          ).then((isForSelf) {
                            //final heightInCm = convertToCmFrom(heightUnits.value, height.value);
                            final bmi = calculateBMI(height.value, weight.value);
                            print('height.value: ${height.value}');
                            print('bmi: $bmi');
                            if (isForSelf != null) {
                              if (isForSelf) {
                                saveBMI(bmi).then((_) {
                                  
                                  context.goNamed(RouteNames.BMI_CALCULATOR_RESULTS, extra: bmi);
                                });
                              } else {
                                context.goNamed(RouteNames.BMI_CALCULATOR_RESULTS, extra: bmi);
                              }
                            }
                          }
                          );
                          }         
                      ),
                      const SizedBox(height: Constants.SPACING),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Awaiting Endpoints
Future<void> saveBMI(double bmi) async {
      // Will add logic to save the BMI to the endpoint when provided
      print("Saving BMI $bmi to the endpoint...");
      // await MyApiService.saveBMI(bmi);
    }

