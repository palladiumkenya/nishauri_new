import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/self_screening/data/providers/insight_provider.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

List<MenuItem> _menuItems(BuildContext context) => [
  MenuItem(
    icon: const Icon(Icons.calculate),
    shortcutIcon: const Icon(Icons.calculate),
    color: Constants.bmiCalculatorShortcutBgColor,
    shortcutBackgroundColor: Constants.bmiCalculatorShortcutBgColor,
    title: "BMI Calculator",
    onPressed: () => context.goNamed(RouteNames.BMI_CALCULATOR),
  ),
  MenuItem(
    icon: const Icon(Icons.trending_up),
    shortcutIcon: const Icon(Icons.trending_up),
    color: Constants.bpShortCutBgColor,
    shortcutBackgroundColor: Constants.bpShortCutBgColor,
    title: "B P Monitor",
    onPressed: () => context.goNamed(RouteNames.BLOOD_PRESSURE),
  ),
  MenuItem(
    shortcutBackgroundColor: Constants.dawaDropShortcutBgColor,
    icon: const Icon(Icons.sanitizer),
    shortcutIcon: const Icon(Icons.sanitizer),
    title: MenuItemNames.BLOOD_SUGAR,
    onPressed: () => context.goNamed(MenuItemNames.BLOOD_SUGAR),
    color: Constants.bloodSugarColor.withOpacity(0.5),
  ),
  MenuItem(
    shortcutBackgroundColor: Constants.periodPlannerShortcutBgColor,
    icon: const Icon(Icons.calendar_month_outlined),
    shortcutIcon: const Icon(Icons.calendar_month_outlined),
    title: MenuItemNames.PERIOD_PLANNER,
    onPressed: () {
      if(cycles.isEmpty) {
        context.goNamed(RouteNames.PERIOD_PLANNER_LOG_PERIODS);
      }
      else {
        context.goNamed(RouteNames.PERIOD_PLANNER_SCREEN);
      }
    },
    color: Constants.periodPlannerShortcutBgColor.withOpacity(0.5),
  ),
];

class SelfScreening extends HookConsumerWidget {
  const SelfScreening({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final _items = _menuItems(context);
    final insightAsync = ref.watch(insightProvider);

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Self Screening🌡️📈",
            color: Constants.bmiCalculatorColor,
          ),
          Expanded(
            child: MenuItemsBuilder(
              crossAxisCount: 3,
              itemBuilder: (item) => MenuOption(
                title: item.title ?? "",
                icon: item.shortcutIcon,
                bgColor: item.color ?? Constants.bmiCalculatorShortcutBgColor,
                onPress: item.onPressed,
              ),
              items: _items,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton(
          //     tooltip: "Insight",
          //     hoverColor: Constants.bmiCalculatorShortcutBgColor,
          //     onPressed: () {
          //       context.goNamed(RouteNames.SETTINGS);
          //
          //     },
          //     backgroundColor: Constants.bmiCalculatorShortcutBgColor,
          //     child: const Icon(Icons.settings),
          //   ),
          // SizedBox(height: 10),
          FloatingActionButton(
            tooltip: "Module insight",
            hoverColor: Constants.bmiCalculatorShortcutBgColor,
            onPressed: () {
              context.goNamed(RouteNames.INSIGHT);
            },
            backgroundColor: Constants.bmiCalculatorShortcutBgColor,
            child: const Icon(Icons.insights),
          ),
        ],
      ),
    );
  }
}
