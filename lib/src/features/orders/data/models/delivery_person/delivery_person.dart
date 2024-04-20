import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'delivery_person.freezed.dart';
part 'delivery_person.g.dart';

@Freezed()
class DeliveryPerson with _$DeliveryPerson {
  const factory DeliveryPerson({
     String? fullName,
     String? nationalId,
     String? phoneNumber,
     String? pickupTime,
  }) = _DeliveryPerson;

  factory DeliveryPerson.fromJson(Map<String, dynamic> json)=> _$DeliveryPersonFromJson(json);
}
