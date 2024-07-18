import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nishauri/src/features/bp/presentation/components/fullscreen_dialoge.dart';
import 'package:nishauri/src/features/bp/presentation/features/export_import/export_field_format_documentation_screen.dart';

class EnterTimeFormatDialoge extends StatefulWidget {

  final String initialValue;
  final DateTime? previewTime;
  final bool bottomAppBars;
  const EnterTimeFormatDialoge({super.key,
    required this.initialValue,
    this.previewTime,
    this.bottomAppBars = false,
  });

  @override
  State<EnterTimeFormatDialoge> createState() => _EnterTimeFormatDialogeState();
}

class _EnterTimeFormatDialogeState extends State<EnterTimeFormatDialoge> {
  final timeFormatFieldController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    timeFormatFieldController.text = widget.initialValue;
    timeFormatFieldController.addListener(() => setState(() {}));
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    timeFormatFieldController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return FullscreenDialoge(
      actionButtonText: localizations.btnSave,
      bottomAppBar: widget.bottomAppBars,
      onActionButtonPressed: () {
        if(timeFormatFieldController.text.isNotEmpty) {
          Navigator.pop(context, timeFormatFieldController.text);
        }
      },
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Markdown(
                shrinkWrap: true,
                onTapLink: getLinkTapHandler(context),
                physics: const NeverScrollableScrollPhysics(),
                data: localizations.enterTimeFormatDesc,
              ),
              Text(DateFormat(timeFormatFieldController.text).format(widget.previewTime ?? DateTime.now())),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: timeFormatFieldController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: localizations.enterTimeFormatString,
                    errorText: timeFormatFieldController.text.isEmpty ? localizations.errNoValue : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String?> showTimeFormatPickerDialoge(BuildContext context, String initialTimeFormat, bool bottomAppBars) =>
  showDialog<String?>(context: context, builder: (context) => EnterTimeFormatDialoge(
    initialValue: initialTimeFormat,
    bottomAppBars: bottomAppBars,),
  );
