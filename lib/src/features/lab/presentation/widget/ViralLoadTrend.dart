import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/lab/data/models/viral_load.dart';
import 'package:nishauri/src/shared/charts/CustomLineChart.dart';
import 'package:nishauri/src/utils/constants.dart';

class ViralLoadTrend extends StatelessWidget {
  final List<ViralLoad> data;
  const ViralLoadTrend({
    required this.data,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Color> gradientColors = [
      Constants.labResultsColor.withOpacity(0.3),
      Constants.labResultsShortcutBgColor.withOpacity(0),

    ];
    final dataPoints = data.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final bmi = double.parse(entry.value.plot.toString());
      return FlSpot(index, bmi);
    }).toList();
    final date = data.asMap().entries.map((e) {
      return e.value.date.toString();
    }).toList();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomLineChart(
          dataPoints: dataPoints,
          dateTimes: date,
          minX: 0,
          maxX: dataPoints.length - 1,
          minY: 0,
          // maxY: 28,
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
