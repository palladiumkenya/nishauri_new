import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/blood_sugar/data/providers/blood_sugar_provider.dart';
import 'package:nishauri/src/features/blood_sugar/presentation/pages/AddBloodSugarScreen.dart';
import 'package:nishauri/src/features/blood_sugar/presentation/widgets/blood_sugar_entry_card.dart';
import 'package:nishauri/src/shared/charts/CustomLineChart.dart';

class BloodSugarScreen extends ConsumerWidget {
  const BloodSugarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloodSugarState = ref.watch(bloodSugarEntriesProvider);
    debugPrint("Blood Sugar State: ${bloodSugarState.length}");
    List<FlSpot> dataPoints = bloodSugarState
        .asMap()
        .entries
        .map((entry) => FlSpot(
              entry.key.toDouble(),
              entry.value.level,
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Sugar Tracker'),
      ),
      body: bloodSugarState.isEmpty
          ? const Center(child: Text('No data available'))
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: dataPoints,
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 4,
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
                                      bloodSugarState[intValue]
                                          .timestamp
                                          .toString());
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      DateFormat('MM-dd').format(date),
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                              reservedSize: 30,

                              interval:
                                  1, // Show labels at an interval of 1 unit
                            ),
                            axisNameWidget: const Text('Time'),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toStringAsFixed(
                                      1), // Display up to 1 decimal place
                                  style: const TextStyle(
                                    fontSize:
                                        10, // Adjust font size to prevent overlap
                                  ),
                                );
                              },
                              reservedSize: 30,
                              interval:
                                  10, // Adjust interval to show fewer labels
                            ),
                            axisNameWidget: const Text('Blood Sugar Level'),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        minX: 0,
                        maxX: dataPoints.length.toDouble() - 1,
                        minY: dataPoints
                            .map((e) => e.y)
                            .reduce((a, b) => a < b ? a : b),
                        maxY: dataPoints
                            .map((e) => e.y)
                            .reduce((a, b) => a > b ? a : b),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: Colors
                                .black, // Change border color if necessary
                            width: 1,
                          ),
                        ),
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
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bloodSugarState.length,
                    itemBuilder: (context, index) {
                      return BloodSugarEntryCard(entry: bloodSugarState[index]);
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBloodSugarScreen()),
          );
          ref.read(bloodSugarEntriesProvider.notifier).refreshEntries();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
