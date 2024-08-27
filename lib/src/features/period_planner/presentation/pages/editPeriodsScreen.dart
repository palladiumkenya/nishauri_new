// import 'package:flutter/material.dart';
// import 'package:nishauri/src/features/period_planner/data/models/cycle.dart';
// import 'package:nishauri/src/features/period_planner/presentation/widgets/customCalendar.dart';
// import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
// import 'package:nishauri/src/utils/constants.dart';
// import 'package:table_calendar/table_calendar.dart';

// class EditPeriodsScreen extends StatefulWidget {

//   const EditPeriodsScreen({super.key});

//   @override
//   State<EditPeriodsScreen> createState() => _EditPeriodsScreenState();
// }

// class _EditPeriodsScreenState extends State<EditPeriodsScreen> {
//   // DateTime? _periodStart;
//   // DateTime? _periodEnd;
//   // Cycle? _cycle;
//   Map<DateTime, DateTime> _periodRanges = {};
  

//   @override
//   void initState() {
//     super.initState();
    
//     // Gather all period ranges from all cycles
//     for (Cycle cycle in cycles) {
//       _periodRanges[cycle.periodStart] = cycle.periodEnd;
//     }

//     // Here, selecting the last cycle added to the list
//     // if (cycles.isNotEmpty) {
//     //   _cycle = cycles.last;
//     //   _periodStart = _cycle?.periodStart;
//     //   _periodEnd = _cycle?.periodEnd;
//     // } 

//   }

//   void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
//     setState(() {
//       if (start != null && end != null) {
//         // Assuming you're editing the last cycle for simplicity
//         Cycle lastCycle = cycles.last;
//         lastCycle.periodStart = start;
//         lastCycle.periodEnd = end;

//         // Update the period ranges map
//         _periodRanges[start] = end;
//       }
//     });
//   }

//   void _applyChanges() {
//     // Save the updated cycle list and recalculate important dates
//     for (Cycle cycle in cycles) {
//       Cycle updatedCycle = predictCycle(cycle.periodStart, cycle.periodEnd);
//       cycle.fertileStart = updatedCycle.fertileStart;
//       cycle.fertileEnd = updatedCycle.fertileEnd;
//       cycle.ovulation = updatedCycle.ovulation;
//       cycle.predictedPeriodStart = updatedCycle.predictedPeriodStart;
//       cycle.predictedPeriodEnd = updatedCycle.predictedPeriodEnd;
//     }

//     Navigator.of(context).pop(); // Go back to the previous screen
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       body: Column(
//         children: [
//           CustomAppBar(
//             title: "Edit Periods 📅",
//             color: Constants.periodPlanner.withOpacity(1.0),
//           ),
//           TableCalendar(
//             focusedDay: DateTime.now(),
//             firstDay: DateTime(2020),
//             lastDay: DateTime.now(),
//             rangeStartDay: _periodRanges.isNotEmpty ? _periodRanges.keys.first : null,
//             rangeEndDay: _periodRanges.isNotEmpty ? _periodRanges.values.last : null,
//             onRangeSelected: _onRangeSelected,
//             calendarFormat: CalendarFormat.month,
//             headerStyle: const HeaderStyle(
//               formatButtonVisible: false,
//             ),
//             calendarStyle: const CalendarStyle(
//               todayDecoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//               rangeStartDecoration: BoxDecoration(
//                 color: Colors.pink,
//                 shape: BoxShape.circle,
//               ),
//               rangeEndDecoration: BoxDecoration(
//                 color: Colors.pink,
//                 shape: BoxShape.circle,
//               ),
//               rangeHighlightColor: Constants.periodPlanner,
//             ),
//           ),
//           Expanded(
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Constants.periodPlanner,
//                   ),
//                   onPressed: () {
//                   _applyChanges();
//                   }, 
//                   child: Text(
//                     'Apply Changes',
//                     style: theme.textTheme.titleSmall?.copyWith(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }