import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/bmi/data/model/bmi_log.dart';
import 'package:nishauri/src/features/bmi/data/providers/bmi_log_provider.dart';
import 'package:nishauri/src/features/bmi/data/services/bmi_log_service.dart';
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

  Future<int> _fetchAge() async {
    final authRepository = AuthRepository(AuthApiService());
    return await authRepository.getAge() as Future<int>;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    const activeColor = Constants.activeSelectionColor;
    var gender = useState<GenderPickerChoices>(GenderPickerChoices.male);
    final isPregnant = useState(false);
    final height = useState<double>(180);
    final heightUnits =
        useState<HeightUnitsPickerOptions>(HeightUnitsPickerOptions.In);
    final weight = useState<int>(65);
    final isForSelf = useState(true);
    final userAsync = ref.watch(userProvider);
    // var age = userAsync.whenData((user) {
    //   return DateTime.now().year - int.parse(user.dateOfBirth!.split('-')[0]);
    // });
    var age = userAsync.whenData((user) {
      return DateTime.now().year - int.parse(user.dateOfBirth!.split('-')[0]);
    });
    var userAge = useState(age);

    // Implmentation using Fetch age and AuthRepository
    // var userAge = useState<int>(18);
    // useEffect(() {
    //   _fetchAge().then((value) => userAge.value = value);
    //   return null;
    // }, []);

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
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(Constants.SPACING),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "BMI for: ",
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: Constants.SPACING),
                                  ToggleButtons(
                                    isSelected: [
                                      isForSelf.value,
                                      !isForSelf.value
                                    ],
                                    onPressed: (index) {
                                      isForSelf.value = index == 0;
                                      // fetch user gender
                                      userAsync.whenData((user) async {
                                        if (user.gender != null) {
                                          debugPrint(
                                              'user gender: ${user.gender}');
                                          if (user.gender == 'Male') {
                                            gender =
                                                useState<GenderPickerChoices>(
                                                    GenderPickerChoices.male);
                                          } else {
                                            gender =
                                                useState<GenderPickerChoices>(
                                                    GenderPickerChoices.female);
                                          }
                                        }
                                      });
                                      userAsync.whenData((user) async {
                                        if (user.dateOfBirth != null) {
                                          debugPrint(
                                              'user dateOfBirth: ${user.dateOfBirth}');
                                          var age = DateTime.now().year -
                                              int.parse(user.dateOfBirth!
                                                  .split('-')[0]);
                                          userAge.value =
                                              age as AsyncValue<int>;
                                        }
                                      });
                                      // ==== Fetch user not working as expected
                                      // _fetchAge().then(
                                      //     (value) => userAge.value = value);
                                    },
                                    selectedColor: Colors
                                        .white, //color for selected button
                                    fillColor: activeColor,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text("Myself"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text("Other"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Constants.SPACING),
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
                      // Check is forself is true
                      isForSelf.value == false
                          ? GenderPicker(
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
                                                      icon:
                                                          Icons.woman_rounded),
                                                  RadioGroupItem(
                                                      value: "no",
                                                      title: "Pregnant",
                                                      icon:
                                                          Icons.pregnant_woman),
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
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
                            )
                          : GenderPicker(
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
                          isForSelf.value == false
                              ? Quantizer(
                                  min: 5,
                                  max: 100,
                                  value: userAge.value.value!,
                                  onValueChange: (value) =>
                                      userAge.value = value as AsyncValue<int>,
                                  label: "Age",
                                  units: "Years",
                                  activeColor: activeColor,
                                )
                              : // Show similar quantizer but one that values can't be modified
                              Quantizer(
                                  value: userAge.value.value!,
                                  onValueChange: (value) {},
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
                            final bmi =
                                calculateBMI(height.value, weight.value);
                            print('height.value: ${height.value}');
                            print('bmi: $bmi');

                            if (isForSelf.value) {
                              ref
                                  .read(bmiLogProvider.notifier)
                                  .logBMI(height.value.toString(),
                                      weight.value.toString(), bmi.toString())
                                  .then((_) {
                                context.goNamed(
                                    RouteNames.BMI_CALCULATOR_RESULTS,
                                    extra: bmi);
                              });
                              ref.refresh(bmiListProvider);
                            } else {
                              context.goNamed(RouteNames.BMI_CALCULATOR_RESULTS,
                                  extra: bmi);
                            }
                          }),
                      const SizedBox(height: Constants.SPACING),
                      Button(
                        title: "BMI History",
                        // disabled: isPregnant.value,
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

//Awaiting Endpoints


