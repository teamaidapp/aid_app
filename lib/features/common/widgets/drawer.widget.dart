import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/enums/role.enum.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/main.dart';

/// A widget that displays a request
class DrawerWidget extends HookConsumerWidget {
  /// The constructor
  const DrawerWidget({
    required this.scaffoldKey,
    super.key,
  });

  /// The scaffold key
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const spaceBetweenItems = 30.0;

    return ref.watch(sharedPrefs).when(
          data: (prefs) {
            final name = prefs.getString(TAConstants.firstName);
            final role = prefs.getString(TAConstants.role);

            return Drawer(
              child: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.only(left: 32, right: 30),
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TATypography.h3(
                            text: 'Hi $name',
                            color: TAColors.textColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            scaffoldKey.currentState?.closeDrawer();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    if (role == Role.admin.name) const SizedBox(height: 30),
                    if (role == Role.admin.name)
                      _DrawerOptionWidget(
                        icon: Iconsax.profile_add,
                        title: 'Coaches',
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.addPlayer,
                            queryParameters: {'isPlayer': 'false'},
                          );
                        },
                      ),
                    const SizedBox(height: 30),
                    _DrawerOptionWidget(
                      icon: Iconsax.profile_circle,
                      title: 'Collaborators',
                      onTap: () {
                        context.pushNamed(AppRoutes.collaborators);
                      },
                    ),
                    if (role == Role.player.name || role == Role.coach.name) const SizedBox(height: 30),
                    if (role == Role.player.name || role == Role.coach.name)
                      _DrawerOptionWidget(
                        icon: Iconsax.profile_add,
                        title: 'Add player',
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.addPlayer,
                            queryParameters: {'isPlayer': 'true'},
                          );
                        },
                      ),
                    if (role == Role.coach.name || role == Role.parent.name) const SizedBox(height: 30),
                    if (role == Role.coach.name || role == Role.parent.name)
                      _DrawerOptionWidget(
                        icon: Iconsax.home,
                        title: 'Household',
                        onTap: () {
                          context.push(AppRoutes.household);
                        },
                      ),
                    // const SizedBox(height: spaceBetweenItems),

                    const SizedBox(height: spaceBetweenItems),
                    _DrawerOptionWidget(
                      icon: Iconsax.people,
                      title: 'Teams',
                      onTap: () {
                        context.push(AppRoutes.teams);
                      },
                    ),
                    // const SizedBox(height: spaceBetweenItems),
                    // _DrawerOptionWidget(
                    //   icon: Iconsax.sms,
                    //   title: 'Messages',
                    //   onTap: () {},
                    // ),
                    const SizedBox(height: spaceBetweenItems),
                    _DrawerOptionWidget(
                      icon: Iconsax.clipboard,
                      title: 'Calendar',
                      onTap: () {
                        context.pushNamed(
                          AppRoutes.calendar,
                          queryParameters: {
                            'addToCalendar': 'false',
                          },
                        );
                      },
                    ),
                    const SizedBox(height: spaceBetweenItems),
                    _DrawerOptionWidget(
                      icon: Iconsax.global,
                      title: 'Travels',
                      onTap: () {
                        context.push(AppRoutes.travel);
                      },
                    ),
                    const SizedBox(height: spaceBetweenItems),
                    _DrawerOptionWidget(
                      icon: Iconsax.folder_open,
                      title: 'Attachments',
                      onTap: () {
                        context.pushNamed(
                          AppRoutes.files,
                          queryParameters: {'isInTravel': 'true'},
                        );
                      },
                    ),
                    const SizedBox(height: spaceBetweenItems),
                    _DrawerOptionWidget(
                      icon: Iconsax.profile_circle,
                      title: 'My Account',
                      onTap: () {
                        context.push(AppRoutes.account);
                      },
                    ),
                    // const SizedBox(height: spaceBetweenItems),
                    // _DrawerOptionWidget(
                    //   icon: Iconsax.message_question,
                    //   title: 'Help and Support',
                    //   onTap: () {},
                    // ),
                    const SizedBox(height: spaceBetweenItems),
                    _DrawerOptionWidget(
                      icon: Iconsax.logout,
                      title: 'Log out',
                      onTap: () {
                        Navigator.pop(context);
                        context.go(AppRoutes.login);
                      },
                    ),
                  ],
                ),
              ),
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
        );
  }
}

class _DrawerOptionWidget extends StatelessWidget {
  const _DrawerOptionWidget({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;

  final String title;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
            color: TAColors.textColor,
          ),
          const SizedBox(width: 20),
          TATypography.paragraph(
            text: title,
            color: TAColors.textColor,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
