import 'package:flutter/material.dart';
import 'package:nishauri/src/features/blood_sugar/data/models/blood_sugar.dart';

class BloodSugarEntryCard extends StatelessWidget {
  final BloodSugar entry;

  const BloodSugarEntryCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Blood Sugar Level: ${entry.level.toStringAsFixed(1)}'),
        subtitle: Text('Condition: ${entry.condition}'),
        // trailing timestamp of the entry in the format: 2021-09-01
        trailing: Text(entry.timestamp.toString().substring(0, 10)),
      ),
    );
  }
}
