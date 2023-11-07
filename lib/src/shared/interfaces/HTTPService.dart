import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';

abstract class HTTPService {
  Future<Exception> getException(StreamedResponse response) async {
    if (response.statusCode == 400) {
      // Validation Error: Parse and return error details
      final responseString = await response.stream.bytesToString();
      final errorData = jsonDecode(responseString);
      return ValidationException(errorData['errors']);
    } else {
      final responseString = await response.stream.bytesToString();
      final errorData = json.decode(responseString);
      return ResourceNotFoundException(errorData['detail']);
    }
  }
}
