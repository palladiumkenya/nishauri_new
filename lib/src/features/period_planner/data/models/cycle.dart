// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'cycle.freezed.dart';
// part 'cycle.g.dart';

// @Freezed()
// class Cycle with _$Cycle {
//   const factory Cycle({
//     required String cycleId, 
//     required DateTime periodStart,
//     required DateTime periodEnd,
//     required DateTime fertileStart,
//     required DateTime fertileEnd,
//     required DateTime ovulation,
//     required DateTime predictedPeriodStart,
//     required DateTime predictedPeriodEnd,
//     required int cycleLength,
//     required int periodLength,
//   }) = _Cycle;

//   factory Cycle.fromJson(Map<String, dynamic> json)
//     => _$CycleFromJson(json);
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

