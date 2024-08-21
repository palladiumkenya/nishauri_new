// import 'package:freezed_annotation/freezed_annotation.dart';

// @Freezed()
// class Cycle with _$Cycle {
//   const factory Cycle({
//       String cycleId, 
//       DateTime periodStart,
//       DateTime periodEnd,
//       DateTime fertileStart,
//       DateTime fertileEnd,
//       DateTime ovulation,
//       DateTime predictedPeriodStart,
//       DateTime predictedPeriodEnd,
//   }) = _Cycle;

//   factory Cycle.fromJson(Map<String, dynamic> json)=> _$CycleFromJson(json);
// }


class Cycle{
  String cycleId;
  DateTime periodStart;
  DateTime periodEnd;
  DateTime fertileStart;
  DateTime fertileEnd;
  DateTime ovulation;
  DateTime predictedPeriodStart;
  DateTime predictedPeriodEnd;
  int cycleLength;
  int periodLength;

  Cycle({
    required this.cycleId,
    required this.periodStart,
    required this.periodEnd,
    required this.fertileStart,
    required this.fertileEnd,
    required this.ovulation,
    required this.predictedPeriodStart,
    required this.predictedPeriodEnd,
    required this.cycleLength,
    required this.periodLength,
  });
}

//Acting as database for now
List <Cycle> cycles = [];

