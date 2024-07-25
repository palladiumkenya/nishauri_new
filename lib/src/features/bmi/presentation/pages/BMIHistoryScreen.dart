import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/BMILineGraph.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/BMILineList.dart';
import 'package:nishauri/src/shared/charts/CustomLineChart.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/sampleBmi.dart';

class BMIHistoryScreen extends StatelessWidget {
  const BMIHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "BMI Monitor 📈",
            // icon: Icons.trending_up,
            color: Constants.bmiCalculatorColor,
          ),
          Expanded(
            child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: BMILinelist(),
                        ),
                        Expanded(
                          flex: 1,
                          child: BMILineGraph(),
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
