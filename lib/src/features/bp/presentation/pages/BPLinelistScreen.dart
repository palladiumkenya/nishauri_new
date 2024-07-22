import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/bp/data/providers/blood_pressure_provider.dart';

class BPLinelistScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloodPressureListAsyncValue = ref.watch(bloodPressureListProvider);

    return bloodPressureListAsyncValue.when(
      data: (bloodPressureList) {
        return ListView.builder(
          itemCount: bloodPressureList.length + 1, // +1 for the header row
          itemBuilder: (context, index) {
            if (index == 0) {
              // Header row
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Systolic', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Diastolic', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Pulse Rate', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            } else {
              // Data rows
              final bp = bloodPressureList[index - 1]; // Adjust index for data
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(bp.systolic.toString(), style: TextStyle(color: Colors.red)),
                      Text(bp.diastolic.toString(), style: TextStyle(color: Colors.orange)),
                      Text(bp.pulse_rate.toString(), style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('Time: ${DateFormat('HH:mm - dd-MM-yy').format(DateTime.parse(bp.bpTime.toString()))}'),
                      subtitle: bp.notes != null && bp.notes!.isNotEmpty
                          ? Text('Notes: ${bp.notes}')
                          : null,
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
