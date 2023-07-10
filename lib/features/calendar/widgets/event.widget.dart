import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/design_system/components/buttons/secondary_button.dart';
import 'package:team_aid/design_system/design_system.dart';

/// A widget that displays a request
class EventWidget extends StatelessWidget {
  /// The constructor
  const EventWidget({
    required this.eventName,
    required this.organizerName,
    required this.startTime,
    required this.endTime,
    super.key,
  });

  /// The name of the event
  final String eventName;

  /// The name of the organizer
  final String organizerName;

  /// The start time of the event
  final String startTime;

  /// The end time of the event
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return TAContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.calendar_25,
                        size: 24,
                        color: TAColors.purple,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TATypography.paragraph(
                            text: eventName,
                            color: TAColors.textColor,
                            fontWeight: FontWeight.w700,
                          ),
                          TATypography.paragraph(
                            text: 'Organized by ',
                            color: TAColors.grey1,
                          ),
                          TATypography.paragraph(
                            text: organizerName,
                            underline: true,
                            color: TAColors.grey1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TASecondaryButton(
                    text: 'INFORMATION',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 150,
            child: VerticalDivider(color: TAColors.color3),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TATypography.paragraph(
                  text: 'Start',
                  color: TAColors.grey1,
                ),
                TATypography.paragraph(
                  text: startTime,
                  color: TAColors.textColor,
                  fontWeight: FontWeight.w700,
                ),
                TATypography.paragraph(
                  text: 'End',
                  color: TAColors.grey1,
                ),
                TATypography.paragraph(
                  text: endTime,
                  color: TAColors.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
