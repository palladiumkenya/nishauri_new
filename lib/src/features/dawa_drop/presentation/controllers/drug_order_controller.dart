import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/dawa_drop/data/models/order_request/drug_order.dart';
import 'package:nishauri/src/features/dawa_drop/data/repositories/drug_order_repository.dart';

class DrugOrderController
    extends StateNotifier<AsyncValue<List<DrugOrder>>> {
  final DrugOrderRepository _repository;

  DrugOrderController(this._repository) : super(const AsyncValue.loading()) {
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

  Future<String> createOrder(Map<String, dynamic> data) async {
    try {
      final order = await _repository.createOrder(data);
      await getOrders();
      return order;
    } catch(err) {
      rethrow;
    }
  }
}
