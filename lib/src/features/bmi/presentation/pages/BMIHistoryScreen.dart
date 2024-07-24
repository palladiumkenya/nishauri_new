import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/charts/CustomLineChart.dart';
import 'package:nishauri/src/utils/sampleBmi.dart';

class BMIHistoryScreen extends StatelessWidget {
  const BMIHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provided dataset

    // Convert dataset to a list of FlSpot
    final dataPoints = dataset["data"]!.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final bmi = double.parse(entry.value["bmi"] ?? '');
      return FlSpot(index, bmi);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('BMI Data Line Chart Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomLineChart(
          dataPoints: dataPoints,
          xAxisLabel: 'Time (Days)',
          yAxisLabel: 'BMI',
          minX: 0,
          maxX: dataPoints.length - 1,
          minY: 22,
          maxY: 28,
        ),
      ),
    );
  }
}
