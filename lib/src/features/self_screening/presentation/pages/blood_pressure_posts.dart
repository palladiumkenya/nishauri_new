import 'package:flutter/material.dart';
import 'package:nishauri/src/features/common/data/models/announcement.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/shared/display/blog_post_widget.dart';
import 'package:nishauri/src/shared/display/scafold_stack_body.dart';
import 'package:nishauri/src/utils/constants.dart';

class BloodPressurePostScreen extends StatelessWidget {
  final Announcement announcement;

  const BloodPressurePostScreen({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: announcement.header ?? "Did you know 💡",
            color: Constants.selfScreeningBgColor,
          ),
          Expanded(
            child: ScaffoldStackedBody(
              body: BlogPostWidget(
                title: announcement.title,
                imageUrl: announcement.image,
                description: announcement.description!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
