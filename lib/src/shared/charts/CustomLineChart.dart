import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/utils/sampleBmi.dart';

class CustomLineChart extends StatelessWidget {
  final List<FlSpot> dataPoints;
  final String? xAxisLabel;
  final String? yAxisLabel;
  final List<String> dateTimes;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final bool leftTile;
  final Color? barColor;
  final bool bottomTile;
  final List<Color> gradientColors;
  final double? interval;
  final String dateFormat;

  const CustomLineChart({
    Key? key,
    required this.dataPoints,
    this.xAxisLabel,
    this.yAxisLabel,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    required this.dateTimes,
    required this.leftTile,
    this.barColor,
    required this.gradientColors,
    required this.bottomTile,
    this.interval,
    required this.dateFormat,
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
                      showTitles: bottomTile,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < dateTimes.length) {
                          DateTime date = DateTime.parse(dateTimes[index]);
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Transform.rotate(
                              angle: -45 *
                                  (3.14 /
                                      180), // Rotate the text by -45 degrees
                              child: Text(DateFormat(dateFormat).format(date)),
                            ),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 30,
                      interval: 1, // Show labels at an interval of 1 unit
                    ),
                    axisNameWidget: Text(xAxisLabel ?? ''),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: leftTile,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toString(),
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                      reservedSize: 30,
                      interval:
                          interval ?? 1, // Show labels at an interval of 1 unit
                    ),
                    axisNameWidget: Text(yAxisLabel ?? ''),
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
