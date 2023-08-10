import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/core/extensions.dart';
import 'package:team_aid/design_system/components/buttons/secondary_button.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/teams/entities/invitation_parsed.model.dart';

/// The statelessWidget that handles the current screen
class TeamInvitationCardWidget extends StatelessWidget {
  /// The constructor.
  const TeamInvitationCardWidget({
    required this.invitation,
    super.key,
  });

  /// The team model.
  final ParsedInvitationModel invitation;

  @override
  Widget build(BuildContext context) {
    return TAContainer(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Iconsax.user,
                color: TAColors.purple,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TATypography.paragraph(
                    text: '${invitation.invitation.userId.firstName.capitalize()} ${invitation.invitation.userId.lastName.capitalize()}',
                    color: TAColors.textColor,
                    fontWeight: FontWeight.w700,
                  ),
                  TATypography.subparagraph(
                    text: invitation.invitation.userId.email,
                    color: TAColors.grey1,
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: TATypography.paragraph(
              text: invitation.teamName.toUpperCase(),
              color: TAColors.purple,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TATypography.paragraph(
                  text: 'Sport ',
                  color: TAColors.color1,
                ),
                TATypography.paragraph(
                  text: invitation.sport,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TASecondaryButton(
                  text: 'DECLINE',
                  mainAxisAlignment: MainAxisAlignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TAPrimaryButton(
                  text: 'ACCEPT',
                  mainAxisAlignment: MainAxisAlignment.center,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
