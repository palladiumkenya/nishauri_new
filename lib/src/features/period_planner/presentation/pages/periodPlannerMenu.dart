import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

_menuItems(BuildContext context) => [
      MenuItem(
        shortcutBackgroundColor: Constants.periodPlannerShortcutBgColor,
        icon: SvgPicture.asset(
          "assets/images/period_planner4.svg",
          semanticsLabel: "Periods",
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
        shortcutIcon: SvgPicture.asset("assets/images/shopping-meds.svg",
            semanticsLabel: "Periods",
            fit: BoxFit.contain,
            width: Constants.shortcutIconSize,
            height: Constants.shortcutIconSize),
        title: "Track Periods",
        onPressed: () => context.goNamed(RouteNames.PERIOD_PLANNER_SCREEN),
        color: Constants.periodPlanner.withOpacity(1.0),
      ),
      MenuItem(
        shortcutBackgroundColor: Constants.dawaDropShortcutBgColor,
        icon: SvgPicture.asset(
          "assets/images/shopping.svg",
          semanticsLabel: "Periods",
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
        shortcutIcon: SvgPicture.asset("assets/images/shopping.svg",
            semanticsLabel: "Periods",
            fit: BoxFit.contain,
            width: Constants.shortcutIconSize,
            height: Constants.shortcutIconSize),
        title: "Period Calendar",
        onPressed: () => context.goNamed(RouteNames.HIV_DRUG_ORDERS),
        color: Constants.periodPlanner.withOpacity(1.0),
      ),
      MenuItem(
        shortcutBackgroundColor: Constants.dawaDropShortcutBgColor,
        icon: SvgPicture.asset(
          "assets/images/review.svg",
          semanticsLabel: "Periods",
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
        shortcutIcon: SvgPicture.asset("assets/images/review.svg",
            semanticsLabel: "Periods",
            fit: BoxFit.contain,
            width: Constants.shortcutIconSize,
            height: Constants.shortcutIconSize),
        title: "Partners",
        onPressed: () => context.goNamed(RouteNames.DISPATCHED_DRUGS),
        color: Constants.periodPlanner.withOpacity(1.0),
      ),
    ];

class PeriodPlannerMenu extends StatelessWidget {
  const PeriodPlannerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _items = _menuItems(context);

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Period Planner 🌸",
            color: Constants.periodPlanner.withOpacity(1.0),
            ),
            Expanded(
              child: MenuItemsBuilder(
                crossAxisCount: 2,
              itemBuilder: (item) => Card(
                margin: const EdgeInsets.all(Constants.SPACING),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  splashColor: Constants.periodPlannerShortcutBgColor,
                  onTap: item.onPressed,
                  child: Container(
                    padding: const EdgeInsets.all(Constants.SPACING),
                    decoration: BoxDecoration(
                      color: item.color ?? theme.colorScheme.primary,
                      image: const DecorationImage(
                        image: AssetImage("assets/images/contours.png"),
                        opacity: 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          item.icon,
                          const SizedBox(height: Constants.SPACING),
                          Text(
                            item.title ?? '',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            items: _items,
              ),
              ),
        ],
      ),
    );
  }
}