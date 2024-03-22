import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nishauri/src/features/hiv/data/models/address/address.dart';
import 'package:nishauri/src/features/hiv/data/models/appointment/art_appointment.dart';
import 'package:nishauri/src/features/hiv/data/models/event/art_event.dart';
import 'package:nishauri/src/features/orders/data/models/courier/courier.dart';
import 'package:nishauri/src/features/orders/data/models/delivery_person/delivery_person.dart';


part 'art_drug_order.freezed.dart';
part 'art_drug_order.g.dart';

@Freezed()
class ARTDrugOrder with _$ARTDrugOrder {
  const factory ARTDrugOrder({
    String? id,
    ARTEvent? event,
    ARTAppointment? appointment,
    required Address deliveryAddress,
    required String deliveryMethod,
    required String phoneNumber,
    String? type,
    Courier? courierService,
    DeliveryPerson? deliveryPerson,
    String? createdAt,
    String? updateAt,
  }) = _ARTDrugOrder;

  factory ARTDrugOrder.fromJson(Map<String, dynamic> json)=> _$ARTDrugOrderFromJson(json);
}
