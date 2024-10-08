import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

_menuItems(BuildContext context) => [
      MenuItem(
        icon: SvgPicture.asset(
          "assets/images/calendar.svg",
          semanticsLabel: "Doctors",
          fit: BoxFit.contain,
          height: 80,
          width: 80,
        ),
        shortcutIcon: SvgPicture.asset(
          "assets/images/calendar.svg",
          semanticsLabel: "Doctors",
          fit: BoxFit.contain,
          width: Constants.shortcutIconSize,
          height: Constants.shortcutIconSize,
        ),
        title: MenuItemNames.APPOINTMENTS,
        onPressed: () => context.goNamed(RouteNames.PROGRAM_APPOINTMENT),
        color: Constants.dawaDropColor.withOpacity(0.5),
      ),
      // MenuItem(
      //   icon: Icons.local_hospital_outlined,
      //   title: "Others",
      //   // onPressed: () => context.goNamed(RouteNames.HIV_DRUG_ORDERS),
      // ),
    ];

class RequestDrugMenuScreen extends StatelessWidget {
  const RequestDrugMenuScreen({super.key});

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
        //   title: const Text("Request Drug"),
        // ),
        body: Column(
      children: [
        CustomAppBar(
          title: "Drug Request 💊",
          // icon: Icons.vaccines_sharp,
          color: Constants.dawaDropColor.withOpacity(0.5),
        ),
        Expanded(
          child: MenuItemsBuilder(
            crossAxisCount: 2,
            itemBuilder: (item) => Card(
              margin: const EdgeInsets.all(Constants.SPACING),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                splashColor: theme.colorScheme.primary,
                onTap: item.onPressed,
                child: Container(
                  padding: const EdgeInsets.all(Constants.SPACING),
                  decoration: BoxDecoration(
                    color: item.color ?? theme.colorScheme.primary,
                    image: const DecorationImage(
                        image: AssetImage("assets/images/contours.png"),
                        opacity: 0.2,
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      item.icon,
                      const SizedBox(
                        height: Constants.SPACING,
                      ),
                      Text(
                        item.title ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
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
