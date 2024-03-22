import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'courier.freezed.dart';
part 'courier.g.dart';

@Freezed()
class Courier with _$Courier {
  const factory Courier({
    int? id,
    required String name,
    String? description,
  }) = _Courier;

  factory Courier.fromJson(Map<String, dynamic> json)=> _$CourierFromJson(json);
}
