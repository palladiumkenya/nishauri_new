import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomMultiLineChart extends StatelessWidget {
  final List<LineChartBarData> lineBarsData;
  final String? xAxisLabel;
  final String? yAxisLabel;
  final List<String> dateTimes;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final bool showLeftTitles;

  const CustomMultiLineChart({
    Key? key,
    required this.lineBarsData,
    this.xAxisLabel,
    this.yAxisLabel,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
    required this.dateTimes,
    required this.showLeftTitles,
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
                lineBarsData: lineBarsData,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < dateTimes.length) {
                          DateTime date = DateTime.parse(dateTimes[index]);
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(DateFormat('dd-MM-yy').format(date)),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 30,
                      interval: 1,
                    ),
                    axisNameWidget: Text(xAxisLabel ?? ''),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: showLeftTitles,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toString());
                      },
                      reservedSize: 30,
                      interval: 1,
                    ),
                    axisNameWidget: Text(yAxisLabel ?? ''),
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
                    return FlLine(strokeWidth: 1, color: Colors.grey);
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
