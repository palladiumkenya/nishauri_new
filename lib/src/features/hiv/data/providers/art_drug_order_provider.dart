import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/hiv/data/models/art_orders/art_drug_order.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_drug_order_service.dart';
import 'package:nishauri/src/features/hiv/data/services/art_drug_order_service.dart';
import 'package:nishauri/src/features/hiv/presentation/controllers/ARTDrugOrderController.dart';

final artDrugOrderProvider = StateNotifierProvider<ARTDrugOrderController,
    AsyncValue<List<ARTDrugOrder>>>((ref) {
  final repo = ARTDrugOrderRepository(ARTDrugOrderService());
  return ARTDrugOrderController(repo);
});
