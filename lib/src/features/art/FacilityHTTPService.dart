import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/src/streamed_response.dart';

import 'package:nishauri/src/shared/models/token_pair.dart';

import '../../local_storage/LocalStorage.dart';
import '../../shared/exeptions/http_exceptions.dart';
import '../../shared/interfaces/HTTPService.dart';
import '../../utils/constants.dart';

class FacilityHTTPService implements HTTPService {
  @override
  String getQueryParams(Map<String, dynamic> query) {
    var q=query.entries.map((e) => "${e.key}=${e.value}");
    return q.isNotEmpty ? "?${q.join("&")}": "";
  }

  @override
  Future<Exception> getException(StreamedResponse response) async {
    switch (response.statusCode) {
    case 400:
    final responseString = await response.stream.bytesToString();
    final errorData = jsonDecode(responseString);
    return BadRequestException(errorData['errors']);
    case 401:
    final responseString = await response.stream.bytesToString();
    final errorData = jsonDecode(responseString);
    return UnauthorizedException(errorData["detail"]);
    case 403:
    final responseString = await response.stream.bytesToString();
    final errorData = jsonDecode(responseString);
    return ForbiddenException(errorData["detail"]);
    case 404:
    final responseString = await response.stream.bytesToString();
    final errorData = jsonDecode(responseString);
    return ResourceNotFoundException(errorData["detail"]);
    case 500:
    return InternalServerErrorException("Unknown error occurred!");
    default:
    return NetworkException(
    "Network Error.Please make sure you have internet connection");
  }
  }

  @override
  Future<StreamedResponse> call<T>(Future<StreamedResponse> Function(T args) api, T args) async {
    var response = await api(args);
    if (response.statusCode == 401) {
      // if not authenticated refresh and retry
      var token = await getCachedToken();
      token = await refreshTokenAndCash(token.refreshToken);
      response = await api(args);
    }
    if (response.statusCode != 200) {
      // if not ok throw exception
      throw await getException(response);
    }
    // if all ok return response
    return response;
  }

  // @override
  // Future<TokenPair> getCachedToken() {
  //   // TODO: implement getCachedToken
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<TokenPair> refreshTokenAndCash(String refreshToken) {
  //   // TODO: implement refreshTokenAndCash
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<StreamedResponse> request({required String url, required TokenPair token, required String method, Map<String, String>? requestHeaders, Map<String, String>? data}) {
  //   // TODO: implement request
  //   throw UnimplementedError();
  // }
  //}

  @override
  Future<TokenPair> getCachedToken() async {
    final token = await LocalStorage.getToken();
    if (token != null) return token;
    throw UnauthorizedException("Please sign in to continue");
  }

  @override
  Future<TokenPair> refreshTokenAndCash(String refreshToken) async {
    final url = Uri.parse("${Constants.BASE_URL}/auth/refresh-token");
    var headers = {'x-refresh-token': refreshToken};
    var request = Request('GET', url);
    request.headers.addAll(headers);
    StreamedResponse refreshResponse = await request.send();
    if (refreshResponse.statusCode == 200) {
      final token = TokenPair(
        accessToken: refreshResponse.headers["x-access-token"]!,
        refreshToken: refreshResponse.headers["x-refresh-token"]!,
      );
      // Save new token so it can be available for future requests
      await LocalStorage.saveToken(token);
      return token;
    }
    final responseString = await refreshResponse.stream.bytesToString();
    final errorData = jsonDecode(responseString);
    throw UnauthorizedException(errorData["detail"]);
  }

  @override
  Future<StreamedResponse> request({required String url, required TokenPair token, required String method, Map<String, String>? requestHeaders, Map<String, String>? data}) async {
    var headers = {'x-access-token': token.accessToken};
    var request = Request(method, Uri.parse(url));
    if (requestHeaders != null) request.headers.addAll((headers));
    request.headers.addAll(headers);
    if (data != null) request.body = jsonEncode(data);

    StreamedResponse response = await request.send();
    if (response.statusCode == 401) {
      final authResponse = await refreshTokenAndCash(token.refreshToken);
      headers = {'x-access-token': authResponse.accessToken};
      request = Request(method, Uri.parse(url));
      if (requestHeaders != null) request.headers.addAll((headers));
      request.headers.addAll(headers);
      if (data != null) request.body = jsonEncode(data);
      response = await request.send();
    }
    if (response.statusCode != 200) {
     // throw await getException(response);
    }
    return response;
  }

// Implement other abstract methods as necessary
}