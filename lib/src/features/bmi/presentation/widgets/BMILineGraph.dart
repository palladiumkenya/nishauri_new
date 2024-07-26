import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/bmi/data/providers/bmi_log_provider.dart';
import 'package:nishauri/src/shared/charts/CustomLineChart.dart';
import 'package:nishauri/src/utils/constants.dart';

class BMILineGraph extends ConsumerWidget {
  final List<Color> gradientColors = [
    Constants.bmiCalculatorColor.withOpacity(0.3),
    Constants.bmiCalculatorShortcutBgColor.withOpacity(0),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bmiListAsyncValue = ref.watch(bmiListProvider);

    return bmiListAsyncValue.when(
      data: (bmiList) {
        if (bmiList.isEmpty) {
          return Scaffold(
            body: Center(
              child: Text('No BMI data available.'),
            ),
          );
        }

        final dataPoints = bmiList.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final bmi = entry.value.results;
          return FlSpot(index, bmi);
        }).toList();

        final date = bmiList.first.date;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomLineChart(
              dataPoints: dataPoints,
              dateTime: date,
              minX: 0,
              maxX: dataPoints.length - 1,
              minY: 0,
              leftTile: false,
              barColor: Constants.bmiCalculatorColor,
              gradientColors: gradientColors,
            ),
          ),
        );
      },
      loading: () => Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}
