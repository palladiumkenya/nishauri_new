import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/utils/sampleBmi.dart';

class CustomLineChart extends StatelessWidget {
  final List<FlSpot> dataPoints;
  final String xAxisLabel;
  final String yAxisLabel;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;

  const CustomLineChart({
    Key? key,
    required this.dataPoints,
    required this.xAxisLabel,
    required this.yAxisLabel,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: dataPoints,
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 6,
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.blue.withOpacity(0.3),
                    ),
                    dotData: FlDotData(show: false),
                  ),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int intValue = value.toInt();
                        if (intValue < dataPoints.length) {
                          DateTime date = DateTime.parse(
                              dataset["data"]![intValue]["bmiTime"] ?? '');
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(DateFormat('MM-dd').format(date)),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 30,
                      // rotateAngle: 45,
                      interval: 1, // Show labels at an interval of 1 unit
                    ),
                    axisNameWidget: Text(xAxisLabel),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toString());
                      },
                      reservedSize: 30,
                      interval: 1, // Show labels at an interval of 1 unit
                    ),
                    axisNameWidget: Text(yAxisLabel),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                minX: minX,
                maxX: maxX,
                minY: minY,
                maxY: maxY,
                borderData: FlBorderData(show: true),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(strokeWidth: 1, color: Colors.grey);
                  },
                  getDrawingVerticalLine: (value) {
                    if (value.toInt() % 1 == 0) {
                      return FlLine(strokeWidth: 1, color: Colors.grey);
                    }
                    return FlLine(
                        strokeWidth: 0); // Hide lines for non-integer values
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
