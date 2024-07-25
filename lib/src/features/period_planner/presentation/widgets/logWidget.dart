import 'package:flutter/material.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/logger.dart';

class LoggerWidget extends StatelessWidget {
  final String heading;
  final List<Logger> items;

  LoggerWidget({required this.heading, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          heading,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items.map((item) => _buildItemCard(item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(Logger item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Icon(item.icon, size: 40, color: item.color),
          const SizedBox(height: 8),
          Text(item.label),
        ],
      ),
    );
  }
}
