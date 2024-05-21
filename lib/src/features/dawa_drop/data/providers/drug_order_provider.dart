import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/dawa_drop/data/models/order_request/drug_order.dart';
import 'package:nishauri/src/features/dawa_drop/data/repositories/drug_order_repository.dart';
import 'package:nishauri/src/features/dawa_drop/data/services/drug_order_service.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/controllers/drug_order_controller.dart';
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';

final drugOrderProvider =
    StateNotifierProvider<DrugOrderController, AsyncValue<List<DrugOrder>>>(
        (ref) {
  ref.watch(userProvider);
  final repo = DrugOrderRepository(DrugOrderService());
  return DrugOrderController(repo);
});
