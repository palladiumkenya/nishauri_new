import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'address.freezed.dart';
part 'address.g.dart';

@Freezed()
class Address with _$Address {
  const factory Address({
    String? id,
    String? latitude,
    String? longitude,
    String? address,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json)=> _$AddressFromJson(json);
}
