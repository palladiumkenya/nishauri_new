import 'package:freezed_annotation/freezed_annotation.dart';

part 'cycle.freezed.dart';
part 'cycle.g.dart';

@Freezed()
class Cycle with _$Cycle {
  const factory Cycle({
    required DateTime period_start,
    required DateTime period_end,
    required DateTime fertile_start,
    required DateTime fertile_end,
    required DateTime ovulation,
    required DateTime predicted_period_start,
    required DateTime predicted_period_end,
    required int cycle_length,
    required int period_length,
  }) = _Cycle;

  factory Cycle.fromJson(Map<String, dynamic> json) => _$CycleFromJson(json);
}

//Helper methods for JsSON serialization of DateTime
// String _dateTimeToJson(DateTime date) => date.toIso8601String();

// DateTime _dateTimeFromJson(String date) => DateTime.parse(date);

// class Cycle{
//   String cycleId;
//   DateTime periodStart;
//   DateTime periodEnd;
//   DateTime fertileStart;
//   DateTime fertileEnd;
//   DateTime ovulation;
//   DateTime predictedPeriodStart;
//   DateTime predictedPeriodEnd;
//   int cycleLength;
//   int periodLength;

//   Cycle({
//     required this.cycleId,
//     required this.periodStart,
//     required this.periodEnd,
//     required this.fertileStart,
//     required this.fertileEnd,
//     required this.ovulation,
//     required this.predictedPeriodStart,
//     required this.predictedPeriodEnd,
//     required this.cycleLength,
//     required this.periodLength,
//   });
// }

//Acting as database for now
// List <Cycle> cycles = [];

