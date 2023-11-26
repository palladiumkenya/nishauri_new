import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/visits/data/models/vital.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';

class VitalsTab extends StatelessWidget {
  final List<Vital> vitals;

  const VitalsTab({super.key, this.vitals = const []});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Constants.SPACING),
            child: Text(
              "Vitals",
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
                  DataColumn(label: Text("Date Recorded", style: theme.textTheme.titleMedium))
                ],
                rows: vitals
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
      ),
    );
  }
}
