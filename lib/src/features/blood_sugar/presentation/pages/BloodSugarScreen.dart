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
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/constants.dart';

class BloodSugarScreen extends ConsumerWidget {
  const BloodSugarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloodSugarListProvider = ref.watch(bloodSugarEntriesProvider);
    final theme = Theme.of(context);
    // List<FlSpot> dataPoints = bloodSugarListProvider
    //     .asMap()
    //     .entries
    //     .map((entry) => FlSpot(
    //           entry.key.toDouble(),
    //           entry.value.level,
    //         ))
    //     .toList();

    // List<String> dateTimeList = bloodSugarListProvider
    //     .map((entry) => entry.timestamp.toIso8601String())
    //     .toList();

    // final minChartValue = 40.0;
    // final maxChartValue = 400.0;

    return bloodSugarListProvider.when(
        data: (data) {
          List<FlSpot> dataPoints = data
              .asMap()
              .entries
              .map((entry) => FlSpot(
                    entry.key.toDouble(),
                    entry.value.level,
                  ))
              .toList();

          List<String> dateTimeList = data
              .map((entry) => DateFormat('dd/MM/yyyy hh:mm a')
                  .format(entry.timestamp.toLocal()))
              .toList();

          const minChartValue = 40.0;
          const maxChartValue = 400.0;
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
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomLineChart(
                            dataPoints: dataPoints,
                            dateTimes: dateTimeList,
                            gradientColors: [
                              Constants.bloodSugarColor,
                              Constants.bloodSugarColor.withOpacity(0.3),
                            ],
                            minX: 0,
                            maxX: data.length.toDouble() - 1,
                            minY: minChartValue,
                            maxY: maxChartValue,
                            leftTile: true,
                            bottomTile: true,
                            interval: 80,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return BloodSugarEntryCard(entry: data[index]);
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
                // Show add blood sugar screen as dialog
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: AddBloodSugarScreen(),
                      scrollable: true,
                    );
                  },
                );
                ref.refresh(bloodSugarEntriesProvider);
              },
              child: const Icon(Icons.add),
            ),
          );
        },
        loading: () => Center(
              child: Column(
                children: [
                  Text(
                    "Loading Blood sugar",
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: Constants.SPACING * 2),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
        error: (error, _) => BackgroundImageWidget(
              customAppBar: const CustomAppBar(
                title: "Blood Pressure Monitor 📈",
                color: Constants.bpShortCutBgColor,
              ),
              svgImage: 'assets/images/lab-empty-state.svg',
              notFoundText: "No BP Data Available to display",
              floatingButtonIcon: Icons.refresh,
              floatingButtonAction: () {
                ref.refresh(bloodSugarEntriesProvider);
              },
            ));
  }
}
