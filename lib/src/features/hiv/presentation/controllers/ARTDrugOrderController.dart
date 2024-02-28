import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/art_orders/art_drug_order.dart';

import '../../data/repositories/art_drug_order_service.dart';

class ARTDrugOrderController
    extends StateNotifier<AsyncValue<List<ARTDrugOrder>>> {
  final ARTDrugOrderRepository _repository;

  ARTDrugOrderController(this._repository) : super(const AsyncValue.loading()) {
    getOrders();
  }

  Future<void> getOrders() async {
    try {
      final orders = await _repository.getOrders();
      state = AsyncValue.data(orders);
    } catch (err) {
      state = const AsyncValue.data([]);
    }
  }

  Future<ARTDrugOrder> createOrder(Map<String, dynamic> data) async {
    try {
      final order = await _repository.createOrder(data);
      await getOrders();
      return order;
    } catch(err) {
      rethrow;
    }
  }
}
