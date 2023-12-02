import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'address.freezed.dart';
part 'address.g.dart';

@Freezed()
class Address with _$Address {
  const factory Address({
    String? id,
    required String latitude,
    required String longitude,
    String? address,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json)=> _$AddressFromJson(json);
}