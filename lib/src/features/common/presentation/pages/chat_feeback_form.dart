import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/chatbot/data/repository/ChatbotRepository.dart';
import 'package:nishauri/src/features/chatbot/data/services/ChatbotService.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/shared/input/rating_bar.dart';
import 'package:nishauri/src/utils/constants.dart';

String? _getRatingMessage(int? rating) {
  switch (rating) {
    case 1:
      return "Very poor";
    case 2:
      return "Poor";
    case 3:
      return "Fair";
    case 4:
      return "Good";
    case 5:
      return "Very Good";
  }
  return null;
}

class ChatFeedbackForm extends HookWidget {
  const ChatFeedbackForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final theme = Theme.of(context);
    final loading = useState<bool>(false);
    final repo = ChatbotRepository(ChatbotService());

    void handleSubmit() {
      if (formKey.currentState!.saveAndValidate()) {
        loading.value = true;
        repo.review(formKey.currentState!.value).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Thank you for the feedback")));
          context.pop();
        }).catchError((err) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$err"),
            ),
          );
        }).whenComplete(() => loading.value = false);
      }
    }

    return FormBuilder(
      key: formKey,
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: Constants.SPACING,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Live Chat",
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  "(Chat Ended)",
                  style: TextStyle(color: theme.disabledColor),
                ),
                const SizedBox(height: Constants.SPACING * 2),
                const Text("Rate your conversation with \nNuru",
                    textAlign: TextAlign.center),
              ],
            ),
            FormBuilderField<int>(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "Please select a rating"),
              ]),
              builder: (state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RatingBar(
                      mainAxisAlignment: MainAxisAlignment.center,
                      maxRating: 6,
                      rating: state.value,
                      onRatingChange: (rating) => state.didChange(rating),
                      decoration: InputDecoration(
                          errorText: state.errorText, border: InputBorder.none),
                    ),
                    if (_getRatingMessage(state.value) != null)
                      Text(
                        _getRatingMessage(state.value)!,
                        style: TextStyle(color: theme.disabledColor),
                      ),
                  ],
                );
              },
              name: "rate",
            ),
            FormBuilderTextField(
              name: "reviews",
              decoration:
                  const InputDecoration(hintText: "Leave a review here ..."),
            ),
            Button(
              title: "Submit Response",
              backgroundColor: theme.colorScheme.primary,
              loading: loading.value,
              textColor: Colors.white,
              onPress: handleSubmit,
            ),
            InkWell(
              onTap: () => context.pop(),
              child: Text(
                "Skip Rating",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
