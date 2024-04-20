import 'package:nishauri/src/features/hiv/data/services/art_drug_order_service.dart';

import '../models/art_orders/art_drug_order.dart';

class ARTDrugOrderRepository {
  final ARTDrugOrderService _service;

  ARTDrugOrderRepository(this._service);


  Future<List<ARTDrugOrder>> getOrders() async {
    return await _service.getOrders();
  }
  // Future<ARTDrugOrder> createOrder(Map<String, dynamic> data) async {
  //   return await _service.createOrder(data);
  // }

  Future<String> createOrder(Map<String, dynamic> data) async {
    return await _service.createOrder(data);
  }
}
