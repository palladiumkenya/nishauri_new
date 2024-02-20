import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/orders/data/models/courier/courier.dart';
import 'package:nishauri/src/features/orders/data/repositories/courier_repository.dart';
import 'package:nishauri/src/features/orders/data/services/courier_service.dart';

final courierProvider = FutureProvider<List<Courier>>((ref) async {
  final repo = CourierRepository(CourierService());
  return await repo.getCourierServices();
});