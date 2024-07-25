import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                  child: CustomLineChart(
                    dataPoints: dataPoints,
                    xAxisLabel: 'Time',
                    yAxisLabel: 'Blood Sugar Level',
                    minX: 0,
                    maxX: dataPoints.length.toDouble() - 1,
                    minY: dataPoints
                        .map((e) => e.y)
                        .reduce((a, b) => a < b ? a : b),
                    maxY: dataPoints
                        .map((e) => e.y)
                        .reduce((a, b) => a > b ? a : b),
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
