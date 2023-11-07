import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@Freezed()
class User with _$User {
  const factory User({
    required String id,
    required String username,
    String? firstName,
    String? lastName,
    String? gender,
    String? email,
    String? phoneNumber,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json)=> _$UserFromJson(json);
}