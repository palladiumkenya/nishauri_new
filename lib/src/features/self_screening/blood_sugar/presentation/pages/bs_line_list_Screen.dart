import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nishauri/src/features/self_screening/blood_sugar/data/models/blood_sugar.dart';
import 'package:nishauri/src/shared/display/CustomAppBar.dart';
import 'package:nishauri/src/shared/display/background_image_widget.dart';
import 'package:nishauri/src/utils/constants.dart';

class BloodSugarRecords extends StatelessWidget {
  final List<BloodSugar> data;

  const BloodSugarRecords({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (data.isEmpty)
    {
      BackgroundImageWidget(
        customAppBar: const CustomAppBar(
          color: Constants.selfScreeningBgColor,
          height: 120,
          smallTitle: "All Record Data",
          rightBtTitle: "",
        ), svgImage: 'assets/images/emptyself_screening.svg',
        notFoundText: 'No Data Recorded Yet',
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(
            color: Constants.selfScreeningBgColor,
            height: 120,
            smallTitle: "All Record Data",
            rightBtTitle: "Edit",
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Constants.SPACING),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MMOL/L",
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey),
                  ),
                  Expanded(
                    child: Container(
                      color: Constants.bgColor,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final bs = data[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: SvgPicture.asset(
                                  "assets/images/boldDuotoneMedicinePulse.svg",
                                  width: 20,
                                  height: 20,
                                ),
                                title: ExpansionTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '${bs.level}',
                                                style: theme.textTheme.titleMedium
                                              ),

                                              TextSpan(
                                                text: ' mmol/L',
                                                style: theme.textTheme.titleSmall
                                              ),
                                            ]
                                          )
                                      ),
                                      // Text(
                                      //   "${bs.level}",
                                      //   style: theme.textTheme.titleMedium,
                                      // ),
                                      Text(
                                        DateFormat('dd MMM yy HH:mm').format(DateTime.parse(bs.created_at.toString()),), style: theme.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  children: <Widget>[
                                    ListTile(
                                      title: bs.condition != null && bs.condition!.isNotEmpty
                                          ? Text('Condition: ${bs.condition}')
                                          : null,
                                      subtitle: bs.notes != null && bs.notes!.isNotEmpty ? Text('Notes: ${bs.notes}') : null,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(), // Add the Divider here
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
