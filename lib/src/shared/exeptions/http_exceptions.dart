class ValidationException implements Exception {
  final Map<String, dynamic> errors;

  ValidationException(this.errors);
}

class ResourceNotFoundException implements Exception {
  final String message;

  ResourceNotFoundException(this.message);
}