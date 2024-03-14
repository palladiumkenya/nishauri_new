import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/utils/routes.dart';

class MenuItem {
  final IconData icon;
  final String? title;
  final void Function()? onPressed;

  MenuItem({required this.icon, this.title, this.onPressed});
}

MenuItem getProgramMenuItemByProgramCode(
    BuildContext context, String programCode) {
  if (programCode == ProgramCodeNameIds.HIV) {
    return MenuItem(
      icon: Icons.vaccines,
      title: MenuItemNames.HIV_PROGRAM_MENU,
      onPressed: () => context.goNamed(RouteNames.HIV_PROGRAM),
    );
  } else if (programCode == ProgramCodeNameIds.TB) {
    return MenuItem(
      icon: Icons.sick,
      title: MenuItemNames.TB_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.ASTHMA) {
    return MenuItem(
      icon: Icons.ac_unit,
      title: MenuItemNames.ASTHMA_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.DIABETES) {
    return MenuItem(
      icon: Icons.monitor_weight_outlined,
      title: MenuItemNames.DIABETES_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.CANCER) {
    return MenuItem(
      icon: Icons.group_work,
      title: MenuItemNames.CANCER_PROGRAM_MENU,
      onPressed: () => "",
    );
  } else if (programCode == ProgramCodeNameIds.HYPERTENSION) {
    return MenuItem(
        icon: Icons.speed,
        title: MenuItemNames.HYPERTENSION_PROGRAM_MENU,
        onPressed: () {});
  }
  return MenuItem(
    icon: Icons.more_horiz,
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
      icon: Icons.calendar_month,
      title: MenuItemNames.APPOINTMENTS,
      onPressed: () => context.goNamed(RouteNames.APPOINTMENTS),
    ),
    MenuItem(
      icon: Icons.vaccines_sharp,
      title: MenuItemNames.LAB_RESULTS,
      onPressed: () => context.goNamed(RouteNames.LAB_RESULTS),
    ),
    MenuItem(
      icon: Icons.file_present,
      title: MenuItemNames.MY_CLINIC_CARD,
      onPressed: () => context.goNamed(RouteNames.MY_CLINIC_CARD),
    ),
     MenuItem(
       icon: Icons.event_note,
       title: MenuItemNames.ART_DIRECTORY,
       onPressed: () => context.goNamed(RouteNames.ART_DIRECTORY),
     ),
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
      icon: Icons.calculate_outlined,
      title: MenuItemNames.BMI_CALCULATOR,
      onPressed: () => context.goNamed(RouteNames.BMI_CALCULATOR),
    ),
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
