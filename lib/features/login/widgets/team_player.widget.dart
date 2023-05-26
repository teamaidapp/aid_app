import 'package:flutter/material.dart';
import 'package:team_aid/design_system/design_system.dart';

/// Widget to display a register option
class TeamPlayerWidget extends StatelessWidget {
  /// Creates a [TeamPlayerWidget]
  const TeamPlayerWidget({
    required this.icon,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.description,
    super.key,
  });

  /// Subtitle to display
  final String subtitle;

  /// Title to display
  final String title;

  /// Description to display
  final String description;

  /// Icon to display
  final IconData icon;

  /// Callback to execute when the widget is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: TAContainer(
        radius: 20,
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: const Color(0xff496CF1),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TATypography.subparagraph(
                      text: subtitle,
                      color: const Color(0xff999999),
                    ),
                    TATypography.paragraph(
                      text: title,
                      fontWeight: FontWeight.w600,
                      color: TAColors.textColor,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Divider(color: Colors.black.withOpacity(0.25)),
            const SizedBox(height: 4),
            TATypography.subparagraph(
              text: description,
              textAlign: TextAlign.center,
              color: const Color(0xff999999),
            )
          ],
        ),
      ),
    );
  }
}
