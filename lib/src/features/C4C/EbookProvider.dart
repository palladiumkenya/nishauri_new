import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'EbookModel.dart';
import 'EbookService.dart';


// Define the provider that manages the list of ebooks
final ebookProvider = FutureProvider<List<Ebook>>((ref) async {
  final ebookService = EbookService();
  return ebookService.fetchEbooks();
});
