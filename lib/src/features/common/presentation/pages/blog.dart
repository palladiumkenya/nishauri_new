import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/scafold_stack_body.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class BlogPostScreen extends StatelessWidget {
  final Announcement announcement;

  const BlogPostScreen({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Did you know",
            icon: Icons.question_answer_outlined,
            color: Constants.programsColor.withOpacity(0.5),),

          Expanded(
            child:       ScaffoldStackedBody(
              body: Padding(
                padding: const EdgeInsets.all(Constants.SPACING),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(announcement.title, style: theme.textTheme.headlineMedium),
                    Image.network(
                      announcement.image,
                      width: double.infinity,
                      height: getOrientationAwareScreenSize(context).height * 0.30,
                      fit: BoxFit.cover,
                    ),
                    Expanded(child: Markdown(data: announcement.description!))
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
