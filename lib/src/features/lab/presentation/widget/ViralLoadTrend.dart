import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/lab/data/models/viral_load.dart';
import 'package:nishauri/src/utils/colors.dart';
import 'package:nishauri/src/utils/constants.dart';

class ViralLoadTrend extends StatefulWidget {
  final List<ViralLoad> data;
  const ViralLoadTrend({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  State<ViralLoadTrend> createState() => _ViralLoadTrendState();
}

class _ViralLoadTrendState extends State<ViralLoadTrend> {
  List<int> showingTooltipOnSpots = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.data.length; i++) {
      showingTooltipOnSpots.add(i);
    }
  }

  List<FlSpot> allSpots(List<ViralLoad> data) {
    return List.generate(data.length, (index) {
      return FlSpot(index.toDouble(), data[index].plot.toDouble());
    });
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth, List<ViralLoad> data) {
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      // color: AppColors.contentColorPink,
      fontFamily: 'Digital',
      fontSize: 18 * chartWidth / 500,
    );

    if (value.toInt() >= 0 && value.toInt() < data.length) {
      final text = DateFormat('dd-MM-yy').format(DateTime.parse(data[value.toInt()].date));
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(text, style: style),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots(widget.data),
        isCurved: true,
        barWidth: 2,
        shadow: const Shadow(
          blurRadius: 8,
        ),
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(
          show: true,
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 10,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return LineChart(
            LineChartData(
              showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                return ShowingTooltipIndicators([
                  LineBarSpot(
                    tooltipsOnBar,
                    lineBarsData.indexOf(tooltipsOnBar),
                    tooltipsOnBar.spots[index],
                  ),
                ]);
              }).toList(),
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return;
                  }
                  if (event is FlTapUpEvent) {
                    final spotIndex = response.lineBarSpots!.first.spotIndex;
                    setState(() {
                      if (showingTooltipOnSpots.contains(spotIndex)) {
                        showingTooltipOnSpots.remove(spotIndex);
                      } else {
                        showingTooltipOnSpots.add(spotIndex);
                      }
                    });
                  }
                },
                mouseCursorResolver: (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return SystemMouseCursors.basic;
                  }
                  return SystemMouseCursors.click;
                },
              ),
              lineBarsData: lineBarsData,
              minY: 0,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return bottomTitleWidgets(
                        value,
                        meta,
                        constraints.maxWidth,
                        widget.data,
                      );
                    },
                    reservedSize: 20,
                  ),
                ),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

                topTitles: const AxisTitles(
                  axisNameWidget: Text(
                    'Lab Result Trend',
                    textAlign: TextAlign.left,
                  ),
                  axisNameSize: 24,
                  sideTitles: SideTitles(
                    showTitles: false,
                    reservedSize: 0,
                  ),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  bottom: BorderSide(),
                  left: BorderSide(),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
