import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

_menuItems(BuildContext context) => [
  MenuItem(
    shortcutBackgroundColor: Constants.providerBgColor,
    icon: SvgPicture.asset(
      "assets/images/Calendar-Splash.svg",
      semanticsLabel: "Reschedule",
      fit: BoxFit.contain,
      width: 100,
      height: 100,
    ),
    shortcutIcon: SvgPicture.asset("assets/images/Calendar-Splash.svg",
        semanticsLabel: "Reschedule",
        fit: BoxFit.contain,
        width: Constants.shortcutIconSize,
        height: Constants.shortcutIconSize),
    title: "Appointment Reschedule Request",
    onPressed: () => context.goNamed(RouteNames.REQUEST_APP_RESCHEDULE),
    color: Constants.providerBgColor.withOpacity(0.5),
  ),
  MenuItem(
    shortcutBackgroundColor: Constants.providerBgColor,
    icon: SvgPicture.asset(
      "assets/images/shopping-cart-dawa.svg",
      semanticsLabel: "Dawa Drop Manager",
      fit: BoxFit.contain,
      width: 80,
      height: 80,
    ),
    shortcutIcon: SvgPicture.asset("assets/images/shopping-cart-dawa.svg",
        semanticsLabel: "Dawa Drop Manager",
        fit: BoxFit.contain,
        width: Constants.shortcutIconSize,
        height: Constants.shortcutIconSize),
    title: "Drug Order Manager",
    onPressed: () => context.goNamed(RouteNames.DAWA_DROP_MANAGER),
    color: Constants.providerBgColor.withOpacity(0.5),
  ),
  // MenuItem(
  //   shortcutBackgroundColor: Constants.dawaDropShortcutBgColor,
  //   icon: SvgPicture.asset(
  //     "assets/images/review.svg",
  //     semanticsLabel: "Dawa",
  //     fit: BoxFit.contain,
  //     width: 80,
  //     height: 80,
  //   ),
  //   shortcutIcon: SvgPicture.asset("assets/images/review.svg",
  //       semanticsLabel: "Dawa",
  //       fit: BoxFit.contain,
  //       width: Constants.shortcutIconSize,
  //       height: Constants.shortcutIconSize),
  //   title: "Confirm Delivery",
  //   onPressed: () => context.goNamed(RouteNames.DISPATCHED_DRUGS),
  //   color: theme.primaryColorDark.withOpacity(0.5),
  // ),
];

class ProviderMainScreen extends StatelessWidget {
  const ProviderMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _items = _menuItems(context);
    return Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              title: "Provider Modules 🏥",
              // icon: Icons.vaccines_sharp,
              color: Constants.providerBgColor,
            ),
            Expanded(
              child: MenuItemsBuilder(
                crossAxisCount: 2,
                itemBuilder: (item) => Card(
                  margin: const EdgeInsets.all(Constants.SPACING),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    splashColor: theme.primaryColorDark.withOpacity(0.5),
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
            )
          ],
        ));
  }
}
