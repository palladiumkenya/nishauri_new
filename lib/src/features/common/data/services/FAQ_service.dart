import 'dart:convert';
import 'package:nishauri/src/features/common/data/models/faq_model.dart';
import 'package:nishauri/src/local_storage/LocalStorage.dart';
import 'package:nishauri/src/shared/interfaces/HTTPService.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class FAQService extends HTTPService {
  final String url;

  FAQService({
    this.url = '${Constants.BASE_URL_NEW}/get_faqs',
  });

  Future<List<FAQModel>> fetchFAQs() async {
    final token = await getCachedToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${token.accessToken}',
      },
    );

    print(response.statusCode);
    print(response.body); // Logged the response status code and body for debugging

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> faqList = data['questions'];
        return faqList.map((faq) => FAQModel.fromJson(faq)).toList();
      }
      catch (e) {
        print('Error during JSON parsing: $e'); // Log parsing error
        throw Exception('Failed to parse FAQs');
      }
    } else {
      throw "Something Went Wrong Try Again Later ${response.statusCode}";
    }
  }
}
