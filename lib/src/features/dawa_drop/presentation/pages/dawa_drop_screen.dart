import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/menu/MenuItemsBuilder.dart';
import 'package:nishauri/src/app/navigation/menu/MenuOption.dart';
import 'package:nishauri/src/app/navigation/menu/menuItems.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/pages/dawa_drop_menu.dart';
import 'package:nishauri/src/features/dawa_drop/presentation/widget/DawaDropGetStartedWidget.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/shared/display/meds.dart';
import 'package:nishauri/src/utils/constants.dart';

class DawaDropScreen extends StatelessWidget {
  const DawaDropScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () => Navigator.of(context).pop(),
      //     icon: const Icon(Icons.chevron_left),
      //   ),
      //   title: const Text('Dawa Drop App'),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          CustomAppBar(
            title: "Dawa Drop App 💊",
            // icon: Icons.shopping_cart_checkout,
            color: Constants.dawaDropColor.withOpacity(0.5),
          ),
          Expanded(
              child:       SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Constants.dawaDropColor.withOpacity(0.5),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/contours.png"),
                          opacity: 0.1,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const DecoratedBox(
                            decoration: BoxDecoration(),
                            child: Meds(),
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'Your Medication request made Easy',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Stay healthy request your next Dawa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () => navigateToDawaDropMenu(context),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 40.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Features',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          FeatureTile(
                            onPressed: () => navigateToCyclePredictionScreen(context),
                            title: 'Medication Request Management',
                            description: 'Request your prescribed medications aligned with your appointment schedule for timely fulfillment.',
                            icon: Icons.shopping_cart,
                          ),
                          FeatureTile(
                            onPressed: () => navigateToFertilityPredictionScreen(context),
                            title: 'Progress Monitoring of Medication Request',
                            description: 'Monitor the progression of your medication request to stay informed about its current stage.',
                            icon: Icons.track_changes,
                          ),
                          FeatureTile(
                            onPressed: () => navigateToSymptomLoggingScreen(context),
                            title: 'Medication Delivery Confirmation',
                            description: 'Confirm the successful delivery of your medication order and provide feedback on the received drugs\' condition.',
                            icon: Icons.done_outline_outlined,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          )
        ],
      )
    );
  }
}

class FeatureTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;

  FeatureTile({
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(description),
      onTap: onPressed,
    );
  }
}

void navigateToCyclePredictionScreen(BuildContext context) {
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => CyclePredictionScreen(),
  //   ),
  // );
}

void navigateToFertilityPredictionScreen(BuildContext context) {
  // Add navigation logic to Fertility Prediction Screen
}

void navigateToSymptomLoggingScreen(BuildContext context) {
  // Add navigation logic to Symptom Logging Screen
}

void navigateToDawaDropGetStarted(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DawaDropGetStartedWidget(),),
  );
}

  void navigateToDawaDropMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DawaDropMenuScreen(),),
    );
}
