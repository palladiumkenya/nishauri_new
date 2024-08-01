import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/bmi/data/providers/bmi_log_provider.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/BMILineGraph.dart';
import 'package:nishauri/src/features/bp/data/providers/blood_pressure_provider.dart';
import 'package:nishauri/src/features/bp/presentation/pages/trend_chart_screen.dart';

class GeneralDashboard extends ConsumerWidget {
  const GeneralDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bmiAsync = ref.watch(bmiListProvider);
    final bloodPressureAsync = ref.watch(bloodPressureListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        children: [
          Card(
            child: SizedBox(
              height: 350,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("BMI Trend", style: theme.textTheme.titleMedium),
                    Expanded(
                      child: bmiAsync.when(
                        data: (bmiData) {
                          final displayedData = bmiData.length > 5 ? bmiData.sublist(bmiData.length - 5) : bmiData;
                          return BMILineGraph(data: displayedData);
                        },

                        loading: () => Center(child: CircularProgressIndicator()),
                        error: (error, _) => Center(child: Text("No BMI Data")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 350,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Blood Pressure Trend", style: theme.textTheme.titleMedium),
                    Expanded(
                      child: bloodPressureAsync.when(
                        data: (bpData) {
                          final displayedData = bpData.length > 5 ? bpData.sublist(bpData.length - 5) : bpData;

                          return TrendChartScreen(data: displayedData);
                        },
                        loading: () => Center(child: CircularProgressIndicator()),
                        error: (error, _) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("No Blood Pressure Data"),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  ref.refresh(bloodPressureListProvider);
                                },
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.refresh(bmiListProvider);
          ref.refresh(bloodPressureListProvider);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
