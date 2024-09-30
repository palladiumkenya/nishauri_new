import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
import 'package:nishauri/src/features/period_planner/data/models/events.dart';
import 'package:nishauri/src/features/period_planner/data/providers/cycles_provider.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/calendarKey.dart';
import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
import 'package:nishauri/src/features/period_planner/utils/event_utils.dart';
import 'package:nishauri/src/utils/constants.dart';

class ModalContent extends ConsumerStatefulWidget {
  const ModalContent({super.key});

  @override
  ConsumerState<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends ConsumerState<ModalContent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cycleAsyncValue = ref.watch(cyclesProvider);
    return SizedBox(
      //height: MediaQuery.of(context).size.height,
      height: 600,
      child: cycleAsyncValue.when(
        data: (cycles) {
          Map<int, Map<DateTime, List<Event>>> events =  EventUtils.generateEvents(cycles);      
        return SingleChildScrollView(
          child: Column(
            children: [
              CustomCalendar(
                events: events,
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Key:",
                      style: TextStyle(
                        color: Constants.periodPlanner,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CalendarKey(color: Colors.red, label: 'Today'),
                  CalendarKey(color: Colors.pink, label: 'Period Days'),
                  CalendarKey(color: Colors.green, label: 'Fertile Days'),        
                  CalendarKey(color: Colors.blue, label: 'Ovulation Day'),
                  CalendarKey(color: Colors.orange, label: 'Predicted Next Period Days'),
                ],
              ),
            ],
          ),
        );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text(
            'Failed to load cycles: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}