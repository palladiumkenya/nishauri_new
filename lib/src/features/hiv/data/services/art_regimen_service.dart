import 'package:nishauri/src/features/hiv/data/models/regimen/art_regimen.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';

class ARTRegimenService extends HTTPService {
  final String _token;

  ARTRegimenService(this._token);

  final _regimen_history = [
    const ARTRegimen(
        name: "ABC+3TC+EFV",
        isCurrent: true,
        createdAt: "13th May 2023",
        id: "r-1",
        description: "From diagnoses of low viral loads"),
    const ARTRegimen(
        name: "WED+3TC+GBH",
        createdAt: "13th May 2023",
        id: "r-1",
        description: "From diagnoses of low viral loads"),
    const ARTRegimen(
        name: "GBH+HJK+EFV",
        createdAt: "13th May 2023",
        id: "r-1",
        description: "From diagnoses of low viral loads"),
    const ARTRegimen(
        name: "ABC+3GTTC+KJH",
        createdAt: "13th May 2023",
        id: "r-1",
        description: "From diagnoses of low viral loads"),
    const ARTRegimen(
        name: "BGH+3TC+KLI",
        createdAt: "13th May 2023",
        id: "r-1",
        description: "From diagnoses of low viral loads"),
    const ARTRegimen(
        name: "BHN+LKO+EFV",
        createdAt: "13th May 2023",
        id: "r-1",
        description: "From diagnoses of low viral loads"),
  ];

  Future<List<ARTRegimen>> getARTRegimenHistory() async {
    return _regimen_history;
  }
}
