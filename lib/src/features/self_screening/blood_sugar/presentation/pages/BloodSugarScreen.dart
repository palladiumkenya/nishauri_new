
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/data/models/blood_sugar.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/data/providers/blood_sugar_provider.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/presentation/pages/AddBloodSugarScreen.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/presentation/widgets/blood_sugar_entry_card.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/presentation/widgets/blood_suger_trend_chart.dart';
import 'package:nishauri/src/features/self_screening/presentation/widgets/image_card.dart';
import 'package:nishauri/src/shared/charts/CustomLineChart.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/shared/display/custome_filter_chart.dart';
import 'package:nishauri/src/shared/display/daily_card.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class BloodSugarScreen extends ConsumerStatefulWidget {
  const BloodSugarScreen({super.key});

  @override
  _BloodSugarScreenState createState() => _BloodSugarScreenState();
}

class _BloodSugarScreenState extends ConsumerState<BloodSugarScreen> {
  Color buttonColor = Colors.blue;

  void _changeColor() {
    setState(() {
      buttonColor = buttonColor == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloodSugarListProvider = ref.watch(bloodSugarEntriesProvider);
    final theme = Theme.of(context);

    final data = bloodSugarListProvider.when(
      data: (data) {
        return data ?? [];
      },
      error: (error, _) {
        return [];
      },
      loading: () {
        return [];
      },
    );

    final dataPoints = data.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final systolic = entry.value.level;
      return FlSpot(index, systolic);
    }).toList();

    final dateTimeList = data.asMap().entries.map((e) {
      return e.value.created_at.toString();
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Blood Sugar",
            color: Constants.selfScreeningBgColor,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(Constants.SPACING),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            FilterCard(
                              onPressed: _changeColor,
                            ),
                          ],
                        ),
                        SizedBox(height: Constants.SPACING,),
                        Text("18 Oct 2024", style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold)),

                        SizedBox(height: Constants.SPACING,),
                        Row(
                          children: [
                            Text("4.1", style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 4),
                            Text("mmol/L", style: theme.textTheme.bodyMedium),
                          ],
                        ),
                        SizedBox(height: Constants.SPACING,),
                        Wrap(
                          spacing: 1,
                          runSpacing: 16,
                          children: [
                            CustomFilterLineChart(
                              dataPoints: dataPoints,
                              dateTimes: dateTimeList,
                              gradientColors: [
                                Constants.bloodSugarColor,
                                Constants.bloodSugarColor.withOpacity(0.3),
                              ],
                              minX: 0,
                              maxX: data.length.toDouble() - 1,
                              minY: 40.0,
                              maxY: 400.0,
                              leftTile: false,
                              bottomTile: true,
                              interval: 80,
                              // dateFormat: "HH:mm-dd",
                              filter: "Daily",
                              barColor: Constants.barColor,
                            ),
                          ],
                        ),
                        SizedBox(height: Constants.SPACING,),
                        Card(
                          color: Constants.bgColor,
                          child: ListTile(
                            title: Text("Show All Data", style: theme.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                            trailing: const Icon(Icons.arrow_forward_ios_outlined),
                            onTap: (){
                            //   implementing on tap method
                            },
                          ),
                        ),
                        SizedBox(height: Constants.SPACING,),
                        Container(
                          color: Constants.bgColor,
                          height: 250,
                          child: Padding(
                            padding: const EdgeInsets.all(Constants.SPACING),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                      'What is Blood Sugar',
                                      style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      "Blood sugar, or glucose, is the main type of sugar found in your blood. It’s your body’s primary source of energy, coming from the food you eat, especially carbohydrates. When you eat, your body breaks down the food into glucose, which then enters your bloodstream. Your pancreas releases a hormone called insulin to help move this glucose into your cells, where it’s used for energy. Maintaining balanced blood sugar levels is crucial because too much or too little can lead to health issues like diabetes or hypoglycemia. Think of it as the fuel that keeps your body running smoothly!",
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Constants.SPACING),
                        Button(
                          title: "More Insight",
                          onPress: (){
                            context.goNamed(RouteNames.BLOOD_SUGAR_INSIGHT);
                          },
                          textColor: Constants.selfScreeningBgColor,
                          // onPressed: () {
                          //   // implement on Pressed
                          // },
                          // child: Text('More Insight', style: theme.textTheme.bodyLarge!.copyWith(color: Constants.selfScreeningBgColor)),
                          // style: TextButton.styleFrom(
                          //   backgroundColor: Constants.bgColor,
                          //   padding: EdgeInsets.all(10),
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(8), // Rounded corners
                          //   ),
                          // ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
