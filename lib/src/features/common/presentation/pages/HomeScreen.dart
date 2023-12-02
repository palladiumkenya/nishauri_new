import 'package:dots_indicator/dots_indicator.dart';
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
import 'package:nishauri/src/features/user/data/providers/user_provider.dart';
import 'package:nishauri/src/shared/display/AppCard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nishauri/src/shared/extensions/extensions.dart';
import 'package:nishauri/src/utils/constants.dart';
import 'package:nishauri/src/utils/routes.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

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
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];
    final asyncUser = ref.watch(userProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        leading: IconButton(
          onPressed: toggleDrawer,
          icon: const Icon(Icons.sort),
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
            if (asyncUser.hasValue)
              GestureDetector(
                child: UserDrawerHeader(
                  email: asyncUser.value!.email,
                  name:
                      "${asyncUser.value!.firstName} ${asyncUser.value!.lastName}"
                          .titleCase,
                  phoneNumber: asyncUser.value!.phoneNumber,
                  image: asyncUser.value!.image,
                ),
                onTap: () => context.goNamed(RouteNames.PROFILE_SETTINGS),
              ),

            ListTile(
              leading: const Icon(Icons.dashboard_customize_rounded),
              title: const Text("Dashboard"),
              onTap: () {
                context.goNamed(RouteNames.DASHBOARD);
                // Close drawer
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Notification"),
              onTap: () {
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
      body: asyncUser.when(
          data: (user) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Greetings(
                      name: "${user.firstName} ${user.lastName}".titleCase,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Constants.SPACING),
                      child: Text(
                        "Did you know?",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(
                      height: Constants.SPACING,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final announcementsAsync =
                            ref.watch(announcementsProvider);
                        return announcementsAsync.when(
                          data: (data) => Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                    height: screenSize.height * 0.20,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    enlargeCenterPage: true,
                                    enlargeFactor: 0.3,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    }),
                                items: data.map((announcement) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return AnnouncementCard(
                                        image: announcement.image,
                                        source: announcement.source,
                                        title: announcement.title,
                                        description: announcement.description,
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              DotsIndicator(
                                dotsCount: data.length,
                                position: _currentIndex,
                                decorator: DotsDecorator(
                                    size: const Size.square(9.0),
                                    activeSize: const Size(18.0, 9.0),
                                    activeShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    activeColor: theme.colorScheme.primary),
                              )
                            ],
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
                    Consumer(
                      builder: (context, ref, child) {
                        final announcementsAsync =
                            ref.watch(announcementsProvider);
                        return announcementsAsync.when(
                          data: (data) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.all(Constants.SPACING),
                                child: Text(
                                  "Upcoming appointments",
                                  style: theme.textTheme.titleSmall,
                                ),
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  height: screenSize.height * 0.10,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.3,
                                ),
                                items: data.map((announcement) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return AppCard(
                                        color: theme.colorScheme.onPrimary,
                                        variant: CardVariant.ELEVETED,
                                        child: ListTile(
                                          leading: Container(
                                            padding: const EdgeInsets.all(
                                              Constants.SPACING,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  theme.colorScheme.background,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  Constants.ROUNDNESS,
                                                ),
                                              ),
                                            ),
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.calendar_month),
                                              ],
                                            ),
                                          ),
                                          title: const Text(
                                              "Clinical Review Appointments",
                                              maxLines: 1),
                                          titleTextStyle: theme
                                              .textTheme.titleSmall
                                              ?.copyWith(
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                          subtitle:
                                              const Text("3 days Remaining"),
                                          subtitleTextStyle:
                                              theme.textTheme.bodySmall,
                                          trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "20th",
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                "Oct",
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
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
                  ],
                ),
              ),
          error: (error, _) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}
