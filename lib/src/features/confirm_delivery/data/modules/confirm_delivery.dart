import 'package:freezed_annotation/freezed_annotation.dart';

part 'confirm_delivery.freezed.dart';
part 'confirm_delivery.g.dart';

@Freezed()
class ConfirmDelivery with _$ConfirmDelivery {
  const factory ConfirmDelivery({
    String? id,
    int? order_id,
    required String confirmation_code,
    required int is_received,
    String? comment,
  }) = _ConfirmDelivery;

  factory ConfirmDelivery.fromJson(Map<String, dynamic> json)=> _$ConfirmDeliveryFromJson(json);
}
