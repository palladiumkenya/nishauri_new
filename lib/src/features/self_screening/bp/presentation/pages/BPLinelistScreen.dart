import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/self_screening/bp/data/models/blood_pressure.dart';
import 'package:nishauri/src/utils/constants.dart';

class BPLinelistScreen extends StatelessWidget {
  final List<BloodPressure> data;
  const BPLinelistScreen({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

        return ListView.builder(
          itemCount: data.length + 1,
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
              final bp = data[index - 1];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(bp.systolic.toString(), style: TextStyle(color: Colors.red)),
                      Text(bp.diastolic.toString(), style: TextStyle(color: Colors.orange)),
                      Text(bp.pulse_rate.toString(), style: TextStyle(color: Constants.programsColor)),
                    ],
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('Time: ${DateFormat('HH:mm - dd-MM-yy').format(DateTime.parse(bp.created_at.toString()))}'),
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
  }
}
