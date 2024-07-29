import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/utils/sampleBmi.dart';

class CustomLineChart extends StatelessWidget {
  final List<FlSpot> dataPoints;
  final String? xAxisLabel;
  final String? yAxisLabel;
  final String dateTime;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final bool leftTile;
   final Color? barColor;
  final List<Color> gradientColors;

  const CustomLineChart({
    Key? key,
    required this.dataPoints,
    this.xAxisLabel,
    this.yAxisLabel,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    required this.dateTime,
    required this.leftTile,
    this.barColor,
    required this.gradientColors,
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
                    color: barColor,
                    barWidth: 6,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: gradientColors
                            .map((color) => color.withOpacity(0.3))
                            .toList(),
                      ),
                    ),
                    dotData: const FlDotData(show: false),
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
                              dateTime);
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(DateFormat('dd-MM-yy').format(date)),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 30,
                      // rotateAngle: 45,
                      interval: 1, // Show labels at an interval of 1 unit
                    ),
                    axisNameWidget: Text(xAxisLabel??''),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: leftTile,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toString());
                      },
                      reservedSize: 30,
                      interval: 1, // Show labels at an interval of 1 unit
                    ),
                    axisNameWidget: Text(yAxisLabel??''),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
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
                    return const FlLine(strokeWidth: 1, color: Colors.grey);
                  },
                  getDrawingVerticalLine: (value) {
                    if (value.toInt() % 1 == 0) {
                      return const FlLine(strokeWidth: 1, color: Colors.grey);
                    }
                    return const FlLine(
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
