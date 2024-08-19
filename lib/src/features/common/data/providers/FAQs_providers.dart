// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nishauri/src/features/common/data/models/faq_model.dart';
// import 'package:nishauri/src/features/common/data/repositories/FAQ_repository.dart';
// import 'package:nishauri/src/features/common/data/services/FAQ_service.dart';

// final faqProvider = FutureProvider.family<List<FAQModel>, String>((ref, query) async {
//   final service = FAQService();
//   final repo = FAQRepository(service, query);
//   return await repo.fetchFAQs(query);
// });