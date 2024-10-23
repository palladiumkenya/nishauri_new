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
  final String? filter;

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
    this.filter
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

                        // return Padding(
                        //   padding: const EdgeInsets.all(4.0),
                        //   child: Text(label),
                        // );
                        if (index >= 0 && index < dateTimes.length) {
                          DateTime date = DateTime.parse(dateTimes[index]);
                          print(date);

                          String label;

                          // Determine the label based on the filter
                          switch (filter) {
                            case 'Daily':
                              // DateTime date = DateTime.parse(dateTimes[index]);
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
                            child: Transform.rotate(
                              angle: -45 * (3.14 / 180),
                              child: Text(label),
                              // child: Text(DateFormat('HH:mm-dd/MM').format(date)),
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
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  drawHorizontalLine: true,
                  // getDrawingHorizontalLine: (value) {
                  //   return FlLine(strokeWidth: 1, color: Colors.grey);
                  // },
                  // getDrawingVerticalLine: (value) {
                  //   return FlLine(strokeWidth: 1, color: Colors.grey);
                  // },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
