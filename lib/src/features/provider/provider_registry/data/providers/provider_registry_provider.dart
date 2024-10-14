
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/provider/provider_registry/data/models/provider_registry.dart';
import 'package:nishauri/src/features/provider/provider_registry/data/repositories/provider_registry_repository.dart';
import 'package:nishauri/src/features/provider/provider_registry/data/services/provider_registry_service.dart';

final providerRegistryRepositoryProvider = Provider<ProviderRegistryRepository>((ref) {
  return ProviderRegistryRepository(ProviderRegistryService());
});

final getProviderDetailsProvider = FutureProvider<ProviderRegistry>((ref) async {
  final repository = ref.watch(providerRegistryRepositoryProvider);
  return await repository.getProviderDetails();
});