import 'package:nishauri/src/features/consent/data/models/consent.dart';
import 'package:nishauri/src/features/consent/data/services/consent_service.dart';

class ConsentRepository {
  final ConsentService _service;

  ConsentRepository(
      this._service
      );

  Future<String> consent() async {
    return await _service.consent();
  }

  Future<String> revokeConsent() async {
    return await _service.revokeConsent();
  }

  Future<List<Consent>> getConsent() async {
    return await _service.getConsent();
  }

  void when({required Null Function(dynamic consent) data, required Null Function() loading, required Null Function(dynamic error, dynamic stackTrace) error}) {}
}
