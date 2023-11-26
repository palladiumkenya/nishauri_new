import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/visits/data/models/complaint.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';

class ComplaintsTab extends StatelessWidget {
  final List<Complaint> complaints;
  const ComplaintsTab({super.key, this.complaints=const[]});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Text(
            "Complaints",
            style: theme.textTheme.headlineMedium,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AppCard(
            variant: CardVariant.OUTLINED,
            child: DataTable(
              columns: [
                DataColumn(label: Text("Name", style: theme.textTheme.titleMedium)),
                DataColumn(label: Text("Value", style: theme.textTheme.titleMedium)),
                DataColumn(label: Text("On set Date", style: theme.textTheme.titleMedium)),
                DataColumn(label: Text("Date Recorded", style: theme.textTheme.titleMedium))
              ],
              rows: complaints
                  .map(
                    (e) => DataRow(
                  cells: [
                    DataCell(Text(e.name)),
                    DataCell(Text(e.value)),
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
        ),
      ],
    );
  }
}
