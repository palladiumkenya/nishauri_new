import 'package:flutter/material.dart';
class TitledColumn extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  const TitledColumn({super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      ListTile(
        title: DefaultTextStyle(
          style: Theme.of(context).textTheme.titleLarge!,
          child: title,
        ),
      ),
    ];
    items.addAll(children);
    return Column(
      children: items,
    );
  }
}
