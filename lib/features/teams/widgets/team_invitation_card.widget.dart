import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/core/extensions.dart';
import 'package:team_aid/design_system/components/buttons/secondary_button.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/teams/controllers/teams.controller.dart';
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
          HookConsumer(
            builder: (context, ref, child) {
              final declineIsLoading = useState(false);
              final acceptedIsLoading = useState(false);
              return Row(
                children: [
                  Expanded(
                    child: TASecondaryButton(
                      text: 'DECLINE',
                      isLoading: declineIsLoading.value,
                      mainAxisAlignment: MainAxisAlignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      onTap: () async {
                        declineIsLoading.value = true;
                        final res = await ref.read(teamsControllerProvider.notifier).updateInvitation(
                              status: 'rejected',
                              invitationId: invitation.invitation.id,
                            );
                        declineIsLoading.value = false;

                        if (res.ok && context.mounted) {
                          await ref.read(homeControllerProvider.notifier).getInvitations(isCoach: true);
                          if (context.mounted) {
                            unawaited(
                              SuccessWidget.build(
                                title: 'Success!',
                                message: 'The invitation was declined.',
                                context: context,
                              ),
                            );
                          }
                        } else {
                          unawaited(
                            FailureWidget.build(
                              title: 'Something went wrong!',
                              message: res.message,
                              context: context,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TAPrimaryButton(
                      text: 'ACCEPT',
                      isLoading: acceptedIsLoading.value,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onTap: () async {
                        acceptedIsLoading.value = true;
                        final res = await ref.read(teamsControllerProvider.notifier).updateInvitation(
                              status: 'accepted',
                              invitationId: invitation.invitation.id,
                            );
                        acceptedIsLoading.value = false;

                        if (res.ok && context.mounted) {
                          await ref.read(homeControllerProvider.notifier).getInvitations(isCoach: true);
                          if (context.mounted) {
                            unawaited(
                              SuccessWidget.build(
                                title: 'Success!',
                                message: 'The invitation was accepted.',
                                context: context,
                              ),
                            );
                          }
                        } else {
                          unawaited(
                            FailureWidget.build(
                              title: 'Something went wrong!',
                              message: res.message,
                              context: context,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
