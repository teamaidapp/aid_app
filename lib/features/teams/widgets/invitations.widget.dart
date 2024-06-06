import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/teams/entities/invitation_parsed.model.dart';
import 'package:team_aid/features/teams/widgets/team_invitation_card.widget.dart';

/// The MyInvitationsWidget is a Flutter widget that displays a list of invitations based on data retrieved from a
/// home controller provider.
class MyInvitationsWidget extends StatefulHookConsumerWidget {
  /// The constructor.
  const MyInvitationsWidget({super.key});

  @override
  ConsumerState<MyInvitationsWidget> createState() => _MyInvitationsWidgetState();
}

class _MyInvitationsWidgetState extends ConsumerState<MyInvitationsWidget> {
  @override
  Widget build(BuildContext context) {
    final invitations = ref.watch(homeControllerProvider).invitations;
    final sentInvitations = ref.watch(homeControllerProvider).sentInvitations;

    return invitations.when(
      data: (data) {
        if (data.isNotEmpty) {
          // Create a flat list to hold all invitations
          final flatInvitations = data.expand((team) {
            return team.invitations.map((invitation) {
              return ParsedInvitationModel(
                teamName: team.teamName,
                sport: team.sport,
                invitation: invitation,
              );
            });
          }).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: flatInvitations.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  physics: const NeverScrollableScrollPhysics(), // This ListView should not scroll separately
                  itemBuilder: (context, index) {
                    final invitation = flatInvitations[index];
                    return Column(
                      children: [
                        TeamInvitationCardWidget(invitation: invitation),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
                sentInvitations.when(
                  data: (data) {
                    if (data.noRegisteredUsers.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          itemCount: data.noRegisteredUsers.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(), // This ListView should not scroll separately
                          itemBuilder: (context, index) {
                            final user = data.noRegisteredUsers[index];
                            return Column(
                              children: [
                                TAContainer(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Iconsax.user,
                                            color: TAColors.purple,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TATypography.paragraph(
                                                  text: user.email,
                                                  color: TAColors.textColor,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                TATypography.subparagraph(
                                                  text: 'User with no account yet.',
                                                  color: TAColors.grey1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: TATypography.paragraph(
                                          text: user.teamId.teamName.toUpperCase(),
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
                                              text: user.teamId.sport,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: TATypography.paragraph(
                                          text: 'User not registered yet.',
                                          fontWeight: FontWeight.w700,
                                          color: TAColors.purple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  error: (_, __) => const SizedBox(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: TAColors.purple,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: TATypography.paragraph(
                text: 'No invitations yet.',
                color: TAColors.purple,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }
      },
      error: (_, __) => const SizedBox(),
      loading: () {
        return const Center(
          child: CircularProgressIndicator(
            color: TAColors.purple,
          ),
        );
      },
    );
  }
}
