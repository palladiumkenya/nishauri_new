import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/display/LinkedRichText.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/FormInputTextField.dart';
import 'package:nishauri/src/shared/layouts/ResponsiveWidgetFormLayout.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class BMICalculatorScreen extends HookWidget {
  const BMICalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

    final _formKey = useMemoized(() => GlobalKey<FormState>());

    var weight = useTextEditingController();
    var height = useTextEditingController();
    var gender = useTextEditingController();
    var age = useTextEditingController();

    final heightUnits = useState<String>(_heightUnitChoices.first["value"]!);
    final weightUnits = useState<String>(_weightUnitChoices.first["value"]!);
    final isPregnant = useState<bool>(true);
    final bmi = useState<double?>(null);
    final _disableForm = useState<bool>(true);
    final _showSwitch = useState<bool>(genderChoices.first["value"] == 'F');

    void handleSubmit() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        final _age = int.tryParse(age.text) ?? 0;
        print(
            "****************************| $_age, ${
                isPregnant.value
            }, ${
                weightUnits.value
            }, ${
                heightUnits.value
            }, ${
                height.text
            }, ${
                weight.text
            } ${
            bmi.value
            } ${gender.text}|***********************************");
        if (_age < 5 || (gender.text == "Female" && isPregnant.value)) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Warning!"),
              content: Text(
                "Cant calculate BMI for person under age of 5 and for pregnant women $_age, ${isPregnant.value}",
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
        bmi.value = calculateBMI(
            heightUnits.value,
            weightUnits.value,
            double.tryParse(weight.text) ?? 0.0,
            double.tryParse(height.text) ?? 0.0);
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
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                            _showSwitch.value = gender.text == 'Female';
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
                    if (_showSwitch.value)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Pregnant: "),
                          Switch(
                            value: isPregnant.value,
                            onChanged: (bool value) {
                              isPregnant.value = !isPregnant.value;
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
                        value: weightUnits.value,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          weightUnits.value = newValue!;
                        },
                        items:
                            _weightUnitChoices.map((Map<String, String> pair) {
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
                        value: heightUnits.value,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          heightUnits.value = newValue!;
                        },
                        items:
                            _heightUnitChoices.map((Map<String, String> pair) {
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
                      unlinked: bmi.value != null
                          ? bmi.value!.toStringAsFixed(1)
                          : "_",
                      unlinkedStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: Constants.SPACING),
                    LinkedRichText(
                      linked: "BMI status:  ",
                      unlinked:
                          bmi.value != null ? getBMIStatus(bmi.value!) : "_",
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
  }
}
