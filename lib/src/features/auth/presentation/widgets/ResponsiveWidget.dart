import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget Function(BuildContext, Color?) buildPageContent;

  const ResponsiveWidget({super.key, required this.buildPageContent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            Color? color;
            if (constraint.maxWidth > Constants.MEDIUM_SCREEN_WIDTH) {
               color = theme.colorScheme.onPrimary;
            }
            // Large screen
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Constants.MEDIUM_SCREEN_WIDTH,
                  maxHeight: screenSize.height,
                ),
                child: SingleChildScrollView(
                  child: buildPageContent(context, color),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
