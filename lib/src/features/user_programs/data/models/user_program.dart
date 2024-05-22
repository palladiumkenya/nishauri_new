import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/user_programs/data/models/program.dart';
part 'user_program.freezed.dart';
part 'user_program.g.dart';

@Freezed()
class UserProgram with _$UserProgram {
  const factory UserProgram({
    String? id,
    String? program_name,
    @Default(false) bool isActive,
    DateTime? createdAt,

  }) = _UserProgram;

  factory UserProgram.fromJson(Map<String, dynamic> json)=> _$UserProgramFromJson(json);
}
