import 'package:nishauri/src/features/hiv/data/models/art_sites/art_site.dart';
import 'package:nishauri/src/features/hiv/data/services/art_sites_service.dart';

class ARTSitesRepository {
  final ARTSitesService _service;

  ARTSitesRepository(this._service);

  Future<List<ARTSite>> getSites() async {
    return await _service.getSites();
  }

  Future<ARTSite> getSiteById(String id) async {
    return await _service.getArtSiteById(id);
  }
}
