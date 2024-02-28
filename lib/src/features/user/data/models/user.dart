import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@Freezed()
class User with _$User {
  const factory User({
    required String? id,
    String? image,
    required String username,
    String? firstName,
    String? lastName,
    String? name,
    String? dateOfBirth,
    String? gender,
    required String email,
    required String phoneNumber,
    String? county,
    String? constituency,
    String? bloodGroup,
    @Default([]) List<String> allergies,
    @Default([]) List<String> disabilities,
    @Default([]) List<String> chronics,
    String? weight,
    String? height,
    String? maritalStatus,
    String? educationLevel,
    String? primaryLanguage,
    String? occupation,
    @Default(false) bool profileUpdated,
    @Default(false) bool accountVerified,

  }) = _User;

  factory User.fromJson(Map<String, dynamic> json)=> _$UserFromJson(json);
}