import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';

/// A widget that displays a request
class DrawerWidget extends StatelessWidget {
  /// The constructor
  const DrawerWidget({
    required this.scaffoldKey,
    super.key,
  });

  /// The scaffold key
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    const spaceBetweenItems = 30.0;
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 32, right: 30),
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TATypography.h2(text: 'Hi [name]'),
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.closeDrawer();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _DrawerOptionWidget(
              icon: Iconsax.profile_add,
              title: 'Add player',
              onTap: () {
                context.push(AppRoutes.addPlayer);
              },
            ),
            const SizedBox(height: spaceBetweenItems),
            _DrawerOptionWidget(
              icon: Iconsax.home,
              title: 'Household',
              onTap: () {},
            ),
            const SizedBox(height: spaceBetweenItems),
            _DrawerOptionWidget(
              icon: Iconsax.people,
              title: 'Teams',
              onTap: () {},
            ),
            const SizedBox(height: spaceBetweenItems),
            _DrawerOptionWidget(
              icon: Iconsax.sms,
              title: 'Messages',
              onTap: () {},
            ),
            const SizedBox(height: spaceBetweenItems),
            _DrawerOptionWidget(
              icon: Iconsax.clipboard,
              title: 'Calendar',
              onTap: () {},
            ),
            const SizedBox(height: spaceBetweenItems),
            _DrawerOptionWidget(
              icon: Iconsax.global,
              title: 'Travels',
              onTap: () {},
            ),
            const SizedBox(height: spaceBetweenItems),
            _DrawerOptionWidget(
              icon: Iconsax.folder_open,
              title: 'My Files',
              onTap: () {},
            ),
            const SizedBox(height: spaceBetweenItems),
            _DrawerOptionWidget(
              icon: Iconsax.profile_circle,
              title: 'My Account',
              onTap: () {},
            ),
            const SizedBox(height: spaceBetweenItems),
            _DrawerOptionWidget(
              icon: Iconsax.message_question,
              title: 'Help and Support',
              onTap: () {},
            ),
          ],
        ),
      ),
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
