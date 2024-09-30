import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/providers/cycles_provider.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

// Map containing period cycles in which the user has confirmed period end date
Map<int, bool> periodConfirmedMap = {};

class PeriodsHistory extends ConsumerStatefulWidget {
  const PeriodsHistory({super.key});

  @override
  ConsumerState<PeriodsHistory> createState() => _PeriodsHistoryState();
}

class _PeriodsHistoryState extends ConsumerState<PeriodsHistory> {
  // Function to format the date as "MMM d"
  String formatDate(DateTime date) {
    return DateFormat('MMM d').format(date);
  }

  // Function to group cycles by year
  Map<int, List<MapEntry<int, Cycle>>> groupCyclesByYear(
      Map<int, Cycle> cycles) {
    final Map<int, List<MapEntry<int, Cycle>>> groupedCycles = {};

    for (var cycleEntry in cycles.entries) {
      final year = cycleEntry.value.period_start.year;
      if (!groupedCycles.containsKey(year)) {
        groupedCycles[year] = [];
      }
      groupedCycles[year]!.add(cycleEntry);
    }
    return groupedCycles;
  }

  @override
  Widget build(BuildContext context) {
    final cyclesAsyncValue = ref.watch(cyclesProvider);

    return cyclesAsyncValue.when(
      data: (cycles) {
        final averagePeriod = calculateAveragePeriodLength(cycles);
        final averageCycles = calculateAverageCycleLength(cycles);
        // Group cycles by year and reverse the list to show the latest first
        final groupedCycles = groupCyclesByYear(cycles);
        final sortedYears = groupedCycles.keys.toList()
          ..sort((a, b) => b.compareTo(a));

        return Scaffold(
          body: ListView(
            children: [
              const CustomAppBar(
                title: "My Period History 🌼",
                color: Constants.periodPlanner,
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // The first Card showing both Average period and cycle lengths
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "My Cycles",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    // Card showing Average Period days
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Average Period",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              "$averagePeriod days",
                                              style: const TextStyle(
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.pink,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    // Card Showing Average Cycle days
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Average Cycle',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              "$averageCycles days",
                                              style: const TextStyle(
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Card Showing period history
                      const Text(
                        "History",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sortedYears.length,
                        itemBuilder: (context, index) {
                          final year = sortedYears[index];
                          final cyclesInYear = groupedCycles[year]!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "$year",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ...cyclesInYear.reversed.map((cycleEntry) {
                                final cycleId = cycleEntry.key;
                                final cycle = cycleEntry.value;

                                // Only display cycles that are either confirmed or whose end date has passed
                                final hasPeriodEnded =
                                    DateTime.now().isAfter(cycle.period_end);
                                final isPeriodConfirmed =
                                    periodConfirmedMap[cycleId] ?? false;

                                if (isPeriodConfirmed || hasPeriodEnded) {
                                  final start = formatDate(cycle.period_start);
                                  final end = formatDate(cycle.period_end);
                                  final cycleDays = cycle.cycle_length;

                                  // Check if the current cycle is the last entry
                                  bool isLastCycle =
                                      cycle == cyclesInYear.last.value;

                                  return Card(
                                    elevation: 4.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: ListTile(
                                      leading: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Confirm Delete"),
                                                content: const Text(
                                                    "Are you sure you want to delete the current Cycle?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      try {
                                                        ref
                                                            .read(cyclesProvider
                                                                .notifier)
                                                            .deleteCycle(
                                                                cycleId)
                                                            .then((_) {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      } catch (e) {
                                                        debugPrint(
                                                            'Error deleting cycle: $e');
                                                      }
                                                    },
                                                    child: const Text("Yes"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("No"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.delete_outline),
                                      ),
                                      title: Text(
                                        "$start - $end",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        isLastCycle
                                            ? "Estimated Cycle Length: $cycleDays days"
                                            : "Length of cycle: $cycleDays days",
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          context.goNamed(
                                            RouteNames
                                                .PERIOD_PLANNER_EDIT_PERIODS,
                                            extra: {
                                              'startDate': cycle.period_start,
                                              'endDate': cycle.period_end,
                                              'id': cycleId,
                                            },
                                          );
                                        },
                                        icon:
                                            const Icon(Icons.arrow_forward_ios),
                                      ),
                                    ),
                                  );
                                } else {
                                  // Skip displaying cycles that haven't been confirmed or whose end date hasn't passed
                                  return const SizedBox.shrink();
                                }
                              }).toList(),
                            ],
                          );
                        },
                      ),
                    ],
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
