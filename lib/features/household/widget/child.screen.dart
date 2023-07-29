import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/core/entities/team.model.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';

/// The statelessWidget that handles the current screen
class ChildWidget extends StatelessWidget {
  /// The constructor.
  const ChildWidget({
    required this.team,
    super.key,
  });

  /// The team model.
  final TeamModel team;

  @override
  Widget build(BuildContext context) {
    return TAContainer(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Iconsax.profile_2user5,
                color: TAColors.purple,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TATypography.paragraph(
                    text: 'Sarah Jones',
                    color: TAColors.textColor,
                    fontWeight: FontWeight.w700,
                  ),
                  TATypography.paragraph(
                    text: team.teamName.toUpperCase(),
                    color: TAColors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              // const Spacer(),
              // const Icon(
              //   Iconsax.more,
              //   color: TAColors.textColor,
              // ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                TATypography.paragraph(
                  text: 'Sport: ',
                  color: TAColors.color1,
                ),
                TATypography.paragraph(
                  text: team.sport,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TAPrimaryButton(
                  text: 'SCHEDULE',
                  mainAxisAlignment: MainAxisAlignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  onTap: () {
                    context.push(
                      Uri(
                        path: AppRoutes.contactList,
                        queryParameters: {
                          'id': team.id,
                          'name': team.teamName,
                        },
                      ).toString(),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TAPrimaryButton(
                  text: 'ADD TO CALENDAR',
                  padding: EdgeInsets.zero,
                  mainAxisAlignment: MainAxisAlignment.center,
                  onTap: () {
                    context.push(AppRoutes.calendar);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
