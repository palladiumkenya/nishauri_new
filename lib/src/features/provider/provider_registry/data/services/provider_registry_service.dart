import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/provider/provider_registry/data/models/provider_registry.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ProviderRegistryService extends HTTPService {

  final AuthRepository _repository = AuthRepository(AuthApiService());

  Future<ProviderRegistry> searchProviderRegistry(Map<String, dynamic> data) async {
    final response = await call (searchProviderRegistry_, data);

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final Map<String, dynamic> responseData = json.decode(responseString);

      if (responseData["success"] == true) {
        final Map<String, dynamic> provider = responseData["data"]["provider"];
        return ProviderRegistry.fromJson(provider);
      }
      else {
        throw responseData["message"];
      }
    }
    else {
      throw "Something went wrong contact Admin";
    }
  }

  Future<StreamedResponse> searchProviderRegistry_(
      Map<String, dynamic> data) async {
    final id = await _repository.getUserId();
    var user = {'user_id': id};
    var mergedData = {...data, ...user};
    final tokenPair = await getCachedToken();
    var headers = {
      'Authorization': "Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json',
    };
    var url = '${Constants.BASE_URL_NEW}practitioner';
    final response = await request(url: url, token: tokenPair, method: 'POST', requestHeaders: headers, data: mergedData, userId: id);
    return response;
  }

  Future<ProviderRegistry> getProviderDetails() async {
    final data = await loadJsonData("assets/data/provider.json");
    final json = jsonDecode(data);

      final Map<String, dynamic> providerJson = json["provider"];
      final provider = ProviderRegistry.fromJson(providerJson);
      log("$provider");
      return provider;
    // final response = await call (getProviderDetails_, null);
    //
    // if (response.statusCode == 200) {
    //   final responseString = await response.stream.bytesToString();
    //   final Map<String, dynamic> responseData = json.decode(responseString);
    //
    //   if (responseData["success"] == true) {
    //     final Map<String, dynamic> provider = responseData["data"]["provider"];
    //     return ProviderRegistry.fromJson(provider);
    //   }
    //   else {
    //     throw responseData["message"];
    //   }
    // }
    // else {
    //   throw "Something went wrong contact Admin";
    // }
  }

  // Future<StreamedResponse> getProviderDetails_(dynamic args) async {
  //   final id = await _repository.getUserId();
  //   final tokenPair = await getCachedToken();
  //   var headers = {
  //     'Authorization': "Bearer ${tokenPair.accessToken}",
  //     'Content-Type': 'application/json',
  //   };
  //   var url = '${Constants.BASE_URL_NEW}practitioner/user_id';
  //   final response = await request(url: url, token: tokenPair, method: 'GET', requestHeaders: headers, userId: id);
  //   return response;
  // }
}