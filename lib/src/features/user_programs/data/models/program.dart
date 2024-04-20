import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'program.freezed.dart';
part 'program.g.dart';

@Freezed()
class Program with _$Program {
  const factory Program({
    String? id,
    String? program_code,
    String? name,
    String? description,
    @Default(false) bool is_active,
    required String createdAt,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json)=> _$ProgramFromJson(json);
}
