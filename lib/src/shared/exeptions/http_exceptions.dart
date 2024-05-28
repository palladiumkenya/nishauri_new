class BadRequestException implements Exception {
  final Map<String, dynamic> errors;

  BadRequestException(this.errors);

}

class ResourceNotFoundException implements Exception {
  final String message;

  ResourceNotFoundException(this.message);

  @override
  String toString() {
    return message;
  }
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
  @override
  String toString() {
    return message;
  }
}

class ForbiddenException implements Exception {
  final String message;

  ForbiddenException(this.message);

  @override
  String toString() {
    return message;
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
  @override
  String toString() {
    return message;
  }
}

class InternalServerErrorException implements Exception {
  final String message;

  InternalServerErrorException(this.message);

  @override
  String toString() {
    return message;
  }
}
