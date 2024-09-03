import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/bmi/data/providers/bmi_log_provider.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/GenderPicker.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/HeightPicker.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/HeightUnitsPicker.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/RadioGroup.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/QuanterSizer.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';
import 'package:nishauri/src/utils/routes.dart';

class BMICalculatorScreen extends HookConsumerWidget {
  const BMICalculatorScreen({super.key});

  Future<int?> _fetchAge(WidgetRef ref) async {
    try {
      final authRepository = AuthRepository(AuthApiService());
      String ageString = await authRepository.getAge();
      int age = int.parse(ageString);
      return age;
    } catch (e) {
      print("An error occurred while fetching the age: $e");
      final userAsync = ref.watch(userProvider);
      final age = userAsync.when(
        data: (user) {
          final birthYear = int.parse(user.dateOfBirth!.split('-')[0]);
          return DateTime.now().year - birthYear;
        },
        loading: () => null,
        error: (error, stack) {
          print("Error fetching user data: $error");
          return null;
        },
      );
      return age;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    const activeColor = Constants.activeSelectionColor;
    final gender = useState<GenderPickerChoices>(GenderPickerChoices.male);
    final isPregnant = useState(false);
    final height = useState<double>(180);
    final heightUnits = useState<HeightUnitsPickerOptions>(HeightUnitsPickerOptions.In);
    final weight = useState<int>(65);
    final isForSelf = useState(true);
    final userAge = useState<int>(18);

    useEffect(() {
      _fetchAge(ref).then((fetchedAge) {
        print("Age fetched: $fetchedAge");
        userAge.value = fetchedAge!;
      });
      return null;
    }, [ref]);

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "BMI Calculator ⚖️",
            subTitle: "Empower Your Health Journey \nWith BMI Insights",
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
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(Constants.SPACING),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "BMI for: ",
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  ToggleButtons(
                                    isSelected: [isForSelf.value, !isForSelf.value],
                                    onPressed: (index) {
                                      isForSelf.value = index == 0;
                                      if (isForSelf.value) {
                                        _fetchAge(ref).then((fetchedAge) {
                                          userAge.value = fetchedAge!;
                                        });
                                      }
                                    },
                                    selectedColor: Colors.white,
                                    fillColor: activeColor,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Text("Myself"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Text("Other"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: Constants.SPACING),
                      Text(
                        "Choose your gender",
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: Constants.SPACING),
                      if (!isForSelf.value)
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
                                          "BMI Calculation for pregnant ladies is highly discouraged and not supported to avoid drastic decisions. Please confirm your pregnancy status.",
                                        ),
                                        RadioGroup(
                                          onValueChanged: (val) {
                                            Navigator.of(context).pop(val == "no");
                                          },
                                          items: [
                                            RadioGroupItem(
                                              value: "yes",
                                              title: "Not Pregnant",
                                              icon: Icons.woman_rounded,
                                            ),
                                            RadioGroupItem(
                                              value: "no",
                                              title: "Pregnant",
                                              icon: Icons.pregnant_woman,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ).then((isPregnant_) {
                                if (isPregnant_ != null) {
                                  isPregnant.value = !isPregnant_;
                                  gender.value = gender_;
                                  if (isPregnant_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "BMI calculation for pregnant ladies isn't supported",
                                        ),
                                      ),
                                    );
                                  }
                                }
                              });
                            } else {
                              gender.value = gender_;
                            }
                          },
                          activeColor: activeColor,
                        )
                      else
                        GenderPicker(
                          gender: gender.value,
                          onGenderChange: (gender) {},
                          isEnabled: isForSelf.value,
                        ),
                      const SizedBox(height: Constants.SPACING),
                      HeightPicker(
                        activeColor: activeColor,
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
                            value: userAge.value,
                            onValueChange: isForSelf.value ? (_) {} : (value) => userAge.value = value,
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
                          final bmi = calculateBMI(height.value, weight.value);
                          if (isForSelf.value) {
                            ref.read(bmiLogProvider.notifier)
                                .logBMI(height.value.toString(), weight.value.toString(), bmi.toString())
                                .then((_) {
                              context.goNamed(RouteNames.BMI_CALCULATOR_RESULTS, extra: bmi);
                            });
                            ref.refresh(bmiListProvider);
                          } else {
                            context.goNamed(RouteNames.BMI_CALCULATOR_RESULTS, extra: bmi);
                          }
                        },
                      ),
                      const SizedBox(height: Constants.SPACING),
                      Button(
                        title: "BMI History",
                        backgroundColor: activeColor,
                        textColor: theme.canvasColor,
                        onPress: () {
                          ref.refresh(bmiListProvider);
                          context.goNamed(RouteNames.BMI_HISTORY);
                        },
                      ),
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
