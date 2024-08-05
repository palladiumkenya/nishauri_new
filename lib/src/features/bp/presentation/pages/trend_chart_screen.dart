import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bp/data/models/blood_pressure.dart';
import 'package:nishauri/src/shared/charts/CustomeMultLineChart.dart';
import 'package:nishauri/src/utils/constants.dart';

class TrendChartScreen extends StatelessWidget {
  final List<BloodPressure> data;
  const TrendChartScreen({
    required this.data,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

        final systolicSpots = data.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final systolic = entry.value.systolic;
          return FlSpot(index, systolic);
        }).toList();

        final diastolicSpots = data.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final diastolic = entry.value.diastolic;
          return FlSpot(index, diastolic);
        }).toList();

        final pulseRateSpots = data.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final pulse = entry.value.pulse_rate;
          return FlSpot(index, pulse);
        }).toList();

        final date = data.asMap().entries.map((e) {
          return e.value.created_at.toString();
        }).toList();
        print(data);
        print(date);

        return Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomMultiLineChart(
                lineBarsData: [
                  LineChartBarData(
                    spots: systolicSpots,
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 5,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [Colors.red.withOpacity(0.3), Colors.red.withOpacity(0)],
                      ),
                    ),
                    dotData: FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: diastolicSpots,
                    isCurved: true,
                    color: Colors.orange,
                    barWidth: 5,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [Colors.orange.withOpacity(0.3), Colors.orange.withOpacity(0)],
                      ),
                    ),
                    dotData: FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: pulseRateSpots,
                    isCurved: true,
                    color: Constants.programsColor,
                    barWidth: 5,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [Constants.programsColor.withOpacity(0.3), Constants.programsColor.withOpacity(0)],
                      ),
                    ),
                    dotData: FlDotData(show: false),
                  ),
                ],
                minX: 0,
                maxX: pulseRateSpots.length - 1,
                minY: 29,
                dateTimes: date,
                showLeftTitles: false,
              ),
            ),
        );
  }
}
