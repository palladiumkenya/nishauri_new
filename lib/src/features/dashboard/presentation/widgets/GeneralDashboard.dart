import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/BMILineGraph.dart';
import 'package:nishauri/src/features/bp/presentation/pages/trend_chart_screen.dart';
import 'package:nishauri/src/shared/charts/LineChartWidget.dart';

class GeneralDashboard extends StatelessWidget {
  const GeneralDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        Card(
          child: SizedBox(
            height: 350,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("BMI Trend"),
                  Expanded(
                    child: BMILineGraph(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Card(
          child: SizedBox(
            height: 350,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Blood Pressure Trend"),
                  Expanded(
                    child: TrendChartScreen(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
