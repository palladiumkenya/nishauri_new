import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nishauri/src/features/common/data/models/announcement.dart';

class BlogPostScreen extends StatelessWidget {
  final Announcement announcement;
  const BlogPostScreen({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(body: Placeholder(),);
  }
}
