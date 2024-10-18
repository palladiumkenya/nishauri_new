import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

class ItemList extends StatelessWidget {
  final List<String> items;
  final Color backgroundColor;
  const ItemList({
    Key? key,
    required this.items,
    this.backgroundColor = Constants.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = 100 + (items.length - 1) * 70 + 5;

    return Container(
      color: backgroundColor,
      child: SizedBox(
        height: height.toDouble(),
        child: ListView.separated(
          itemCount: items.length + 1,
          separatorBuilder: (context, index) {
            return const Divider(color: Colors.grey);
          },
          itemBuilder: (context, index) {
            if (index < items.length) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  // Handle item tap
                },
                trailing: const Icon(Icons.chevron_right),
              );
            } else {
              // This is the separator item
              return const SizedBox.shrink(); // No content for the separator item
            }
          },
        ),
      ),
    );
  }
}
