import 'dart:core';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'provider_registry.freezed.dart';
part 'provider_registry.g.dart';

@Freezed()
class ProviderRegistry with _$ProviderRegistry {
  const factory ProviderRegistry({
     int? id,
     String? family_name,
     String? given_name,
     int? national_id,
     String? licence_number,
     String? board_number,
     String? cadre,
     String? gender,
    String? facility_code,
    int? user_id,
    String? salutation,

  }) = _ProviderRegistry;
  factory ProviderRegistry.fromJson(Map<String, dynamic> json)=> _$ProviderRegistryFromJson(json);
}