import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:team_aid/design_system/design_system.dart';

/// This widget displays the today widget
class TodayWidget extends StatelessWidget {
  /// The constructor
  TodayWidget({
    super.key,
  });

  /// The formatted date to display.
  final formattedDate =
      DateFormat('dd / MMM').format(DateTime.now()).toUpperCase();

  /// The formatted day to display.
  final formattedDay = DateFormat('EEEE').format(DateTime.now()).toUpperCase();

  @override
  Widget build(BuildContext context) {
    return TAContainer(
      radius: 28,
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 18,
      ),
      child: Row(
        children: [
          const Icon(
            Iconsax.calendar,
            color: TAColors.purple,
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TATypography.subparagraph(
                text: formattedDay,
                color: TAColors.grey1,
              ),
              TATypography.paragraph(
                text: formattedDate,
                fontWeight: FontWeight.w600,
                color: TAColors.textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
