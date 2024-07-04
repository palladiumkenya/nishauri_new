import 'package:nishauri/src/features/common/data/models/faq_model.dart';
import 'package:nishauri/src/features/common/data/services/FAQ_service.dart';

class FAQRepository {
  final FAQService _faqService;

  FAQRepository(this._faqService);

  Future<List<FAQModel>> fetchFAQs() async {
    return await _faqService.fetchFAQs();
  }
}

