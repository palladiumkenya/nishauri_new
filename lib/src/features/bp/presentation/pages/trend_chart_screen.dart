import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/bp/data/providers/blood_pressure_provider.dart';

class _LineChart extends ConsumerWidget {
  final double height;

  const _LineChart({this.height = 300});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloodPressureListAsyncValue = ref.watch(bloodPressureListProvider);

    return bloodPressureListAsyncValue.when(
      data: (bloodPressureList) {
        List<FlSpot> systolicSpots = bloodPressureList
            .map((bp) => FlSpot(bp.bpTime.millisecondsSinceEpoch.toDouble(), bp.systolic.toDouble()))
            .toList();
        List<FlSpot> diastolicSpots = bloodPressureList
            .map((bp) => FlSpot(bp.bpTime.millisecondsSinceEpoch.toDouble(), bp.diastolic.toDouble()))
            .toList();
        List<FlSpot> heartRateSpots = bloodPressureList
            .map((bp) => FlSpot(bp.bpTime.millisecondsSinceEpoch.toDouble(), bp.pulse_rate.toDouble()))
            .toList();

        return SizedBox(
          height: height,
          child: Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 0,
                    left: 0,
                    top: 24,
                    bottom: 0,
                  ),
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        // The red line for systolic
                        LineChartBarData(
                          spots: systolicSpots,
                          isCurved: true,
                          barWidth: 2,
                          color: Colors.red,
                        ),
                        // The orange line for diastolic
                        LineChartBarData(
                          spots: diastolicSpots,
                          isCurved: true,
                          barWidth: 2,
                          color: Colors.orange,
                        ),
                        // The blue line for heart rate
                        LineChartBarData(
                          spots: heartRateSpots,
                          isCurved: true,
                          barWidth: 2,
                          color: Colors.blue,
                        ),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          )
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          )
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            getTitlesWidget: (value, meta) {
                              final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                              return Text('${date.month}/${date.day}');
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: true),
                      // borderData: FlBorderData(show: true),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class TrendChartScreen extends StatelessWidget {
  final double height;

  const TrendChartScreen({super.key, this.height = 300});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    child: Padding(
      padding: const EdgeInsets.only(right: 16, left: 6, top: 22),
      child: Column(
        children: [
          _LineChart(height: height - 50),
          // const IntervalPicker
        ],
      ),
    ),
  );
}
