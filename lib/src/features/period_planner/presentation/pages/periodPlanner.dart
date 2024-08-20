import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/periodPlannerMenu.dart';
import 'package:nishauri/src/features/period_planner/presentation/pages/periodPlannerScreen.dart';
import 'package:nishauri/src/shared/display/CustomeAppBar.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class PeriodPlanner extends StatelessWidget {
  const PeriodPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: "Period Planner App 🌸",
            color: Constants.periodPlanner,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Constants.periodPlanner.withOpacity(1.0),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/contours.png"),
                        opacity: 0.1,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        DecoratedBox(
                          decoration: const BoxDecoration(),
                          child: SvgPicture.asset(
                            "assets/images/period_planner2.svg",
                            fit: BoxFit.contain,
                            height: 100,
                            width: 100, 
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Track Your Cycle with Ease',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Stay healthy And Well Informed',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            context.goNamed(RouteNames.PERIOD_PLANNER_MENU);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 40.0,
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18.0,
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
                          title: 'Track Your Period',
                          description: 'Keep an accurate record of your menstrual cycles to better understand your health.',
                          icon: Icons.track_changes,
                        ),
                        FeatureTile(
                          title: 'Period Calendar',
                          description: 'View and manage your menstrual cycles with a detailed calendar.',
                          icon: Icons.calendar_today,
                        ),
                        FeatureTile(
                          title: 'Partner Tracking',
                          description: 'Allow your partner to keep track of your cycle and stay informed about your health as well.',
                          icon: Icons.people,
                        ),
                      ],
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

class FeatureTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  FeatureTile({
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
