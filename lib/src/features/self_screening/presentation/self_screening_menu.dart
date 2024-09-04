import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/features/common/presentation/pages/HomeScreen.dart';
import 'package:nishauri/src/features/common/presentation/pages/SettingsScreen.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
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
    onPressed: () => context.goNamed(MenuItemNames.PERIOD_PLANNER),
    color: Constants.periodPlannerShortcutBgColor.withOpacity(0.5),
  ),
];

class SelfScreening extends StatefulWidget {
  const SelfScreening({super.key});

  @override
  _SelfScreeningState createState() => _SelfScreeningState();
}

class _SelfScreeningState extends State<SelfScreening> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _items = _menuItems(context);

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
          FloatingActionButton(
            tooltip: "Insight",
            hoverColor: Constants.bmiCalculatorShortcutBgColor,
            onPressed: () {  },
            backgroundColor: Constants.bmiCalculatorShortcutBgColor,
            child: const Icon(Icons.insights),
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
            tooltip: "Settings",
            hoverColor: Constants.bmiCalculatorShortcutBgColor,
            onPressed: () {  },
            backgroundColor: Constants.bmiCalculatorShortcutBgColor,
            child: const Icon(Icons.settings_applications_sharp),
          ),
        ],
      )
    );
  }
}
