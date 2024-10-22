import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/helpers.dart';

class BlogPostWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;

  const BlogPostWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(Constants.SPACING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.headlineMedium),
          SvgPicture.asset(
            imageUrl,
            width: double.infinity,
            height: getOrientationAwareScreenSize(context).height * 0.30,
            fit: BoxFit.cover,
          ),
          Expanded(child: Markdown(data: description)),
        ],
      ),
    );
  }
}
