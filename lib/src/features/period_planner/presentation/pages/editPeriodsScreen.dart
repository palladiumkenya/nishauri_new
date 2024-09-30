import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/providers/cycles_provider.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/logPeriods.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';
import 'package:table_calendar/table_calendar.dart';

class EditPeriods extends ConsumerStatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final int? cycleId;
  const EditPeriods(
      {super.key, this.initialStartDate, this.initialEndDate, this.cycleId});

  @override
  ConsumerState<EditPeriods> createState() => _EditPeriodsState();
}

class _EditPeriodsState extends ConsumerState<EditPeriods> {
  late DateTime _focusedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final today = DateTime.now();

  @override
  void initState() {
    super.initState();

    _focusedDay = widget.initialStartDate ?? DateTime.now();
    _rangeStart = widget.initialStartDate;
    _rangeEnd = widget.initialEndDate;
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime? focusedDay) {
    setState(() {
      _rangeStart = start;
      _rangeEnd = end;
      _focusedDay = focusedDay ?? _focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cycleAsyncValue = ref.watch(cyclesProvider);

    return cycleAsyncValue.when(
      data: (cycles) {
        return Scaffold(
          body: Column(
            children: [
              const CustomAppBar(
                title: "Edit Period 🌸",
                color: Constants.periodPlanner,
              ),
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(2021),
                lastDay: DateTime(2100),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                rangeSelectionMode: RangeSelectionMode.toggledOn,
                onRangeSelected: _onRangeSelected,
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  rangeStartDecoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  rangeEndDecoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  rangeHighlightColor: Constants.periodPlanner,
                  selectedDecoration: BoxDecoration(
                    color: Constants.periodPlanner,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.periodPlanner,
                      ),
                      onPressed: () {
                        if (_rangeStart == null || _rangeEnd == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please select your Period start and end dates.')),
                          );
                        } else if (_rangeStart!.isAfter(today) ||
                            _rangeEnd!.isAfter(today)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'You cannot select dates in the future. Please select valid dates.')),
                          );
                        } else {
                          final currentCycleId = widget.cycleId;
                          final currentCycle = cycles[widget.cycleId];

                          if (currentCycle != null && currentCycleId != null) {
                            final updatedCycle = predictCycle(
                                _rangeStart!, _rangeEnd!,
                                cycleId: currentCycleId, cycle: cycles);

                            ref
                                .read(cyclesProvider.notifier)
                                .editCycle(currentCycleId, updatedCycle);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Periods updated successfully!')),
                            );
                            Navigator.pop(context, true);
                          } else {
                            debugPrint('Cycle with id ${widget.cycleId} not found!');
                          }
                        }
                      },
                      child: Text(
                        'Apply',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(
          'Failed to load cycles: $error',
          style: const TextStyle(color: Colors.red),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
