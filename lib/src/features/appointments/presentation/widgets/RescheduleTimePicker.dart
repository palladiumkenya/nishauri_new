import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class RescheduleTimePicker extends StatelessWidget {
  final DateTime? selectedTime;
  final Color? activeColor;
  final void Function(DateTime time)? onSelectedTimeChange;

  const RescheduleTimePicker({
    super.key,
    this.selectedTime,
    this.onSelectedTimeChange, this.activeColor,

  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final allowedTime = getTimesBetween(
      DateTime(now.year, now.month, now.day, 8, 0),
      DateTime(now.year, now.month, now.day, 17, 0),
      const Duration(hours: 1),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Time", style: theme.textTheme.titleMedium),
        const SizedBox(height: Constants.SPACING),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: allowedTime.map(
              (e) {
                final difference =
                    selectedTime != null ? selectedTime!.hour - e.hour : null;
                final isActive = difference != null && difference == 0;
                return Container(
                  margin: EdgeInsets.only(right: Constants.SPACING),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Constants.ROUNDNESS * 8),
                    ),
                    elevation: 0,
                    color: isActive
                        ? activeColor ?? theme.colorScheme.primary
                        : theme.colorScheme.primary.withOpacity(0.1),
                    child: InkWell(
                      onTap: () {
                        if(onSelectedTimeChange!=null) onSelectedTimeChange!(e);
                      },
                      splashColor: activeColor ?? theme.colorScheme.primary,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: Constants.SPACING,
                            horizontal: Constants.SPACING * 2),
                        child: Center(
                          child: Text(
                            DateFormat.jm().format(e),
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: isActive ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
