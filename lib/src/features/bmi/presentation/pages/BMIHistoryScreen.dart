import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/bmi/data/providers/bmi_log_provider.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/BMILineGraph.dart';
import 'package:nishauri/src/features/bmi/presentation/widgets/BMILineList.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/constants.dart';

class BMIHistoryScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final bmiListAsync = ref.watch(bmiListProvider);

          return bmiListAsync.when(
            data: (data) {
              final displayedData = data.length > 5 ? data.sublist(data.length - 5) : data;
              return Column(
                children: [
                  const CustomAppBar(
                    title: "BMI Monitor 📈",
                    // icon: Icons.trending_up,
                    color: Constants.bmiCalculatorColor,
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: BMILinelist(data: data),
                            ),
                            Expanded(
                              flex: 1,
                              child: BMILineGraph(data: displayedData),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => BackgroundImageWidget(
              customAppBar: const CustomAppBar(
                title: "BMI Monitor 📈",
                // icon: Icons.trending_up,
                color: Constants.bmiCalculatorColor,
              ),
              svgImage: 'assets/images/lab-empty-state.svg',
              notFoundText: "No BMI Data",
              floatingButtonIcon1: Icons.refresh,
              floatingButtonAction1: () {
                ref.refresh(bmiListProvider);
              },
            ),
          );
        },
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          return FloatingActionButton(
            onPressed: () {
              ref.refresh(bmiListProvider);
            },
            backgroundColor: Constants.bmiCalculatorColor,
            child: const Icon(Icons.refresh),
          );
        },
      ),
    );
  }
}
