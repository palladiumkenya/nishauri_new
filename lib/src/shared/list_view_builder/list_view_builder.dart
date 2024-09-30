import 'package:flutter/material.dart';
import 'package:nishauri/src/utils/constants.dart';

class RowViewList extends StatelessWidget {
  final List<Map<String, dynamic>> details;
  final Function(int index)? onRowTap;

  const RowViewList({
    Key? key,
    required this.details, this.onRowTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Constants.SPACING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: details.asMap().entries.map((entry) {
            int index = entry.key;
            var detail = entry.value;
            return GestureDetector(
              onTap: () => onRowTap?.call(index),
              child: _buildDetailRow(detail['icon'], detail['text']),
            );
          }).toList(),
        ),
      ),
    );
  }

  Row _buildDetailRow(IconData? icon, String? text, {int maxLines = 1}) {
    return Row(
      children: [
        Icon(icon, color: Constants.providerBgColor.withOpacity(0.5)),
        const SizedBox(width: Constants.SPACING),
        Expanded(child: Text(text??'', maxLines: maxLines)),
      ],
    );
  }
}
