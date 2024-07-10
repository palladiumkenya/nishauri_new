import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/shared/models/token_pair.dart';
import 'package:nishauri/src/utils/constants.dart';

abstract class HTTPService {
  String getQueryParams(Map<String, dynamic> query){
    var q=query.entries.map((e) => "${e.key}=${e.value}");
    return q.isNotEmpty ? "?${q.join("&")}": "";
  }
  Future<Exception> getException(StreamedResponse response) async {
    switch (response.statusCode) {
      case 400:
        final responseString = await response.stream.bytesToString();
        final errorData = jsonDecode(responseString);
        return BadRequestException(errorData);
      case 401:
        final responseString = await response.stream.bytesToString();
        final errorData = jsonDecode(responseString);
        return UnauthorizedException(errorData);
      case 403:
        final responseString = await response.stream.bytesToString();
        final errorData = jsonDecode(responseString);
        return ForbiddenException(errorData["msg"]);
      case 404:
        final responseString = await response.stream.bytesToString();
        final errorData = jsonDecode(responseString);
        return ResourceNotFoundException(errorData["msg"]);
      case 500:
        return InternalServerErrorException("Unknown error occurred!");
      default:
        return NetworkException(
            "Network Error.Please make sure you have internet connection");
    }
  }

  Future<String> getUserId() async {
    final id = await LocalStorage.get("user");
    if (id != null) return id;
    throw UnauthorizedException("Please sign in to continue");
  }

  Future<TokenPair> refreshTokenAndCash(String refreshToken, String userId) async {
    final payload = {"token" : refreshToken, "user_id" : userId,};
    var headers = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse("${Constants.BASE_URL_NEW}refreshtoken");
    var request = Request('POST', url);
    request.body = jsonEncode(payload);
    request.headers.addAll(headers);
    StreamedResponse refreshResponse = await request.send();

    if (refreshResponse.statusCode == 200) {
      final responseString = await refreshResponse.stream.bytesToString();
      final responseData = jsonDecode(responseString);

      final token = TokenPair(
        accessToken: responseData['data']['token']!,
        refreshToken: responseData['data']['refreshToken']!,
      );
      // Save new token so it can be available for future requests
      await LocalStorage.saveToken(token);
      return token;
    }
    final responseString = await refreshResponse.stream.bytesToString();
    final errorData = jsonDecode(responseString);
    throw UnauthorizedException(errorData);
  }

  Future<TokenPair> getCachedToken() async {
    final token = await LocalStorage.getToken();
    if (token != null) return token;
    throw UnauthorizedException("Please sign in to continue");
  }

  Future<StreamedResponse> request(
      {required String url,
         required TokenPair token,
        required String method,
        required Map<String, String> requestHeaders,
        required String userId,
        Map<String, dynamic>? data}) async {
    var headers = requestHeaders;
    var request = Request(method, Uri.parse(url));
    request.headers.addAll(headers);
    if (data != null) request.body = jsonEncode(data);
    StreamedResponse response = await request.send();
    if (response.statusCode == 401) {
      final authResponse = await refreshTokenAndCash(token.refreshToken, userId);
      headers = {'Authorization': "Bearer ${authResponse.accessToken}",
                  'Content-Type': 'application/json',};
      request = Request(method, Uri.parse(url));
      request.headers.addAll(headers);
      if (data != null) request.body = jsonEncode(data);
      response = await request.send();
    }
    if (response.statusCode != 200 && response.statusCode != 401) {
      throw await getException(response);
    }
    return response;
  }

  Future<StreamedResponse> call<T>(Future<StreamedResponse> Function(T args) api,
      T args,
      ) async {
    // call api
    var response = await api(args);
    if (response.statusCode == 401) {
      // if not authenticated refresh and retry
      var token = await getCachedToken();
      var id = await getUserId();
      token = await refreshTokenAndCash(token.refreshToken, id);
      response = await api(args);
    }
    if (response.statusCode != 200) {
      // if not ok throw exception
      throw await getException(response);
    }
    // if all ok return response
    return response;
  }
}
