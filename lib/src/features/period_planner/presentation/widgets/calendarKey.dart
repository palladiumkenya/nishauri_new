import 'package:flutter/material.dart';

class CalendarKey extends StatelessWidget {
  final Color color;
  final String label;

  const CalendarKey({
    super.key,
    required this.color,
    required this.label,
    });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
           width: 16,
          height: 16,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ), 
        ),
        Text(label),
      ],
    );
  }
}