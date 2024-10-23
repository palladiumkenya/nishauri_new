import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomFilterLineChart extends StatelessWidget {
  final List<FlSpot> dataPoints;
  final String? xAxisLabel;
  final String? yAxisLabel;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final bool leftTile;
  final Color? barColor;
  final bool bottomTile;
  final List<Color> gradientColors;
  final double? interval;
  final String? filter;
  final List<String> dateTimes;

  const CustomFilterLineChart({
    Key? key,
    required this.dataPoints,
    this.xAxisLabel,
    this.yAxisLabel,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    required this.leftTile,
    this.barColor,
    required this.gradientColors,
    required this.bottomTile,
    this.interval,
    this.filter,
    required this.dateTimes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Padding(
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
                      barWidth: 2,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: true),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: bottomTile,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          String label;

                          // Determine the label based on the filter
                          switch (filter) {
                            case 'Daily':
                              DateTime date = DateTime.parse(dateTimes[index]);
                              label = DateFormat('E').format(date);
                              break;
                            case 'Weekly':
                              label = 'Week ${index + 1}'; // Week number
                              break;
                            case 'Monthly':
                              label = 'Month ${index + 1}'; // Month number
                              break;
                            case 'Yearly':
                              label = 'Year ${index + 1}'; // Year number
                              break;
                            default:
                              label = '';
                          }

                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(label),
                          );
                        },
                        reservedSize: 30,
                        interval: 1,
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
                        interval: interval ?? 1,
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
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    drawHorizontalLine: true,
                    // getDrawingHorizontalLine: (value) {
                    //   return const FlLine(strokeWidth: 1, color: Colors.grey);
                    // },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
