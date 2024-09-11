import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';

import 'SelectSurvey.dart';




class PsurveyHomeScreen extends HookConsumerWidget {
  const PsurveyHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currIndex = useState(0);

    return  Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "pSurvey",
            // icon: Icons.calendar_month_outlined,
            subTitle: "A platform for qualitative and quantitative surveys",
            color: Constants.pSurveyColor,
          ),

          Padding(
            padding: const EdgeInsets.all(Constants.SPACING),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),

              ),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.map, color: Colors.white),
                title: Text('Available surveys', style: TextStyle(
                  color: Colors.white, // Title color
                  fontWeight: FontWeight.bold,
                ),),
                subtitle: Text('3', style: TextStyle(
                  color: Colors.white, // Title color
                  fontWeight: FontWeight.bold,
                ),),
                trailing: Icon(Icons.navigate_next, color: Colors.white),
                tileColor: Constants.pSurveyColor,
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectSurveyScreen()),
                  );

                },

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Constants.SPACING),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 3,
              child:  ListTile(
                leading: Icon(Icons.photo,color: Colors.white),
                title: Text('Completed surveys', style: TextStyle(
                  color: Colors.white, // Title color
                  fontWeight: FontWeight.bold,
                ),),
                subtitle: Text('0', style: TextStyle(
                  color: Colors.white, // Title color
                  fontWeight: FontWeight.bold,
                ),),
                trailing: Icon(Icons.navigate_next, color: Colors.white),
                tileColor: Constants.pSurveyColor,
                onTap: (){
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SelectSurveyScreen()),
                  // );

                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}