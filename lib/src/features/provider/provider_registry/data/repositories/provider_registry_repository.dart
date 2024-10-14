
import 'package:nishauri/src/features/provider/provider_registry/data/models/provider_registry.dart';
import 'package:nishauri/src/features/provider/provider_registry/data/services/provider_registry_service.dart';

class ProviderRegistryRepository {
  final ProviderRegistryService _service;

  ProviderRegistryRepository(this._service);

  Future<ProviderRegistry> searchProviderRegistry (Map<String, dynamic> data) async {
    return await _service.searchProviderRegistry(data);
  }

  Future<ProviderRegistry> getProviderDetails() async {
    return await _service.getProviderDetails();
  }
}
