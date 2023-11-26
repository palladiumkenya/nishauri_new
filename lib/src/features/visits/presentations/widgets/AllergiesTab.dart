import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/visits/data/models/allergy.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';

class AllergiesTab extends StatelessWidget {
  final List<Allergy> allergies;

  const AllergiesTab({super.key, this.allergies = const []});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Constants.SPACING),
          child: Text(
            "Allergies",
            style: theme.textTheme.headlineMedium,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AppCard(
            child: DataTable(
              columns: [
                DataColumn(label: Text("Allergen", style: theme.textTheme.titleMedium)),
                DataColumn(label: Text("Reaction", style: theme.textTheme.titleMedium)),
                DataColumn(label: Text("Severity", style: theme.textTheme.titleMedium)),
                DataColumn(label: Text("Date Recorded", style: theme.textTheme.titleMedium))
              ],
              rows: allergies
                  .map(
                    (e) => DataRow(
                  cells: [
                    DataCell(Text(e.allergen)),
                    DataCell(Text(e.reaction)),
                    DataCell(Text(e.severity)),
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
