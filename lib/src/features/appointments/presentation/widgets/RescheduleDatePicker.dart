import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/utils/constants.dart';

class RescheduleDatePicker extends StatelessWidget {
  final DateTime appointmentTime;
  final int allowedScheduleDurationInDays;
  final DateTime? selectedDate;
  final void Function(DateTime date)? onSelectedDateChange;

  const RescheduleDatePicker(
      {super.key,
      required this.appointmentTime,
      this.allowedScheduleDurationInDays = 7,
      this.selectedDate,
      this.onSelectedDateChange});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final durationAllowed = Duration(days: allowedScheduleDurationInDays);
    final earliestDate = appointmentTime.subtract(durationAllowed);
    final latestDate = appointmentTime.add(durationAllowed);
    final today = DateTime.now();

    final datesAllowed = _findDatesBetween(earliestDate, latestDate)
        .where((element) => element.isAfter(today));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Date",
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: Constants.SPACING),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: datesAllowed.map(
              (e) {
                final difference = selectedDate?.difference(e).inDays;
                final isActive = difference != null && difference == 0;
                return Row(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            Constants.ROUNDNESS * 2,
                          ),
                        ),
                      ),
                      color: isActive
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primary.withOpacity(0.1),
                      elevation: 0,
                      child: InkWell(
                        splashColor: theme.colorScheme.primary,
                        onTap: () {
                          if (onSelectedDateChange != null) {
                            onSelectedDateChange!(e);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Constants.SPACING * 2, vertical: Constants.SPACING),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat("dd").format(e),
                                style: theme.textTheme.titleLarge?.copyWith(
                                    color: isActive ? Colors.white : null),
                              ),
                              const SizedBox(height: Constants.SPACING),
                              Text(
                                DateFormat("EEE").format(e),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: isActive
                                      ? Colors.white
                                      : theme.colorScheme.onSurface
                                          .withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Constants.SPACING * 1.25)
                  ],
                );
              },
            ).toList(),
          ),
        )
      ],
    );
  }
}

List<DateTime> _findDatesBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> dates = [];
  DateTime currentDate = startDate;
  while (currentDate.isBefore(endDate.add(const Duration(days: 1)))) {
    dates.add(currentDate);
    currentDate = currentDate.add(const Duration(days: 1));
  }
  return dates;
}
