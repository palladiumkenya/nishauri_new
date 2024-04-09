import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/lab/data/models/viral_load.dart';
import 'package:nishauri/src/utils/constants.dart';

class ViralLoadTrend extends StatelessWidget {
  final List<ViralLoad> data;

  const ViralLoadTrend({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Text(
            "Lab Result Trend",
            style: theme.textTheme.headlineMedium,
          ),
        ),
        const Divider(),
        Container(
          margin: const EdgeInsets.only(top: Constants.SPACING),
          child: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CombinedChartWidget(data: data),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CombinedChartWidget extends StatelessWidget {
  final List<ViralLoad> data;

  const CombinedChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          lineBarsData: _lineBarsData(),
          borderData: FlBorderData(
            border: Border(
              bottom: BorderSide(),
              left: BorderSide(),
            ),
          ),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }

  List<LineChartBarData> _lineBarsData() {
    return [
      LineChartBarData(
        spots: _lineSpots(),
        isCurved: true,
        color: Colors.green,
        barWidth: 2,
      ),
    ];
  }

  List<FlSpot> _lineSpots() {
    return List.generate(data.length, (index) {
      return FlSpot(index.toDouble(), data[index].plot.toDouble());
    });
  }

  // List<BarChartGroupData> _barGroups() {
  //   return List.generate(data.length, (index) {
  //     return BarChartGroupData(
  //       x: index,
  //       barRods: [
  //         BarChartRodData(
  //           toY: data[index].plot.toDouble(),
  //           colors: [Colors.red],
  //           width: 8,
  //         ),
  //       ],
  //     );
  //   });
  // }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    interval: 1,
    getTitlesWidget: (value, meta) {
      if (value.toInt() >= 0 && value.toInt() < data.length) {
        return Text(DateFormat('dd-MM-yy').format(DateTime.parse(data[value.toInt()].date)));
      }
      return SizedBox();
    },
  );
}
