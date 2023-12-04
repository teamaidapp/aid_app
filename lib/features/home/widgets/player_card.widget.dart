import 'package:flutter/material.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/home/entities/player.model.dart';

/// The PlayerCard class is a stateless widget that displays a player's avatar, first name, and role,
/// and can be tapped to trigger a callback function.
class PlayerCard extends StatelessWidget {
  /// Constructor
  const PlayerCard({
    required this.player,
    required this.onTap,
    super.key,
  });

  /// Player model
  final PlayerModel player;

  /// On tap callback
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TAContainer(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      player.avatar.isEmpty ? 'https://placehold.co/200/png' : player.avatar,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TATypography.paragraph(
                    text: player.firstName,
                    fontWeight: FontWeight.w600,
                  ),
                  TATypography.subparagraph(
                    text: player.role,
                    fontWeight: FontWeight.w500,
                    color: TAColors.color1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
