import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nishauri/src/utils/constants.dart';

class FilterCard extends StatelessWidget {
  final VoidCallback? onPressed;

  const FilterCard({
    Key? key,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      color: Constants.bgColor,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildColumn("Daily", context)),
                const VerticalDivider(thickness: 3, color: Colors.grey),
                Expanded(child: _buildColumn("Weekly", context)),
                const VerticalDivider(thickness: 3, color: Colors.grey),
                Expanded(child: _buildColumn("Monthly", context)),
                const VerticalDivider(thickness: 3, color: Colors.grey),
                Expanded(child: _buildColumn("6Months", context)),
                const VerticalDivider(thickness: 3, color: Colors.grey),
                Expanded(child: _buildColumn("Yearly", context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumn(String day, BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: onPressed,
                  child:  Text(day, style: theme.textTheme.titleLarge),
              )

              // const SizedBox(width: 4),
              // Text("TUE", style: theme.textTheme.titleLarge),
            ],
          ),
        ],
      ),
    );
  }
}
