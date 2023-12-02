import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/visits/data/models/lab_result.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';

class LabResultsTab extends StatelessWidget {
  final List<LabResult> labResult;
  const LabResultsTab({super.key, this.labResult=const[]});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Text(
            "Lab results",
            style: theme.textTheme.headlineMedium,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AppCard(
            child: DataTable(
              columns:  [
                DataColumn(label: Text("Name", style: theme.textTheme.titleMedium)),
                DataColumn(label: Text("Value", style: theme.textTheme.titleMedium)),
                DataColumn(label: Text("Date Recorded", style: theme.textTheme.titleMedium))
              ],
              rows: labResult
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
        ),
      ],
    );
  }
}
