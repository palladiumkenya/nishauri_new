import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/features/hiv/presentation/pages/lab_results/art_lab_results.dart';
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

import '../../../user_programs/data/models/user_program.dart';

class LabResultsScreen extends HookConsumerWidget {
  const LabResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userPrograms = ref.watch(userProgramProvider);
    final currIndex = useState(0);

    final screen = [
      ..._getProgramSpecificLabTest(userPrograms.valueOrNull ?? []),

      const Center(
        child: BackgroundImageWidget(
            svgImage: 'assets/images/lab-empty-state.svg',
            notFoundText: "No laboratory stool test uploaded yet. Check again"),
      ),
      const Center(
        child: BackgroundImageWidget(
            svgImage: 'assets/images/lab-empty-state.svg',
            notFoundText: "No laboratory blood test uploaded yet. Check again"),
      ),
      const Center(
        child: BackgroundImageWidget(
            svgImage: 'assets/images/lab-empty-state.svg',
            notFoundText: "No laboratory urine test uploaded yet. Check again"),
      ),
    ];

    return Scaffold(
        body: Column(
      children: [
        const CustomAppBar(
          title: "Lab Results",
          icon: FontAwesomeIcons.vial,
          subTitle: "Unlock you health insights with lab results",
          color: Constants.labResultsColor,
        ),
        CustomTabBar(
          onTap: (item, index) {
            currIndex.value = index;
          },
          activeColor: Constants.labResultsColor,
          activeIndex: currIndex.value,
          items: [
            ..._getProgramSpecificTestTabBarItem(userPrograms.valueOrNull ?? []),
            const CustomTabBarItem(title: "Stool Test"),
            const CustomTabBarItem(title: "Blood Test"),
            const CustomTabBarItem(title: "Urine Test"),
          ],
        ),
        Expanded(child: screen[currIndex.value]),

      ],
    ));
  }
}

List<CustomTabBarItem> _getProgramSpecificTestTabBarItem(
    List<UserProgram> programs) {
  final List<CustomTabBarItem> tabs = [];
  programs.where((element) => element.isActive).forEach((e) {
    if (e.id == ProgramCodeNameIds.HIV) {
      tabs.add(const CustomTabBarItem(title: "Viral Load Test"));
    }
  });
  return tabs;
}

List<Widget> _getProgramSpecificLabTest(List<UserProgram> programs) {
  final List<Widget> screens = [];
  programs.where((element) => element.isActive).forEach((e) {
    if (e.id == ProgramCodeNameIds.HIV) {
      screens.add(const ARTLabResults());
    }
  });
  return screens;
}
