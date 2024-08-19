import 'dart:convert';
import 'package:nishauri/src/features/auth/data/respositories/auth_repository.dart';
import 'package:nishauri/src/features/auth/data/services/AuthApiService.dart';
import 'package:nishauri/src/features/common/data/models/faq_model.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class FAQService extends HTTPService {
  final AuthRepository _repository = AuthRepository(AuthApiService());

  Future<List<FAQModel>> fetchFAQs(String faqs) async {
    try{
      final response = await call(fetchFAQs_, faqs);

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final Map<String, dynamic> dataNew = json.decode(responseString);

        return (dataNew['questions'] as List<dynamic>)
          .map((e) => FAQModel.fromJson(e))
          .toList();
      }
      else {
        throw "Something Went Wrong Try Again Later ${response.statusCode}";
      }
    }
    catch (e) {
      print('Error during JSON parsing: $e'); // Log parsing error
      throw Exception('Failed to parse FAQs');
    } 
  }

  Future<http.StreamedResponse> fetchFAQs_(String faqs) async{
    final id = await _repository.getUserId();
    final tokenPair = await getCachedToken();
    var url = '${Constants.BASE_URL_NEW}/get_faqs?name=$faqs&user_id=$id';
    var headers = {
      'Authorization': "Bearer ${tokenPair.accessToken}",
      'Content-Type': 'application/json'
    };
    final response = request(url: url, token: tokenPair, method: 'GET', requestHeaders: headers, userId: id);

    return response;
  }
}


