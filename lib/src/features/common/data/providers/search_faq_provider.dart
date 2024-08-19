// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nishauri/src/features/common/data/models/faq_model.dart';
// import 'package:nishauri/src/features/common/data/providers/FAQs_providers.dart';

// class SearchFaqNotifier extends StateNotifier<List<FAQModel>> {
//   List<FAQModel> _allFaqs;

//   SearchFaqNotifier(this._allFaqs) : super(_allFaqs);

//   void updateFaqs(List<FAQModel> faqs) {
//     _allFaqs = faqs;
//     search(''); // Optionally perform an initial search to reset the state
//   }

//   void search(String query) {
//     if (query.isEmpty) {
//       state = _allFaqs;
//     } else {
//       state = _allFaqs.where((faq) {
//         return faq.question.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     }
//   }
// }

// final searchFaqProvider = StateNotifierProvider<SearchFaqNotifier, List<FAQModel>>((ref) {
//   final faqs = ref.watch(faqProvider).asData?.value ?? [];
//   return SearchFaqNotifier(faqs);
// });
