import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

_menuItems(BuildContext context) => [
      MenuItem(
        shortcutBackgroundColor: Constants.dawaDropShortcutBgColor,
        icon: SvgPicture.asset(
          "assets/images/pills.svg",
          semanticsLabel: "Dawa",
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
        shortcutIcon: SvgPicture.asset("assets/images/shopping-meds.svg",
            semanticsLabel: "Dawa",
            fit: BoxFit.contain,
            width: Constants.shortcutIconSize,
            height: Constants.shortcutIconSize),
        title: "Request Drugs",
        onPressed: () => context.goNamed(RouteNames.REQUEST_DRUGS),
        color: Constants.dawaDropColor.withOpacity(0.5),
      ),
      MenuItem(
        shortcutBackgroundColor: Constants.dawaDropShortcutBgColor,
        icon: SvgPicture.asset(
          "assets/images/shopping.svg",
          semanticsLabel: "Dawa",
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
        shortcutIcon: SvgPicture.asset("assets/images/shopping.svg",
            semanticsLabel: "Dawa",
            fit: BoxFit.contain,
            width: Constants.shortcutIconSize,
            height: Constants.shortcutIconSize),
        title: "Drug Orders",
        onPressed: () => context.goNamed(RouteNames.HIV_DRUG_ORDERS),
        color: Constants.dawaDropColor.withOpacity(0.5),
      ),
      MenuItem(
        shortcutBackgroundColor: Constants.dawaDropShortcutBgColor,
        icon: SvgPicture.asset(
          "assets/images/review.svg",
          semanticsLabel: "Dawa",
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
        shortcutIcon: SvgPicture.asset("assets/images/review.svg",
            semanticsLabel: "Dawa",
            fit: BoxFit.contain,
            width: Constants.shortcutIconSize,
            height: Constants.shortcutIconSize),
        title: "Confirm Delivery",
        onPressed: () => context.goNamed(RouteNames.DISPATCHED_DRUGS),
        color: Constants.dawaDropColor.withOpacity(0.5),
      ),
    ];

class DawaDropMenuScreen extends StatelessWidget {
  const DawaDropMenuScreen({super.key});

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
        //   title: Text("Dawa Drop",
        //       style: theme.textTheme.titleMedium?.copyWith(
        //           color: Constants.dawaDropShortcutBgColor,
        //           fontWeight: FontWeight.normal,
        //           overflow: TextOverflow.ellipsis
        //       ),),
        // ),
        body: Column(
      children: [
        CustomAppBar(
          title: "Dawa Drop",
          icon: Icons.vaccines_sharp,
          color: Constants.dawaDropColor.withOpacity(0.5),
        ),
        Expanded(
          child: MenuItemsBuilder(
            crossAxisCount: 2,
            itemBuilder: (item) => Card(
              margin: const EdgeInsets.all(Constants.SPACING),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                splashColor: Constants.dawaDropShortcutBgColor,
                onTap: item.onPressed,
                child: Container(
                  padding: const EdgeInsets.all(Constants.SPACING),
                  decoration: BoxDecoration(
                    color: item.color ?? theme.colorScheme.primary,
                    // height: 50,
                    // decoration: BoxDecoration(
                    //   gradient: LinearGradient(
                    //     begin: Alignment.topCenter,
                    //     end: Alignment.bottomCenter,
                    //     colors: [
                    //       theme.colorScheme.inversePrimary,
                    //       theme.colorScheme.primary,
                    //     ],
                    //   ),
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

            // itemBuilder: (item) => MenuOption(
            //   title: item.title ?? "",
            //   icon: item.icon,
            //   onPress: item.onPressed,
            // ),
            items: _items,
          ),
        )
      ],
    ));
  }
}
