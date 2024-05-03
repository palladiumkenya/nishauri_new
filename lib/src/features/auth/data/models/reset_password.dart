import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'reset_password.freezed.dart';
part 'reset_password.g.dart';

@Freezed()
class PasswordReset with _$PasswordReset {
  const factory PasswordReset({
    String? id,
    String? current_password,
    String? new_password,
    String? confirm_password,
    String? user_name,
    String? otp
}) = _PasswordReset;
  factory PasswordReset.fromJson(Map<String, dynamic> json)=> _$PasswordResetFromJson(json);
}