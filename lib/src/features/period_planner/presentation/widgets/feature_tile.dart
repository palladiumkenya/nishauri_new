import 'package:flutter/material.dart';

class FeatureTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const FeatureTile({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(description),
    );
  }
}