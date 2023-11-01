import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/common/presentation/widgets/Banners.dart';
import 'package:nishauri/src/features/common/presentation/widgets/Greetings.dart';
import 'package:nishauri/src/features/common/presentation/widgets/UserDrawerHeader.dart';
import 'package:nishauri/src/utils/constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  toggleDrawer() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.closeDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        leading: IconButton(
          onPressed: toggleDrawer,
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
        child: ListView(
          children: [
            const UserDrawerHeader(
                email: "ouma.omondi1@students.jkuat.ac.ke",
                name: "Laurent Ouma Omondi",
                phoneNumber: "+254793889658"),
            ListTile(
              leading: const Icon(Icons.dashboard_customize_rounded),
              title: const Text("Dashboard"),
              onTap: () {
                // Close drawer
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.verified),
              title: const Text("Verify"),
              onTap: () {
                context.go("/verify");
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text("Send Feedback"),
              onTap: () {
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Confirmation"),
                      content: SvgPicture.asset(
                        "assets/images/warning.svg",
                        height: 200,
                        width: 200,
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              ref.watch(authStateProvider.notifier).logout();
                              // Close drawer
                              Navigator.pop(context);
                            },
                            child: const Text("Log out"))
                      ],
                    );
                  },
                );
              },
            ),
            // ...drawerItems.map(
            //   (e) => ListTile(
            //     leading: Icon(e.icon),
            //     title: Text(e.title),
            //     onTap: () {
            //       if(e.onPress !=null){
            //         e.onPress!(context);
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Greetings(
              name: "Laurent Ouma",
            ),
            const Text(
              "\t\t\tDeals",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: Constants.SPACING,
            ),
            SizedBox(
              height: screenSize.width * 0.4, // Adjust the height as needed
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, currIndex) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: screenSize.width * 0.7,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/p.jpg"),
                        fit: BoxFit.cover,
                      ),
                      backgroundBlendMode: BlendMode.darken,
                      color: theme.primaryColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Constants.SPACING),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Banner: ${currIndex + 1}",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: Constants.SPACING,
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.refresh),
                title: Text('Sync your account with your medical records'),
              ),
            ),
            const SizedBox(
              height: Constants.SPACING,
            ),

          ],
        ),
      ),
    );
  }
}
