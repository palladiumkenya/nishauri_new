import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/lab/data/providers/VirolLoadprovider.dart';
import 'package:nishauri/src/features/lab/presentation/pages/LabResults.dart';
import 'package:nishauri/src/features/lab/presentation/widget/ViralLoadResult.dart';
import 'package:nishauri/src/features/lab/presentation/widget/ViralLoadTrend.dart';
import 'package:nishauri/src/shared/display/CustomTabBar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

class LabResultsScreen extends HookConsumerWidget {
  const LabResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final labAsync = ref.watch(viralLoadProvider);
    final currIndex = useState(0);

    return labAsync.when(
      data: (data) {
        final screens = [
          ViralLoadResults(data: data),
          ViralLoadTrend(data: data),
        ];
        return Scaffold(
          body: Column(
            children: [
              const CustomAppBar(
                title: "ART Lab Results",
                icon: Icons.vaccines,
                subTitle: "Unlock you health insights with lab results",
                color: Colors.deepPurple,
              ),
              CustomTabBar(
                activeIndex: currIndex.value,
                activeColor: Colors.green,
                onTap: (item, index) {
                  currIndex.value = index;
                },
                items: const [
                  CustomTabBarItem(
                    title: "Viral Load results",
                    icon: Icons.medication,
                  ),
                  CustomTabBarItem(
                    title: "Viral Load Trend",
                    icon: Icons.auto_graph_outlined,
                  ),
                ],
              ),
              Expanded(child: screens[currIndex.value]),
            ],
          ),
        );
      },
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              error.toString(),
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: Constants.SPACING * 2),
          ],
        ),
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
