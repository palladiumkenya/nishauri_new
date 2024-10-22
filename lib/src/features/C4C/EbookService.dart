import 'EbookModel.dart';

class EbookService {
  // Method to simulate fetching JSON data
  Future<List<Ebook>> fetchEbooks() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final List<Map<String, dynamic>> jsonData = [
      {"title": "sample pdf 1", "url": "https://www.pdfbooksworld.com/The-Call-Of-The-Wild-by-Jack-London"},
      {"title": "sample pdf 2", "url": "https://www.pdfbooksworld.com/The-Call-Of-The-Wild-by-Jack-London"},
    ];

    // Map JSON data to Ebook model
    return jsonData.map((e) => Ebook.fromJson(e)).toList();
  }
}
