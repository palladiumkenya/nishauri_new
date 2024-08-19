import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nishauri/src/features/common/data/models/faq_model.dart';
import 'package:nishauri/src/features/common/data/services/FAQ_service.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class FAQPage extends HookWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    // State hooks
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final faqs = useState<List<FAQModel>>([]);
    final filteredFaqs = useState<List<FAQModel>>([]);
    final loading = useState(true);

    // Debouncer for search input
    final debouncer = useMemoized(() => Debouncer(milliseconds: 500));

    // Fetch FAQs from the API
    useEffect(() {
      fetchFAQs() async {
        try {
          final faqService = FAQService();
          final results = await faqService.fetchFAQs('');
          faqs.value = results;
          filteredFaqs.value = results;
          loading.value = false;
        } catch (e) {
          log("Error fetching FAQs: $e");
          loading.value = false;
        }
      }

      fetchFAQs();
      return null;
    }, []);

    // Update filtered FAQs based on search query
    useEffect(() {
      final search = searchQuery.value;
      debouncer.run(() {
        if (search.isEmpty) {
          filteredFaqs.value = faqs.value;
        } else {
          filteredFaqs.value = faqs.value.where((faq) {
            return faq.question.toLowerCase().contains(search.toLowerCase());
          }).toList();
        }
      });
      return null;
    }, [searchQuery.value]);

    // Handle search input changes
    void onSearchChanged(String query) {
      searchQuery.value = query;
    }

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "FAQ's",
            subTitle: "Frequently Asked Questions.",
            color: Constants.frequentlyAskedQuestions,
            bottom: Row(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Constants.ROUNDNESS * 0.5),
                      ),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: onSearchChanged,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search questions...',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                color: Colors.white,
                                onPressed: () {
                                  searchController.clear();
                                  onSearchChanged('');
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: loading.value
                ? const Center(child: CircularProgressIndicator())
                : filteredFaqs.value.isEmpty
                    ? Center(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.67,
                          child: const BackgroundImageWidget(
                            svgImage: 'assets/images/lab-empty-state.svg',
                            notFoundText: "No results Found",
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredFaqs.value.length,
                        itemBuilder: (context, index) {
                          final faq = filteredFaqs.value[index];
                          return ExpansionTile(
                            key: PageStorageKey<String>(faq.question),
                            title: Text(
                              faq.question,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            children: [
                              const SizedBox(height: 7.0),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(faq.answer),
                              ),
                            ],
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
