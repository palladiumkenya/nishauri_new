import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/utils/routes.dart';

class MenuItem {
  final Widget icon;
  final String? title;
  final void Function()? onPressed;
  final Color? color;

  MenuItem({required this.icon, this.title, this.onPressed, this.color});
}

MenuItem getProgramMenuItemByProgramCode(
    BuildContext context, String programCode) {
  if (programCode == ProgramCodeNameIds.HIV) {
    return MenuItem(
        icon: Icon(Icons.vaccines),
        title: MenuItemNames.HIV_PROGRAM_MENU,
        onPressed: () => context.goNamed(RouteNames.HIV_PROGRAM),
        color: Colors.green);
  } else if (programCode == ProgramCodeNameIds.TB) {
    return MenuItem(
      icon: Icon(Icons.sick),
      title: MenuItemNames.TB_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.ASTHMA) {
    return MenuItem(
      icon: Icon(Icons.ac_unit),
      title: MenuItemNames.ASTHMA_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.DIABETES) {
    return MenuItem(
      icon: Icon(Icons.monitor_weight_outlined),
      title: MenuItemNames.DIABETES_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.CANCER) {
    return MenuItem(
      icon: Icon(Icons.group_work),
      title: MenuItemNames.CANCER_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.HYPERTENSION) {
    return MenuItem(
        icon: Icon(Icons.speed),
        title: MenuItemNames.HYPERTENSION_PROGRAM_MENU,
        onPressed: () {});
  }
  return MenuItem(
    icon: Icon(Icons.more_horiz),
  );
}

List<MenuItem> getGenericMenuItems(BuildContext context) {
  return [
    // MenuItem(
    //   icon: Icons.calendar_month_rounded,
    //   title: MenuItemNames.MY_CALENDAR,
    //   onPressed: () => context.goNamed(RouteNames.EVENTS_CALENDAR),
    // ),
    // MenuItem(
    //   icon: Icons.dashboard_customize_outlined,
    //   title: MenuItemNames.DASHBOARD,
    //   onPressed: () => context.goNamed(RouteNames.DASHBOARD),
    // ),

    MenuItem(
      icon: Icon(Icons.file_copy_outlined),
      title: MenuItemNames.PROGRAM_MENU,
      onPressed: () => context.goNamed(RouteNames.PROGRAM_MENU),
    ),

    MenuItem(
        icon: SvgPicture.asset(
          "assets/images/calendar.svg",
          semanticsLabel: "Doctors",
          fit: BoxFit.contain,
        ),
        title: MenuItemNames.APPOINTMENTS,
        onPressed: () => context.goNamed(RouteNames.APPOINTMENTS),
        color: Colors.green),
    MenuItem(
        icon: SvgPicture.asset(
          "assets/images/syringe.svg",
          semanticsLabel: "Doctors",
          fit: BoxFit.contain,
        ),
        title: MenuItemNames.LAB_RESULTS,
        onPressed: () => context.goNamed(RouteNames.LAB_RESULTS),
        color: Colors.deepOrange),
    MenuItem(
        icon: Icon(Icons.file_present),
        title: MenuItemNames.MY_CLINIC_CARD,
        onPressed: () => context.goNamed(RouteNames.MY_CLINIC_CARD),
        color: Colors.blue),
    MenuItem(
        icon: SvgPicture.asset(
          "assets/images/house.svg",
          semanticsLabel: "Doctors",
          fit: BoxFit.contain,
        ),
        title: MenuItemNames.FACILITY_DIRECTORY,
        onPressed: () => context.goNamed(RouteNames.Facility_Directory),
        color: Colors.black12),
    // MenuItem(
    //   icon: Icons.group,
    //   title: MenuItemNames.TREATMENT_SUPPORT,
    //   onPressed: () => context.goNamed(RouteNames.TREATMENT_SUPPORT),
    // ),
    // MenuItem(
    //   icon: Icons.event_note,
    //   title: MenuItemNames.MENSTRUAL_CIRCLE,
    //   onPressed: () => "",
    // ),
    MenuItem(
        icon: SvgPicture.asset(
          "assets/images/calculator.svg",
          semanticsLabel: "Doctors",
          fit: BoxFit.contain,
        ),
        title: MenuItemNames.BMI_CALCULATOR,
        onPressed: () => context.goNamed(RouteNames.BMI_CALCULATOR),
        color: Colors.cyan),

    MenuItem(
        icon: SvgPicture.asset(
          "assets/images/pills.svg",
          semanticsLabel: "Doctors",
          fit: BoxFit.contain,
          width: 60,
          height: 60,
        ),
        title: MenuItemNames.DAWA_DROP,
        onPressed: () => context.goNamed(RouteNames.DAWA_DROP),
        color: Colors.lightGreenAccent),
    // MenuItem(
    //   icon: Icons.move_down,
    //   title: MenuItemNames.FACILITY_VISITS,
    //   onPressed: () => context.goNamed(RouteNames.FACILITY_VISITS),
    // ),
    // MenuItem(
    //   icon: Icons.send,
    //   title: MenuItemNames.CHAT_HCW,
    //   onPressed: () => context.goNamed(RouteNames.CHAT_HCW),
    // ),
  ];
}

List<MenuItem> getMenuItemByNames(BuildContext context, List<String> names) {
  const programNames = ProgramCodeNameIds.SUPPOTED_PROGRAM_CODES;
  return [
    ...getGenericMenuItems(context),
    ...programNames.map((e) => getProgramMenuItemByProgramCode(context, e)),
  ]
      .where(
        (menuItem) => names.any((name) => name == menuItem.title),
      )
      .toList();
}
