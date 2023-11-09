import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final List<Map<String, String>> _heightUnitChoices = [
    {"value": "m", "label": "Metres"},
    {"value": "cm", "label": "Centimetres"},
    {"value": "in", "label": "Inches"},
    {"value": "ft", "label": "Foot"}
  ];

  final List<Map<String, String>> _weightUnitChoices = [
    {"value": "kg", "label": "Kilograms"},
    {"value": "g", "label": "Grams"},
    {"value": "lb", "label": "Pounds"},
  ];

  final List<Map<String, String>> genderChoices = [
    {"label": 'Female', 'value': "F"},
    {"label": 'Male', 'value': "M"},
  ];

  final _formKey = GlobalKey<FormState>();
  var weight = TextEditingController();
  var height = TextEditingController();
  var gender = TextEditingController();
  var age = TextEditingController();

  late String heightUnits;
  late String weightUnits;
  late bool isPregnant;
  late bool _showSwitch = genderChoices.first["value"] == 'F';
  late bool _disableForm = true;

  double? bmi;

  @override
  void initState() {
    super.initState();
    heightUnits = _heightUnitChoices.first["value"]!;
    weightUnits = _weightUnitChoices.first['value']!;
    isPregnant = true;
  }

  @override
  void dispose() {
    weight.dispose();
    height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        void handleSubmit() async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            final _age = int.tryParse(age.text) ?? 0;

            if (_age < 5 || isPregnant) {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Warning!"),
                  content: const Text(
                    "Cant calculate BMI for person under age of 5 and for pregnant women",
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text("Ok")),
                  ],
                ),
              );
              return;
            }
            setState(() {
              bmi = calculateBMI(
                  heightUnits,
                  weightUnits,
                  double.tryParse(weight.text) ?? 0.0,
                  double.tryParse(height.text) ?? 0.0);
            });
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Calculator"),
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.chevron_left),
            ),
          ),
          body: ResponsiveWidgetFormLayout(
            buildPageContent: (BuildContext context, Color? color) => SafeArea(
              child: Container(
                padding: const EdgeInsets.all(Constants.SPACING * 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: Constants.SPACING),
                        DecoratedBox(
                          decoration: const BoxDecoration(),
                          child: Image.asset(
                            "assets/images/bmi_scale.png",
                            fit: BoxFit.contain,
                            // height: 200,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "BMI Calculator",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        const Text(
                          "This tool calculates you body-mass index\n",
                          style: TextStyle(color: Colors.black26),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        Row(
                          children: [
                            Flexible(
                              child: FormInputTextField(
                                controler: age,
                                keyboardType: TextInputType.number,
                                placeholder: "e.g 28",
                                prefixIcon: Icons.speed,
                                label: "Age",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide age';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: Constants.SPACING),
                            DropdownMenu<String>(
                              label: const Text("Gender"),
                              leadingIcon: const IconButton(
                                onPressed: null,
                                icon: Icon(Icons.accessibility_outlined),
                              ),
                              initialSelection: genderChoices.first["value"],
                              controller: gender,
                              onSelected: (value) {
                                setState(() {
                                  _showSwitch = gender.text == 'Female';
                                });
                              },
                              dropdownMenuEntries: genderChoices
                                  .map<DropdownMenuEntry<String>>(
                                    (Map<String, String> gender) =>
                                        DropdownMenuEntry<String>(
                                      value: gender['value']!,
                                      label: gender['label']!,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        if (_showSwitch)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("Pregnant: "),
                              Switch(
                                value: isPregnant,
                                onChanged: (bool value) {
                                  setState(() {
                                    isPregnant = !isPregnant;
                                  });
                                },
                              ),
                            ],
                          ),
                        const SizedBox(height: Constants.SPACING),
                        FormInputTextField(
                          keyboardType: TextInputType.number,
                          controler: weight,
                          placeholder: "e.g 60.0",
                          prefixIcon: Icons.monitor_weight,
                          label: "Weight",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Weight is required';
                            }
                            return null;
                          },
                          surfixIcon: DropdownButton<String>(
                            value: weightUnits,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                weightUnits = newValue!;
                              });
                            },
                            items: _weightUnitChoices
                                .map((Map<String, String> pair) {
                              return DropdownMenuItem<String>(
                                value: pair["value"],
                                child: Text(pair["label"]!),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        FormInputTextField(
                          keyboardType: TextInputType.number,
                          controler: height,
                          placeholder: "e.g 2",
                          prefixIcon: Icons.height,
                          label: "Height",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Height is required';
                            }
                            return null;
                          },
                          surfixIcon: DropdownButton<String>(
                            value: heightUnits,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                heightUnits = newValue!;
                              });
                            },
                            items: _heightUnitChoices
                                .map((Map<String, String> pair) {
                              return DropdownMenuItem<String>(
                                value: pair["value"],
                                child: Text(pair["label"]!),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        LinkedRichText(
                          linked: "Your BMI:  ",
                          unlinked: bmi != null ? bmi!.toStringAsFixed(1) : "_",
                          unlinkedStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        LinkedRichText(
                          linked: "BMI status:  ",
                          unlinked: bmi != null ? getBMIStatus(bmi!) : "_",
                          unlinkedStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: Constants.SPACING),
                        Button(
                          title: "Calculate",
                          onPress: handleSubmit,
                        ),

                        const SizedBox(
                          height: Constants.SPACING,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
