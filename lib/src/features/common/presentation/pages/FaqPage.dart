import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/common/data/providers/FAQs_providers.dart';
import 'package:nishauri/src/features/common/data/providers/search_faq_provider.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';


class FAQPage extends ConsumerStatefulWidget {
  const FAQPage({super.key});

  @override
  ConsumerState<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends ConsumerState<FAQPage> {
  @override
  Widget build(BuildContext context) {
    final faqState = ref.watch(faqProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text("Frequently Asked Questions (FAQs)"),
        ),
      ),
      body: faqState.when(
        data: (faqs) {
          // Initialize the search provider with the loaded FAQs
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(searchFaqProvider.notifier).updateFaqs(faqs);
            ref.read(searchFaqProvider.notifier).search('');
          });

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search questions...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (query) {
                    ref.read(searchFaqProvider.notifier).search(query);
                  },
                ),
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final filteredFaqs = ref.watch(searchFaqProvider);
                    return ListView.builder(
                      itemCount: filteredFaqs.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          key: PageStorageKey<String>(filteredFaqs[index].question),
                          title: Text(
                            filteredFaqs[index].question,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          children: [
                            const SizedBox(height: 7.0,),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(filteredFaqs[index].answer),
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stack) {
          String errorMessage;
          if (error is BadRequestException) {
            errorMessage = 'Bad Request: ${error.errors}';
          } else if (error is UnauthorizedException) {
            errorMessage = 'Unauthorized: ${error.message}';
          } else if (error is ForbiddenException) {
            errorMessage = 'Forbidden: ${error.message}';
          } else if (error is ResourceNotFoundException) {
            errorMessage = 'Not Found: ${error.message}';
          } else if (error is InternalServerErrorException) {
            errorMessage = 'Internal Server Error: ${error.message}';
          } else if (error is NetworkException) {
            errorMessage = 'Network Error: ${error.message}';
          } else {
            errorMessage = 'An unexpected error occurred';
          }
          return Center(child: Text(errorMessage));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
