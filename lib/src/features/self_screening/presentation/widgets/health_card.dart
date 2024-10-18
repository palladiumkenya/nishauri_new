import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nishauri/src/utils/constants.dart';

class HealthCard extends StatelessWidget {
  final String? svgAsset;
  final String title;
  final String? text1;
  final String? text2;
  final String? text3;
  final String? value1;
  final String? value2;
  final String? value3;
  final String? vName1;
  final String? vName2;
  final String? vName3;
  final VoidCallback? onPressed;

  const HealthCard({
    this.svgAsset,
    required this.title,
    this.value1,
    this.value2,
    this.value3,
    this.text1,
    this.text2,
    this.text3,
    this.vName1,
    this.vName2,
    this.vName3,
    this.onPressed,
    Key? key,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (svgAsset != null) ...[
                  SvgPicture.asset(
                    svgAsset!,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Constants.selfScreeningBgColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onPressed,
                  child: const Icon(Icons.chevron_right),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildColumn(value1, text1, vName1, context)),
                const VerticalDivider(thickness: 3, color: Colors.grey),
                Expanded(child: _buildColumn(value2, text2, vName2, context)),
                const VerticalDivider(thickness: 3, color: Colors.grey),
                Expanded(child: _buildColumn(value3, text3, vName3, context)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColumn(String? value, String? text, String? name, BuildContext context) {
    final theme = Theme.of(context);
    if (value == null || text == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name ?? '', style: theme.textTheme.bodyMedium),
          Row(
            children: [
              Text(value, style: theme.textTheme.titleLarge),
              const SizedBox(width: 4),
              Text(text, style: theme.textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
