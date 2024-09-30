import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/self_screening/data/providers/insight_provider.dart';
import 'package:nishauri/src/features/self_screening/presentation/common/insight_common.dart';
import 'package:nishauri/src/utils/constants.dart';

class BpInsightScreen extends HookConsumerWidget {
  const BpInsightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const title = "Blood Pressure Awareness 🌡";
    const color = Constants.bmiCalculatorColor;
    final insightAsync = ref.watch(insightProvider);

    return InsightCommon(
      appBarTitle: title,
      appBarColor: color,
      insightAsync: insightAsync,
    );
  }
}
