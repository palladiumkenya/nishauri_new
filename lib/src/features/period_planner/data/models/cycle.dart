// import 'package:freezed_annotation/freezed_annotation.dart';

// @Freezed()
// class Cycle with _$Cycle {
//   const factory Cycle({
//     final String cycleId, 
//     final DateTime periodStart,
//     final DateTime periodEnd,
//     final DateTime fertileStart,
//     final DateTime fertileEnd,
//     final DateTime ovulation,
//     final DateTime predictedPeriodStart,
//     final DateTime predictedPeriodEnd,
//   }) = _Cycle;

//   factory Cycle.fromJson(Map<String, dynamic> json)=> _$CycleFromJson(json);
// }

class Cycle{
  final String cycleId;
  final DateTime periodStart;
  final DateTime periodEnd;
  final DateTime fertileStart;
  final DateTime fertileEnd;
  final DateTime ovulation;
  final DateTime predictedPeriodStart;
  final DateTime predictedPeriodEnd;

  Cycle({
    required this.cycleId,
    required this.periodStart,
    required this.periodEnd,
    required this.fertileStart,
    required this.fertileEnd,
    required this.ovulation,
    required this.predictedPeriodStart,
    required this.predictedPeriodEnd,
  });
}

//Acting as database for now
List <Cycle> cycles = [];