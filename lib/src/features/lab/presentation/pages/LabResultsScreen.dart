import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/lab/data/providers/VirolLoadprovider.dart';
import 'package:nishauri/src/features/lab/presentation/pages/LabResults.dart';
import 'package:nishauri/src/features/lab/presentation/widget/ViralLoadResult.dart';
import 'package:nishauri/src/features/lab/presentation/widget/ViralLoadTrend.dart';
import 'package:nishauri/src/features/user_programs/data/providers/program_provider.dart';
import 'package:nishauri/src/shared/display/CustomTabBar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/routes.dart';

class LabResultsScreen extends HookConsumerWidget {
  const LabResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final labAsync = ref.watch(viralLoadProvider);
    final userPrograms = ref.watch(userProgramProvider);
    final currIndex = useState(0);
    final isHivStatusActive = userPrograms.hasValue &&
        userPrograms.value!
            .where((element) =>
                element.id.toString() == ProgramCodeNameIds.HIV &&
                element.isActive)
            .isNotEmpty;

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
                color: Constants.labResultsColor,
              ),
              if (isHivStatusActive)
                CustomTabBar(
                  activeIndex: currIndex.value,
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
              if (isHivStatusActive) Expanded(child: screens[currIndex.value]),
              if (!isHivStatusActive)
                const Expanded(
                  child: BackgroundImageWidget(
                      svgImage: 'assets/images/background.svg',
                      notFoundText: "No Lab results"),
                )
            ],
          ),
        );
      },
      error: (error, _) => BackgroundImageWidget(
        customAppBar: CustomAppBar(
          title: "ART Lab Results",
          icon: Icons.vaccines,
          subTitle: "Unlock your health insights with lab results",
          color: Constants.labResultsColor,
        ),
        svgImage: 'assets/images/background.svg',
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
