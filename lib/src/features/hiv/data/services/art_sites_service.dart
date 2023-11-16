import 'package:nishauri/src/features/hiv/data/models/address.dart';
import 'package:nishauri/src/features/hiv/data/models/art_site.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

class ARTSitesService extends HTTPService {
  String token;
  final List<ARTSite> _sites = [
    const ARTSite(
      mflCode: "MFL-001",
      name: "Ombo hospital",
      telephone: "+254798767565",
      id: "001",
      type: "Dispensary",
      address: Address(
        latitude: "-1.0986984",
        longitude: "36.9666969",
        address: "Suna migori",
      ),
    ),const ARTSite(
      mflCode: "MFL-002",
      name: "District hospital",
      telephone: "+254798767565",
      id: "002",
      type: "Clinic",
      address: Address(
        latitude: "-1.8986984",
        longitude: "36.8666969",
        address: "Suna migori",
      ),
    ),const ARTSite(
      mflCode: "MFL-003",
      name: "Kasomo hospital",
      telephone: "+254798767565",
      id: "003",
      type: "Level 5",
      address: Address(
        latitude: "-1.5986984",
        longitude: "36.0666969",
        address: "Suna migori",
      ),
    ),const ARTSite(
      mflCode: "MFL-004",
      name: "Kasomo hospital",
      telephone: "+254798767565",
      id: "004",
      type: "Level 4",
      address: Address(
        latitude: "-1.9986984",
        longitude: "36.0666969",
        address: "Suna Rongo",
      ),
    ),
  ];

  final List<ARTSite> _sites1 = List.generate(
    100,
    (index) => ARTSite(
        mflCode: "MFL-$index",
        name: "Art site $index",
        telephone: "+254798767565",
        id: index.toString(),
        type: "Facility type $index",
        address: Address(
          latitude: "-1.${index}986984",
          longitude: "36.9${index}66969",
          address: "Address for site $index",
        )),
  ).toList();

  ARTSitesService(this.token);

  Future<List<ARTSite>> getSites() async {
    return _sites;
  }

  Future<ARTSite> getArtSiteById(String id) async {
    return _sites.firstWhere((element) => element.id == id);
  }

  Future<List<ARTSite>> searchSite(String search) async {
    return _sites
        .where((element) =>
            element.id == search ||
            element.type == search ||
            element.name == search ||
            element.mflCode == search)
        .toList();
  }
}
