import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/visits/data/models/condition.dart';
import 'package:nishauri/src/utils/constants.dart';

class ConditionsTab extends StatelessWidget {
  final List<Condition> conditions;

  const ConditionsTab({super.key, this.conditions = const []});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Text(
            "Conditions",
            style: theme.textTheme.headlineMedium,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text("Name", style: theme.textTheme.titleMedium)),
              DataColumn(label: Text("Value", style: theme.textTheme.titleMedium)),
              DataColumn(label: Text("Status", style: theme.textTheme.titleMedium)),
              DataColumn(label: Text("On set Date", style: theme.textTheme.titleMedium)),
              DataColumn(label: Text("Date Recorded", style: theme.textTheme.titleMedium))
            ],
            rows: conditions
                .map(
                  (e) => DataRow(
                cells: [
                  DataCell(Text(e.name)),
                  DataCell(Text(e.value)),
                  DataCell(Text(e.status)),
                  DataCell(
                    e.onsetDate != null && e.onsetDate?.isNotEmpty == true? Text(
                      DateFormat("dd MMM yyy").format(
                        DateTime.parse(e.onsetDate!),
                      ),
                    ): const Text("-"),
                  ),
                  DataCell(
                    Text(
                      DateFormat("dd MMM yyy").format(
                        DateTime.parse(e.dateRecorded),
                      ),
                    ),
                  ),
                ],
              ),
            )
                .toList(),
          ),
        ),
      ],
    );
  }
}
