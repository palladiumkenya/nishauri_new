import 'package:nishauri/src/features/confirm_delivery/data/services/confirm_delivery_service.dart';

class ConfirmDeliveryRepository {
  final ConfirmDeliveryService _service;

  ConfirmDeliveryRepository(this._service);

  Future<String> confirmDelivery(Map<String, dynamic> data) async {
    return await _service.confirmDelivery(data);
  }
}