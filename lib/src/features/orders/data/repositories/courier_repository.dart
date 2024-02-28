import 'package:nishauri/src/features/orders/data/services/courier_service.dart';

import '../models/courier/courier.dart';

class CourierRepository {
  final CourierService _service;
  const CourierRepository(this._service);

  Future<List<Courier>> getCourierServices () async {
    return await _service.getCourierServices();
  }
}