import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/confirm_delivery/data/modules/confirm_delivery.dart';
import 'package:nishauri/src/features/confirm_delivery/data/repository/confirm_delivery_repository.dart';
import 'package:nishauri/src/features/confirm_delivery/data/services/confirm_delivery_service.dart';
import 'package:nishauri/src/features/confirm_delivery/presentation/controller/ConfirmDeliveryController.dart';

final confirmDeliveryProvider = StateNotifierProvider<ConfirmDeliveryController,
    AsyncValue<List<ConfirmDelivery>>>((ref) {
  final repo = ConfirmDeliveryRepository(ConfirmDeliveryService());
  return ConfirmDeliveryController(repo);
});