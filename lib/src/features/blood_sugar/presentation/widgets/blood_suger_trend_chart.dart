import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/features/blood_sugar/data/models/blood_sugar.dart';
import 'package:nishauri/src/shared/charts/CustomLineChart.dart';
import 'package:nishauri/src/utils/constants.dart';

class BloodSugarTrendChart extends StatelessWidget {
  final List<BloodSugar> data;
  const BloodSugarTrendChart({
    required this.data,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final dataPoints = data.asMap().entries.map((entry) {
      final index = entry.key.toDouble();
      final systolic = entry.value.level;
      return FlSpot(index, systolic);
    }).toList();


    final dateTimeList = data.asMap().entries.map((e) {
      return e.value.created_at.toString();
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomLineChart(
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
          leftTile: true,
          bottomTile: true,
          interval: 80,
          dateFormat: "HH:mm-dd/MM",
        ),
      ),
    );
  }
}
