import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/bmi/data/model/bmi_log.dart';
import 'package:nishauri/src/utils/constants.dart';

class BMILinelist extends StatelessWidget {
  final List<BMILog> data;
  const BMILinelist({required this.data, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
        return ListView.builder(
          itemCount: data.length + 1, // +1 for the header row
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
                      Text('Height', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Weight', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('BMI', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            } else {
              // Data rows
              final bmi = data[index - 1]; // Adjust index for data
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(bmi.height.toString(), style: TextStyle(color: Constants.bmiCalculatorColor)),
                      Text(bmi.weight.toString(), style: TextStyle(color: Colors.orange)),
                      Text(bmi.results.toString(), style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('Time: ${DateFormat('HH:mm - dd-MM-yy').format(DateTime.parse(bmi.created_at.toString()))}'),
                      // subtitle: bp.notes != null && bp.notes!.isNotEmpty
                      //     ? Text('Notes: ${bp.notes}')
                      //     : null,
                    ),
                  ],
                ),
              );
            }
          },
        );
  }
}
