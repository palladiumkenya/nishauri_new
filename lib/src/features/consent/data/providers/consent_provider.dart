import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/consent/data/repository/consent_repository.dart';
import 'package:nishauri/src/features/consent/data/services/consent_service.dart';

final consentProvider = Provider((ref) async {
  final _service = ConsentService();
  final repository = ConsentRepository(_service);
  return repository;
});
