import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/models/token_pair.dart';
import 'package:nishauri/src/utils/constants.dart';

abstract class HTTPService {
  Future<Exception> getException(StreamedResponse response) async {
    switch (response.statusCode) {
      case 401:
        final responseString = await response.stream.bytesToString();
        final errorData = jsonDecode(responseString);
        return UnauthorizedException(errorData["detail"]);
      case 400:

        final responseString = await response.stream.bytesToString();
        final errorData = jsonDecode(responseString);
        return BadRequestException(errorData['errors']);
      case 500:
        return InternalServerErrorException("Unknown error occurred!");
      default:
        return NetworkException(
            "Network Error.Please make sure you have internet connection");
    }
  }

  Future<TokenPair> handleUnauthorizedError(String refreshToken) async {
    final url = Uri.parse("${Constants.BASE_URL}/auth/refresh-token");
    var headers = {'x-refresh-token': refreshToken};
    var request = Request('GET', url);
    request.headers.addAll(headers);
    StreamedResponse refreshResponse = await request.send();
    if (refreshResponse.statusCode == 200) {
      final authState = TokenPair(
        accessToken: refreshResponse.headers["x-access-token"]!,
        refreshToken: refreshResponse.headers["x-refresh-token"]!,
      );
      return authState;
      // final responseString = await response.stream.bytesToString();
      // final errorData = jsonDecode(responseString);
    }
    final responseString = await refreshResponse.stream.bytesToString();
    final errorData = jsonDecode(responseString);
    throw UnauthorizedException(errorData["detail"]);
  }

  Future<Exception> getExceptionFromString(String error) async {
    return ResourceNotFoundException(error);
  }

// Exception getException(http.StreamedResponse response) {
//   switch (response.statusCode) {
//     case 401:
//       return UnauthorizedException();
//     case 400:
//       return BadRequestException(response.body);
//     case 500:
//       return InternalServerErrorException();
//     default:
//       return NetworkException();
//   }
// }
}
