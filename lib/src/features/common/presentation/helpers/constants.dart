
import 'package:flutter/material.dart';

class MenuItem {
  final IconData icon;
  final String? title;

  MenuItem({required this.icon, this.title});

}

final menuOptions = [
  MenuItem(icon: Icons.medication, title: "Medications here bana and so long bana"),
  MenuItem(icon: Icons.science_outlined, title: "Lab"),
  MenuItem(icon: Icons.calendar_month_rounded, title: "Appointments very ver"),
  MenuItem(icon: Icons.science_outlined, title: "Lab"),
  MenuItem(icon: Icons.calendar_month_rounded, title: "Appointments"),
  MenuItem(icon: Icons.medication, title: "Medication"),  MenuItem(icon: Icons.medication, title: "Medication"),
  MenuItem(icon: Icons.science_outlined, title: "Lab"),
  MenuItem(icon: Icons.calendar_month_rounded, title: "Appointments"),
  MenuItem(icon: Icons.science_outlined, title: "Lab"),
  MenuItem(icon: Icons.calendar_month_rounded, title: "Appointments"),
  MenuItem(icon: Icons.medication, title: "Medication"),
];