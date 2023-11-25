import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nishauri/src/app/navigation/drawer/UserDrawerHeader.dart';
import 'package:nishauri/src/features/auth/data/providers/auth_provider.dart';
import 'package:nishauri/src/features/common/data/providers/announcements_provider.dart';
import 'package:nishauri/src/features/common/presentation/widgets/AnnouncementCard.dart';
import 'package:nishauri/src/features/common/presentation/widgets/Greetings.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

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
                context.goNamed(RouteNames.VERIFY_ACCOUNT);
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
            Padding(
              padding: const EdgeInsets.all(Constants.SPACING),
              child: Text(
                "Did you know?",
                style: theme.textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: Constants.SPACING,
            ),
            Consumer(
              builder: (context, ref, child) {
                final announcementsAsync = ref.watch(announcementsProvider);
                return announcementsAsync.when(
                  data: (data) => SizedBox(
                    height: screenSize.height * 0.22,
                    // Adjust the height as needed
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal,
                      // aspectRatio: 0.4,
                      itemBuilder: (context, currIndex) => AnnouncementCard(
                        width: data.length > 1
                            ? screenSize.width * 0.75
                            : screenSize.width * 0.99,
                        image: data[currIndex].image,
                        source: data[currIndex].source,
                        title: data[currIndex].title,
                        description: data[currIndex].description,
                      ),
                    ),
                  ),
                  error: (error, _) => Container(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: Constants.SPACING,
            ),
            /*SizedBox(
                height: screenSize.height * 0.1,
                child: ListView.builder(
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => AppCard(
                    clipBehaviour: Clip.antiAlias,
                    variant: CardVariant.ELEVETED,
                    color: theme.colorScheme.onPrimary,
                    child: SizedBox(
                      width: screenSize.height * 0.1,
                      height: screenSize.height * 0.1,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.access_alarms_rounded,
                            size: screenSize.height * 0.07,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5)),
                            width: double.infinity,
                            height: double.infinity,
                            child: Center(child: Text("$index", style: theme.textTheme.headlineLarge?.copyWith(color: Colors.white),)),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),*/
            const SizedBox(
              height: Constants.SPACING,
            ),
          ],
        ),
      ),
    );
  }
}
