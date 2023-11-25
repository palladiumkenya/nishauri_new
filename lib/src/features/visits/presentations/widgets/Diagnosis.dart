import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/visits/data/models/diagnosis.dart';
import 'package:nishauri/src/utils/constants.dart';

class DiagnosisTab extends StatelessWidget {
  final List<Diagnosis> diagnosis;
  const DiagnosisTab({super.key, this.diagnosis =const[]});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Text(
            "Diagnosis",
            style: theme.textTheme.headlineMedium,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text("Name", style: theme.textTheme.titleMedium)),
              DataColumn(label: Text("Value", style: theme.textTheme.titleMedium)),
              DataColumn(label: Text("Date Recorded", style: theme.textTheme.titleMedium))
            ],
            rows: diagnosis
                .map(
                  (e) => DataRow(
                cells: [
                  DataCell(Text(e.name)),
                  DataCell(Text(e.value)),
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
