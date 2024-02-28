import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/shared/charts/LineChartWidget.dart';

class GeneralDashboard extends StatelessWidget {
  const GeneralDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: const [
        Card(
          child: SizedBox(
            height: 300,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ExpansionTile(
                    title: Text("BMI Trends"),
                    leading: Icon(Icons.shutter_speed),
                    children: [
                      Text(
                        "What is Lorem Ipsum?  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic.",
                      )
                    ],
                  ),
                  Expanded(
                    child: LineChartWidget(
                      [
                        FlSpot(1, 30),
                        FlSpot(2, 50),
                        FlSpot(3, 40),
                        FlSpot(4, 60),
                        FlSpot(5, 60),
                        FlSpot(6, 70),
                      ],
                      xLabel: "Duration",
                      yLabel: "BMI",
                    ),
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
