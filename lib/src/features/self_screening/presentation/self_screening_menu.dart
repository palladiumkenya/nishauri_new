import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

_menuItems(BuildContext context) => [
      MenuItem(
          icon: const Icon(Icons.calculate),
          shortcutIcon: const Icon(Icons.calculate),
          color: Constants.bmiCalculatorShortcutBgColor,
          shortcutBackgroundColor: Constants.bmiCalculatorShortcutBgColor,
          title: "BMI Calculator",
          onPressed: () => context.goNamed(RouteNames.BMI_CALCULATOR)),
      MenuItem(
          icon: const Icon(Icons.trending_up),
          shortcutIcon: const Icon(Icons.trending_up),
          color: Constants.bpShortCutBgColor,
          shortcutBackgroundColor: Constants.bpShortCutBgColor,
          title: "B P Monitor",
          onPressed: () => context.goNamed(RouteNames.BLOOD_PRESSURE)),
      MenuItem(
        // icon: FaIcon(FontAwesomeIcons.capsules, size: Constants.iconSize, color: Colors.teal[200],),
        shortcutBackgroundColor: Constants.dawaDropShortcutBgColor,
        icon: const Icon(Icons.sanitizer),
        shortcutIcon: Icon(Icons.sanitizer),
        title: MenuItemNames.BLOOD_SUGAR,
        onPressed: () => context.goNamed(MenuItemNames.BLOOD_SUGAR),
        color: Constants.bloodSugarColor.withOpacity(0.5),
      ),
    ];

class SelfScreening extends StatelessWidget {
  const SelfScreening({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _items = _menuItems(context);
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: theme.primaryColor,
        //   leading: IconButton(
        //     icon: const Icon(Icons.chevron_left),
        //     onPressed: () => context.pop(),
        //   ),
        //   title: const Text("HIV Program"),
        // ),
        body: Column(
      children: [
        CustomAppBar(
          title: "Self Screening🌡️📈",
          // icon: Icons.add_chart_rounded,
          color: Constants.bmiCalculatorColor,
        ),
        Expanded(
          child: MenuItemsBuilder(
            crossAxisCount: 3,
            itemBuilder: (item) => MenuOption(
              title: item.title ?? "",
              icon: item.shortcutIcon,
              bgColor: Constants.bmiCalculatorShortcutBgColor,
              onPress: item.onPressed,
            ),
            items: _items,
          ),
        )
      ],
    ));
  }
}
