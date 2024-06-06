import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';

/// A widget that displays a request
class RequestsWidget extends StatelessWidget {
  /// The constructor
  const RequestsWidget({
    required this.teamName,
    super.key,
  });

  /// The teamName
  final String teamName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.teams);
      },
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          const Icon(Iconsax.copy_success5, color: TAColors.purple),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TATypography.paragraph(
                  text: teamName,
                  color: TAColors.textColor,
                  fontWeight: FontWeight.w600,
                ),
                TATypography.paragraph(
                  text: 'You have pending requests ...',
                  color: TAColors.grey1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
