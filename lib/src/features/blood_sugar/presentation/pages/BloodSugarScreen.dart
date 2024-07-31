import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/blood_sugar/data/providers/blood_sugar_provider.dart';
import 'package:nishauri/src/features/blood_sugar/presentation/pages/AddBloodSugarScreen.dart';
import 'package:nishauri/src/features/blood_sugar/presentation/widgets/blood_sugar_entry_card.dart';
import 'package:nishauri/src/shared/charts/CustomLineChart.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

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

    List<String> dateTimeList = bloodSugarState
        .map((entry) => entry.timestamp.toIso8601String())
        .toList();

    final minChartValue = 40.0;
    final maxChartValue = 400.0;

    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Blood Sugar level 🍚",
            subTitle: "Keep a record of your blood sugar levels",
            color: Constants.bloodSugarColor,
          ),
          const SizedBox(height: Constants.SPACING),
          Expanded(
            child: bloodSugarState.isEmpty
                ? const Center(child: Text('No data available'))
                : Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomLineChart(
                            dataPoints: dataPoints,
                            dateTime: dateTimeList.first,
                            gradientColors: [
                              Constants.bloodSugarColor,
                              Constants.bloodSugarColor.withOpacity(0.3),
                            ],
                            minX: 0,
                            maxX: bloodSugarState.length.toDouble() - 1,
                            minY: minChartValue,
                            maxY: maxChartValue,
                            leftTile: true,
                            interval: 80,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: bloodSugarState.length,
                          itemBuilder: (context, index) {
                            return BloodSugarEntryCard(
                                entry: bloodSugarState[index]);
                          },
                        ),
                      ),
                    ],
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
