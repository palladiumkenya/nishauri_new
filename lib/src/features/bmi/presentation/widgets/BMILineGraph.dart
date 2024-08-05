import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/bmi/data/model/bmi_log.dart';
import 'package:nishauri/src/features/bmi/data/providers/bmi_log_provider.dart';
import 'package:nishauri/src/shared/charts/CustomLineChart.dart';
import 'package:nishauri/src/utils/constants.dart';

class BMILineGraph extends StatelessWidget {
  final List<BMILog> data;
const BMILineGraph({required this.data, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      Constants.bmiCalculatorColor.withOpacity(0.3),
      Constants.bmiCalculatorShortcutBgColor.withOpacity(0),
    ];

        final dataPoints = data.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final bmi = entry.value.results;
          return FlSpot(index, bmi);
        }).toList();

    final date = data.asMap().entries.map((e) {
      return e.value.created_at.toString();
    }).toList();

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomLineChart(
              dataPoints: dataPoints,
              dateTimes: date,
              minX: 0,
              maxX: dataPoints.length - 1,
              minY: 5,
              leftTile: false,
              barColor: Constants.bmiCalculatorColor,
              gradientColors: gradientColors,
              bottomTile: true,
              dateFormat: "dd/MM/yy",
            ),
          ),
        );
  }
}
