import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class MenuItem {
  final Widget icon;
  final String? title;
  final void Function()? onPressed;
  final Color? color;
  final Widget shortcutIcon;
  final Color? shortcutBackgroundColor;

  MenuItem({
    required this.icon,
    this.title,
    this.onPressed,
    this.color,
    this.shortcutBackgroundColor,
    required this.shortcutIcon,
  });
}

MenuItem getProgramMenuItemByProgramCode(BuildContext context, String programCode) {
  final theme = Theme.of(context);
  switch (programCode) {
    case ProgramCodeNameIds.HIV:
      return MenuItem(
        icon: const Icon(Icons.vaccines, size: Constants.iconSize),
        shortcutIcon: const Icon(Icons.vaccines),
        title: MenuItemNames.HIV_PROGRAM_MENU,
        onPressed: () => context.goNamed(RouteNames.HIV_PROGRAM),
        color: Constants.appointmentsColor,
      );
    case ProgramCodeNameIds.TB:
      return MenuItem(
        icon: const Icon(Icons.sick, size: Constants.iconSize),
        shortcutIcon: const Icon(Icons.sick),
        title: MenuItemNames.TB_PROGRAM_MENU,
        onPressed: () => "",
      );
    case ProgramCodeNameIds.ASTHMA:
      return MenuItem(
        icon: const Icon(Icons.ac_unit, size: Constants.iconSize),
        shortcutIcon: const Icon(Icons.ac_unit),
        title: MenuItemNames.ASTHMA_PROGRAM_MENU,
        onPressed: () => "",
      );
    case ProgramCodeNameIds.DIABETES:
      return MenuItem(
        icon: const Icon(Icons.monitor_weight_outlined, size: Constants.iconSize),
        shortcutIcon: const Icon(Icons.monitor_weight_outlined),
        title: MenuItemNames.DIABETES_PROGRAM_MENU,
        onPressed: () => "",
      );
    case ProgramCodeNameIds.CANCER:
      return MenuItem(
        icon: const Icon(Icons.group_work, size: Constants.iconSize),
        shortcutIcon: const Icon(Icons.group_work),
        title: MenuItemNames.CANCER_PROGRAM_MENU,
        onPressed: () => "",
      );
    case ProgramCodeNameIds.HYPERTENSION:
      return MenuItem(
        icon: const Icon(Icons.speed, size: Constants.iconSize),
        shortcutIcon: const Icon(Icons.speed),
        title: MenuItemNames.HYPERTENSION_PROGRAM_MENU,
        onPressed: () => "",
      );
    default:
      return MenuItem(
        icon: const Icon(Icons.more_horiz, size: Constants.iconSize),
        shortcutIcon: const Icon(Icons.more_horiz),
      );
  }
}

List<MenuItem> getProviderModules(BuildContext context) {
  return [
    MenuItem(
      shortcutBackgroundColor: Constants.providerBgColor.withOpacity(0.5),
      icon: SvgPicture.asset(
        "assets/images/patient.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        width: 80,
        height: 80,
      ),
      shortcutIcon: SvgPicture.asset(
        "assets/images/patient.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        width: Constants.shortcutIconSize,
        height: Constants.shortcutIconSize,
      ),
      title: MenuItemNames.PROVIDER_MAIN_SCREEN,
      onPressed: () => context.goNamed(RouteNames.PROVIDER_MAIN_SCREEN),
      color: Constants.providerBgColor,
    ),
  ];
}

List<MenuItem> getPartnerModules(BuildContext context) {
  return [
    // MenuItem(
    //   color: Constants.programsColor,
    //   icon: FaIcon(
    //     Icons.file_copy_outlined,
    //     size: Constants.iconSize,
    //     color: Theme.of(context).colorScheme.inversePrimary,
    //   ),
    //   shortcutIcon: const FaIcon(Icons.file_copy_outlined),
    //   title: MenuItemNames.PARTNER,
    //   onPressed: () => context.goNamed(RouteNames.PARTNER),
    // ),
  ];
}

List<MenuItem> getAdminModules(BuildContext context) {
  return [
    // MenuItem(
    //   color: Constants.programsColor,
    //   icon: FaIcon(
    //     Icons.file_copy_outlined,
    //     size: Constants.iconSize,
    //     color: Theme.of(context).colorScheme.inversePrimary,
    //   ),
    //   shortcutIcon: const FaIcon(Icons.file_copy_outlined),
    //   title: MenuItemNames.ADMIN,
    //   onPressed: () => context.goNamed(RouteNames.ADMIN),
    // ),
  ];
}

List<MenuItem> getFacilityAdminModules(BuildContext context) {
  return [
    // MenuItem(
    //   color: Constants.programsColor,
    //   icon: FaIcon(
    //     Icons.file_copy_outlined,
    //     size: Constants.iconSize,
    //     color: Theme.of(context).colorScheme.inversePrimary,
    //   ),
    //   shortcutIcon: const FaIcon(Icons.file_copy_outlined),
    //   title: MenuItemNames.FACILITY_ADMIN,
    //   onPressed: () => context.goNamed(RouteNames.FACILITY_ADMIN),
    // ),
  ];
}

List<MenuItem> getPatientModules(BuildContext context) {
  return [
    MenuItem(
      color: Constants.programsColor,
      icon: FaIcon(
        Icons.file_copy_outlined,
        size: Constants.iconSize,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      shortcutIcon: const FaIcon(Icons.file_copy_outlined),
      title: MenuItemNames.PROGRAM_MENU,
      onPressed: () => context.goNamed(RouteNames.PROGRAM_MENU),
    ),
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
      onPressed: () => context.goNamed(RouteNames.APPOINTMENTS),
      color: Constants.appointmentsColor,
    ),
    MenuItem(
      shortcutBackgroundColor: Constants.labResultsShortcutBgColor,
      icon: SvgPicture.asset(
        "assets/images/syringe.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        height: 80,
        width: 80,
      ),
      shortcutIcon: SvgPicture.asset(
        "assets/images/syringe.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        width: Constants.shortcutIconSize,
        height: Constants.shortcutIconSize,
      ),
      title: MenuItemNames.LAB_RESULTS,
      onPressed: () => context.goNamed(RouteNames.LAB_RESULTS),
      color: Constants.labResultsColor,
    ),
    MenuItem(
      icon: FaIcon(
        FontAwesomeIcons.addressCard,
        size: 50.0,
        color: Colors.blue[400],
      ),
      shortcutIcon: FaIcon(
        FontAwesomeIcons.addressCard,
        color: Colors.blue[400],
      ),
      title: MenuItemNames.MY_CLINIC_CARD,
      onPressed: () => context.goNamed(RouteNames.MY_CLINIC_CARD),
      color: Colors.blue[900],
    ),

    MenuItem(
      icon: SvgPicture.asset(
        "assets/images/Hospital building-bro.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        height: 80,
        width: 80,
      ),
      shortcutIcon: SvgPicture.asset(
        "assets/images/Hospital building-bro.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        width: Constants.shortcutIconSize,
        height: Constants.shortcutIconSize,
      ),
      title: "FACILITY VISITS",
      onPressed: () => context.goNamed(RouteNames.FACILITY_VISITS),
      color: Colors.blueGrey,
    ),

    MenuItem(
      icon: SvgPicture.asset(
        "assets/images/house.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        height: 80,
        width: 80,
      ),
      shortcutIcon: SvgPicture.asset(
        "assets/images/house.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        width: Constants.shortcutIconSize,
        height: Constants.shortcutIconSize,
      ),
      title: MenuItemNames.FACILITY_DIRECTORY,
      onPressed: () => context.goNamed(RouteNames.Facility_Directory),
      color: Constants.facilityDirectoryColor,
    ),
    MenuItem(
      shortcutBackgroundColor: Constants.bmiCalculatorShortcutBgColor,
      icon: SvgPicture.asset(
        "assets/images/healthcare-medical.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        height: 80,
        width: 80,
      ),
      shortcutIcon: SvgPicture.asset(
        "assets/images/healthcare-medical.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        width: Constants.shortcutIconSize,
        height: Constants.shortcutIconSize,
      ),
      title: MenuItemNames.SELF_SCREENING,
      onPressed: () => context.goNamed(RouteNames.SELF_SCREENING),
      color: Constants.bmiCalculatorColor,
    ),
    MenuItem(
      shortcutBackgroundColor: Constants.dawaDropShortcutBgColor,
      icon: SvgPicture.asset(
        "assets/images/pills.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        width: 80,
        height: 80,
      ),
      shortcutIcon: SvgPicture.asset(
        "assets/images/pills.svg",
        semanticsLabel: "Doctors",
        fit: BoxFit.contain,
        width: Constants.shortcutIconSize,
        height: Constants.shortcutIconSize,
      ),
      title: MenuItemNames.DAWA_DROP,
      onPressed: () => context.goNamed(RouteNames.DAWA_DROP),
      color: Constants.dawaDropColor.withOpacity(0.5),
    ),

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
      title: "Location selection",
      onPressed: () => context.goNamed(RouteNames.LOCATION_SELECTION),
      color: Constants.appointmentsColor,
    ),
  ];
}

List<MenuItem> getGenericMenuItems(BuildContext context, List<String> roles) {
  List<MenuItem> menuItems = List.from(getPatientModules(context));

  if (roles.contains("Provider")) {
    menuItems.addAll(getProviderModules(context));
  }

  if (roles.contains("Admin")) {
    menuItems.addAll(getAdminModules(context));
    // Remove patient and provider modules if admin
    menuItems.removeWhere((item) =>
    item.title == MenuItemNames.PROGRAM_MENU ||
        item.title == MenuItemNames.PROVIDER_MAIN_SCREEN
    );
  }

  return menuItems;
}

List<MenuItem> getMenuItemByNames(BuildContext context, List<String> names, List<String> roles) {
  const programNames = ProgramCodeNameIds.SUPPOTED_PROGRAM_CODES;
  return [
    ...getGenericMenuItems(context, roles),
    ...programNames.map((e) => getProgramMenuItemByProgramCode(context, e)),
  ].where(
        (menuItem) => names.contains(menuItem.title),
  ).toList();
}
