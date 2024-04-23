import 'package:nishauri/src/features/dawa_drop/data/models/order_request/drug_order.dart';
import 'package:nishauri/src/features/dawa_drop/data/services/drug_order_service.dart';

class DrugOrderRepository {
  final DrugOrderService _service;

  DrugOrderRepository(this._service);


  Future<List<DrugOrder>> getOrders() async {
    return await _service.getOrders();
  }

  Future<String> createOrder(Map<String, dynamic> data) async {
    return await _service.createOrder(data);
  }
}
