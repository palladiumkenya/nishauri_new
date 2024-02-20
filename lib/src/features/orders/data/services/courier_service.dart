import 'package:nishauri/src/features/orders/data/models/courier/courier.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

class CourierService extends HTTPService {
  final _couriers = [
    const Courier(id: "1", name: "Boda boda"),
    const Courier(id: "2", name: "boat service"),
    const Courier(id: "2", name: "air service"),
    const Courier(id: "2", name: "Glovo"),
  ];

  Future<List<Courier>> getCourierServices () async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return _couriers;
  }
}
