import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nishauri/src/features/common/data/providers/FAQs_providers.dart';
import 'package:nishauri/src/features/common/data/providers/search_faq_provider.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/shared/exeptions/http_exceptions.dart';
import 'package:nishauri/src/utils/constants.dart';

class FAQPage extends ConsumerStatefulWidget {
  const FAQPage({super.key});

  @override
  ConsumerState<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends ConsumerState<FAQPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Added a listener to the TextEditingController to trigger the search provider when the text changes
    _searchController.addListener(() {
      ref.read(searchFaqProvider.notifier).search(_searchController.text);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final faqState = ref.watch(faqProvider);

    return Scaffold(
      body: faqState.when(
        data: (faqs) {
          // Initialize the search provider with the loaded FAQs
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(searchFaqProvider.notifier).updateFaqs(faqs);
            ref.read(searchFaqProvider.notifier).search(_searchController.text);
          });

          return Column(
            children: [
              CustomAppBar(
                title: "Frequently Asked Questions (FAQs)",
                subTitle: "These are some of the Frequently Asked Questions by our Users",
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
                          controller: _searchController,
                          onChanged: (value) {
                            ref.read(searchFaqProvider.notifier).search(value);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search questions...',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    color: Colors.white,
                                    onPressed: () {
                                      _searchController.clear();
                                      ref.read(searchFaqProvider.notifier).search('');
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
                child: Consumer(
                  builder: (context, ref, child) {
                    final filteredFaqs = ref.watch(searchFaqProvider);
                    // Center(
                    //         child: BackgroundImageWidget(
                    //       svgImage:
                    //           'assets/images/facility-dir-empty-state.svg',
                    //       notFoundText: textController.text.length >= 3
                    //           ? "Facility not found"
                    //           : "Search Facility",
                    //     )),
                    //   )
                    // Handles When a user searches for a question that does not exist
                    if (filteredFaqs.isEmpty) {
                      return  const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 200,
                              child: BackgroundImageWidget(
                                svgImage: 'assets/images/warning.svg',
                                svgHeight: 100, 
                                notFoundText: '',
                              ),
                            ),
                            SizedBox(height: 10), // Add spacing between the image and the text
                            Text(
                              "Results Not Found",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }


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
                            const SizedBox(height: 7.0),
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
