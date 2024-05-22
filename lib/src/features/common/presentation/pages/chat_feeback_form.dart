import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/shared/display/label_input_container.dart';
import 'package:nishauri/src/shared/input/Button.dart';
import 'package:nishauri/src/utils/constants.dart';

class ChatFeedbackForm extends HookWidget {
  const ChatFeedbackForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final theme = Theme.of(context);
    final loading = useState<bool>(false);

    void handleSubmit() {
      if (formKey.currentState!.saveAndValidate()) {
        loading.value = true;
        Future.delayed(const Duration(seconds: 3)).then((value) {
          loading.value = false;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Thank you for the feedback")));
          context.pop();
        });
      }
    }

    return FormBuilder(
      key: formKey,
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: Constants.SPACING,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Expanded(child: Text("How was your coversation with Nuru?")),
              IconButton(icon: FaIcon(FontAwesomeIcons.circleXmark, color: theme.colorScheme.error,), onPressed: ()=>context.pop(),)
            ]),
            LabelInputContainer(
              label: "Rating",
              child: FormBuilderChoiceChip<int>(
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                name: "rating",
                decoration: const InputDecoration(border: InputBorder.none),
                options: List.generate(
                  5,
                  (index) => FormBuilderChipOption(
                    value: index + 1,
                    child: Text(
                      "${index + 1}",
                    ),
                  ),
                ),
              ),
            ),
            LabelInputContainer(
              label: "Review",
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      Constants.ROUNDNESS,
                    ),
                  ),
                ),
                child: FormBuilderTextField(
                  name: "review",
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: theme.canvasColor,
                  ),
                  maxLines: 3,
                  minLines: 3,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: Constants.SPACING,
            ),
            Button(
                title: "Submit",
                backgroundColor: theme.colorScheme.primary,
                loading: loading.value,
                textColor: Colors.white,
                onPress: handleSubmit)
          ],
        ),
      ),
    );
  }
}
