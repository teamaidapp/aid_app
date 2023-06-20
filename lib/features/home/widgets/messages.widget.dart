import 'package:flutter/material.dart';
import 'package:team_aid/design_system/design_system.dart';

/// A widget that displays a request
class MessagesWidget extends StatelessWidget {
  /// The constructor
  const MessagesWidget({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
  });

  /// The icon to display
  final IconData icon;

  /// The name of the request
  final String title;

  /// The description of the request
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: TAColors.purple),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TATypography.paragraph(
                text: title,
                color: TAColors.textColor,
                fontWeight: FontWeight.w600,
              ),
              TATypography.paragraph(
                text: description,
                color: TAColors.grey1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
