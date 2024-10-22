import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/self_screening/presentation/common/insight_common.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/features/self_screening/data/providers/insight_provider.dart';
import 'package:nishauri/src/utils/routes.dart';

class BsInsightScreen extends HookConsumerWidget {
  const BsInsightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const title = "Blood Sugar Awareness 🌡";
    const color = Constants.selfScreeningBgColor;
    final insightAsync = ref.watch(bsInsightProvider);

    return InsightCommon(
      appBarTitle: title,
      appBarColor: color,
      insightAsync: insightAsync,
      pathName: RouteNames.BLOOD_SUGAR_POSTS,
    );
  }
}
