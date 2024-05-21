import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: flatInvitations.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              ),
            ],
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
