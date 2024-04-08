import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nishauri/src/features/lab/data/models/viral_load.dart';

class ViralLoadTrend extends StatelessWidget {
  final List<ViralLoad> data;

  const ViralLoadTrend({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChartWidget(data: data);
  }
}

class LineChartWidget extends StatefulWidget {
  final List<ViralLoad> data;

  const LineChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState(data: data);
}

class _LineChartWidgetState extends State<LineChartWidget> {
  final List<ViralLoad> data;
  late int showingTooltipSpot;

  _LineChartWidgetState({required this.data});

  @override
  void initState() {
    showingTooltipSpot = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<LineChartBarData> _lineBarsData = [
      LineChartBarData(
        spots: data
            .map((e) => FlSpot(data.indexOf(e).toDouble(), e.plot.toDouble()/100))
            .toList(),
        isCurved: false,
        dotData: FlDotData(show: false),
        color: Colors.red,
      ),
    ];

    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineBarsData: _lineBarsData,
          borderData: FlBorderData(
            border: Border(
              bottom: BorderSide(),
              left: BorderSide(),
            ),
          ),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          showingTooltipIndicators: showingTooltipSpot != -1
              ? [
            ShowingTooltipIndicators([
              LineBarSpot(_lineBarsData[0], showingTooltipSpot,
                  _lineBarsData[0].spots[showingTooltipSpot]),
            ])
          ]
              : [],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.blue,
              tooltipRoundedRadius: 20.0,
              fitInsideHorizontally: true,
              tooltipMargin: 0,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map(
                      (LineBarSpot touchedSpot) {
                    const TextStyle textStyle = TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    );
                    return LineTooltipItem(
                      data[touchedSpot.spotIndex].plot.toStringAsFixed(2),
                      textStyle,
                    );
                  },
                ).toList();
              },
            ),
            handleBuiltInTouches: false,
            touchCallback: (event, response) {
              if (response?.lineBarSpots != null && event is FlTapUpEvent) {
                setState(() {
                  final spotIndex =
                      response?.lineBarSpots?[0].spotIndex ?? -1;
                  if (spotIndex == showingTooltipSpot) {
                    showingTooltipSpot = -1;
                  } else {
                    showingTooltipSpot = spotIndex;
                  }
                });
              }
            },
          ),
        ),
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      if (value.toInt() >= 0 && value.toInt() < data.length) {
        return Text(data[value.toInt()].date);
      }
      return Text("");
    },
  );
}
