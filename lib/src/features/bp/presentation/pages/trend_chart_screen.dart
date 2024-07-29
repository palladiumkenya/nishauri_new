import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/bp/data/providers/blood_pressure_provider.dart';
import 'package:nishauri/src/shared/charts/CustomeMultLineChart.dart';
import 'package:nishauri/src/utils/constants.dart';

class TrendChartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloodPressureListAsyncValue = ref.watch(bloodPressureListProvider);

    Future<void> _refresh() async {
      // Re-fetch the data by invalidating the provider
      ref.refresh(bloodPressureListProvider);
    }

    return bloodPressureListAsyncValue.when(
      data: (bpiList) {
        final systolicSpots = bpiList.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final systolic = entry.value.systolic;
          return FlSpot(index, systolic);
        }).toList();

        final diastolicSpots = bpiList.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final diastolic = entry.value.diastolic;
          return FlSpot(index, diastolic);
        }).toList();

        final pulseRateSpots = bpiList.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final pulse = entry.value.pulse_rate;
          return FlSpot(index, pulse);
        }).toList();

        final date = bpiList.asMap().entries.map((e) {
          return e.value.date_time.toString();
        }).toList();

        return Scaffold(
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: Padding(
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
                dateTimes: date,
                showLeftTitles: false,
              ),
            ),
          ),
        );
      },
      loading: () => Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('No Data Available For Blood Pressure')),
      ),
    );
  }
}
