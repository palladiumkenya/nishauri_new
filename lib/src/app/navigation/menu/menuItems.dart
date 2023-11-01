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
  MenuItem(icon: Icons.medication, title: "Medications", onPressed: () => ""),
  MenuItem(icon: Icons.science_outlined, title: "Lab", onPressed: () => ""),
  MenuItem(icon: Icons.calendar_month_rounded, title: "Appointments", onPressed: () => ""),
  MenuItem(icon: Icons.science_outlined, title: "Lab",onPressed: () => ""),
  MenuItem(
      icon: Icons.calculate_outlined, title: "BMI Calc", onPressed: () => context.go(RouteNames.BMI_CALCULATOR)),
  MenuItem(icon: Icons.medication, title: "Medication", onPressed: () => ""),
  MenuItem(icon: Icons.medication, title: "Medication"),
  MenuItem(icon: Icons.science_outlined, title: "Lab"),
  MenuItem(icon: Icons.calendar_month_rounded, title: "Appointments"),
  MenuItem(icon: Icons.science_outlined, title: "Lab"),
  MenuItem(icon: Icons.calendar_month_rounded, title: "Appointments"),
  MenuItem(icon: Icons.medication, title: "Medication"),
];
