import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';




class PsurveyHomeScreen extends HookConsumerWidget {
  const PsurveyHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currIndex = useState(0);

    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "pSurvey",
            // icon: Icons.calendar_month_outlined,
            subTitle: "A platform for qualitative and quantitative surveys",
            color: Constants.pSurveyColor,
          ),

        ],
      ),
    );
  }
}