import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/hiv/data/models/art_sites/art_site.dart';
import 'package:nishauri/src/features/hiv/data/repositories/art_sites_repository.dart';
import 'package:nishauri/src/features/hiv/data/services/art_sites_service.dart';

final artSitesProvider = FutureProvider<List<ARTSite>>((ref) async {
  final service = ARTSitesService();
  final repo = ARTSitesRepository(service);
  return await repo.getSites();
});
