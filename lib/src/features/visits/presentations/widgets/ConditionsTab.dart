import 'package:flutter/material.dart';
import 'package:nishauri/src/features/visits/data/models/condition.dart';

class ConditionsTab extends StatelessWidget {
  final List<Condition> conditions;

  const ConditionsTab({super.key, this.conditions = const []});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Conditions"),
    );
  }
}
