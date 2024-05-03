import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nishauri/src/features/appointments/data/models/appointment.dart';
import 'package:nishauri/src/features/hiv/data/models/address/address.dart';
import 'package:nishauri/src/features/orders/data/models/courier/courier.dart';
import 'package:nishauri/src/features/orders/data/models/delivery_person/delivery_person.dart';

part 'drug_order.freezed.dart';
part 'drug_order.g.dart';

@Freezed()
class DrugOrder with _$DrugOrder {
  const factory DrugOrder({
    int? order_id,
    Appointment? appointment,
    Address? deliveryAddress,
    String? delivery_method,
    String? client_phone_no,
    String? order_type,
    Courier? courierService,
    DeliveryPerson? deliveryPerson,
    String? createdAt,
    String? updateAt,
    String? status,
    String? approved_date,
    String? dispatched_date,
    String? fullfilled_date,
    String? date_order_posted,
  }) = _DrugOrder;

  factory DrugOrder.fromJson(Map<String, dynamic> json)=> _$DrugOrderFromJson(json);
}