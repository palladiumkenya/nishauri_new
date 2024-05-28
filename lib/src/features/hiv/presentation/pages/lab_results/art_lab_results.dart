import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/shared/display/chevron_tabbar.dart';

import '../../../../../shared/display/CustomTabBar.dart';
import '../../../../../shared/display/background_image_widget.dart';
import '../../../../../utils/constants.dart';
import '../../../../lab/data/providers/VirolLoadprovider.dart';
import '../../../../lab/presentation/widget/ViralLoadResult.dart';
import '../../../../lab/presentation/widget/ViralLoadTrend.dart';

class ARTLabResults extends HookConsumerWidget {
  const ARTLabResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labAsync = ref.watch(viralLoadProvider);
    final currIndex = useState(0);
    final theme = Theme.of(context);

    return labAsync.when(
      data: (data) {
        final screens = [
          ViralLoadResults(data: data),
          ViralLoadTrend(data: data),
        ];
        final tabItems = [ "Viral Load Results", "Viral Load Trend"];
        return Scaffold(
          body: Column(
            children: [
              ChevronTabBar(
                activeIndex: currIndex.value,
                onActiveIndexChange: (index) {
                  currIndex.value = index;
                },
                items: tabItems,
              ),
              Expanded(child: screens[currIndex.value]),
            ],
          ),
        );
      },
      error: (error, _) => BackgroundImageWidget(
        svgImage: 'assets/images/lab-empty-state.svg',
        notFoundText: error.toString(),
      ),
      // Text(error.toString())),
      loading: () => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading Lab Results",
              style: theme.textTheme.headline6,
            ),
            const SizedBox(height: Constants.SPACING * 2),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
