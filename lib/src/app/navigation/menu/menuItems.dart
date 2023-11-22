import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/utils/routes.dart';

class MenuItem {
  final IconData icon;
  final String? title;
  final void Function()? onPressed;

  MenuItem({required this.icon, this.title, this.onPressed});
}

List<MenuItem> menuOptions(BuildContext context) => [
  MenuItem(
      icon: Icons.dashboard_customize_outlined,
      title: "Dashboard",
      onPressed: () => context.goNamed(RouteNames.DASHBOARD)),
      MenuItem(icon: Icons.speed, title: "Hypertension", onPressed: () => ""),
      MenuItem(icon: Icons.speed, title: "Asthma", onPressed: () => ""),
      MenuItem(icon: Icons.sick, title: "TB", onPressed: () => ""),
      MenuItem(icon: Icons.monitor_weight_outlined, title: "Diabetes", onPressed: () => ""),
      MenuItem(icon: Icons.group_work, title: "Cancer", onPressed: () => ""),
      MenuItem(
          icon: Icons.vaccines,
          title: "HIV",
          onPressed: () => context.goNamed(RouteNames.HIV_PROGRAM)),
      MenuItem(
          icon: Icons.calendar_month_rounded,
          title: "My calendar",
          onPressed: () => context.goNamed(RouteNames.EVENTS_CALENDAR)),
      MenuItem(
          icon: Icons.event_note,
          title: "Menstrual Cycle",
          onPressed: () => ""),
      MenuItem(
        icon: Icons.calculate_outlined,
        title: "BMI Calc",
        onPressed: () => context.goNamed(RouteNames.BMI_CALCULATOR),
      ),
      MenuItem(
          icon: Icons.add,
          title: "Add Programme",
          onPressed: () => context.goNamed(RouteNames.PROGRAME_REGISTRATION_SCREEN)),
    ];
