import 'package:flutter/material.dart';
import 'package:nishauri/src/features/blood_sugar/data/models/blood_sugar.dart';

class BloodSugarEntryCard extends StatelessWidget {
  final BloodSugar entry;

  BloodSugarEntryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Level: ${entry.level}'),
        subtitle: Text('Date: ${entry.timestamp}'),
      ),
    );
  }
}
