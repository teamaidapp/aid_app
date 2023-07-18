import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/enums/role.enum.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/drawer.widget.dart';
import 'package:team_aid/features/common/widgets/today.widget.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/home/widgets/messages.widget.dart';
import 'package:team_aid/features/home/widgets/requests.widget.dart';
import 'package:team_aid/features/home/widgets/upcoming_events.widget.dart';
import 'package:team_aid/main.dart';

/// The statelessWidget that handles the current screen
class HomeScreen extends ConsumerStatefulWidget {
  /// The constructor.
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final requestsExpandableController = ExpandableController(initialExpanded: true);
  final messagesExpandableController = ExpandableController(initialExpanded: true);
  final upcomingEventsExpandableController = ExpandableController(initialExpanded: true);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ref.read(homeControllerProvider.notifier).getUserTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prefsProvider = ref.watch(sharedPrefs);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    prefsProvider.when(
                      data: (prefs) {
                        final name = prefs.getString(TAConstants.firstName);
                        return TATypography.h3(
                          text: 'Hi $name',
                          color: TAColors.textColor,
                          fontWeight: FontWeight.w700,
                        );
                      },
                      error: (error, stackTrace) => TATypography.h3(
                        text: 'Hi',
                        color: TAColors.textColor,
                        fontWeight: FontWeight.w700,
                      ),
                      loading: () {
                        return TATypography.h3(
                          text: 'Hi',
                          color: TAColors.textColor,
                          fontWeight: FontWeight.w700,
                        );
                      },
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: const Icon(
                        Iconsax.menu_1,
                        color: TAColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffF5F8FB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TodayWidget(),
                        const SizedBox(width: 80),
                        prefsProvider.when(
                          data: (prefs) {
                            final role = prefs.getString(TAConstants.role);
                            if (role == Role.coach.name) {
                              return Expanded(
                                child: TAPrimaryButton(
                                  text: 'CREATE TEAM',
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  icon: Iconsax.add,
                                  onTap: () {
                                    context.push(AppRoutes.createAccountTeamForCoach);
                                  },
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                          error: (error, stackTrace) {
                            return const SizedBox();
                          },
                          loading: () {
                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ExpandablePanel(
                      controller: requestsExpandableController,
                      header: TATypography.h3(
                        text: 'Requests',
                        color: TAColors.textColor,
                      ),
                      collapsed: const SizedBox(),
                      expanded: const TAContainer(
                        radius: 28,
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RequestsWidget(
                              icon: Iconsax.copy_success5,
                              name: 'Camila',
                              description: 'Sent you a message invitation...',
                            ),
                            Divider(),
                            RequestsWidget(
                              icon: Iconsax.copy_success5,
                              name: 'Camila',
                              description: 'Sent you a message invitation...',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ExpandablePanel(
                      controller: messagesExpandableController,
                      header: TATypography.h3(
                        text: 'Messages',
                        color: TAColors.textColor,
                      ),
                      collapsed: const SizedBox(),
                      expanded: const TAContainer(
                        radius: 28,
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MessagesWidget(
                              icon: Iconsax.message_25,
                              title: 'Alejandro Villegas',
                              description: 'Hi! the boys and I are...',
                            ),
                            Divider(),
                            MessagesWidget(
                              icon: Iconsax.message_25,
                              title: 'Coach Felipe',
                              description: 'Hi! the boys and I are...',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ExpandablePanel(
                      controller: upcomingEventsExpandableController,
                      header: TATypography.h3(
                        text: 'Upcoming Events',
                        color: TAColors.textColor,
                      ),
                      collapsed: const SizedBox(),
                      expanded: const TAContainer(
                        radius: 28,
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            UpcomingEventsWidget(
                              icon: Iconsax.message_25,
                              title: 'Alejandro Villegas',
                              description: 'Hi! the boys and I are...',
                            ),
                            Divider(),
                            UpcomingEventsWidget(
                              icon: Iconsax.message_25,
                              title: 'Coach Felipe',
                              description: 'Hi! the boys and I are...',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // TAPrimaryButton(
                    //   text: 'ADD SCHEDULE',
                    //   height: 50,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   onTap: () {},
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
