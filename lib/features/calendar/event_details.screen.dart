import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/extensions.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/calendar/entities/event.model.dart';

/// The `EventDetails` class is a widget that displays details about an event, including the event name,
/// organizer name, start and end times, and a list of assistants.
class EventDetailsScreen extends StatelessWidget {
  /// The constructor
  const EventDetailsScreen({
    required this.event,
    super.key,
  });

  /// The event
  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM').format(DateTime.now()).toUpperCase();
    final startTime = DateFormat('hh:mm a').format(event.event.startDate).toUpperCase();
    final endTime = DateFormat('hh:mm a').format(event.event.endDate).toUpperCase();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 10),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Iconsax.arrow_left_2,
                      color: TAColors.textColor,
                    ),
                    const Spacer(),
                    TATypography.h3(
                      text: 'My Calendar',
                      color: TAColors.textColor,
                      fontWeight: FontWeight.w700,
                    ),
                    const Spacer(),
                    // const Icon(
                    //   Iconsax.menu_1,
                    //   color: TAColors.textColor,
                    // ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffF5F8FB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TAContainer(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 20,
                      left: 20,
                      bottom: 10,
                    ),
                    child: Row(
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
                              text: event.event.userCreator?.firstName.capitalizeWord() ?? '',
                              color: TAColors.textColor,
                              fontWeight: FontWeight.w700,
                            ),
                            // TATypography.paragraph(
                            //   text: 'Organized by ',
                            //   color: TAColors.grey1,
                            // ),
                            // TATypography.paragraph(
                            //   text: organizerName,
                            //   color: TAColors.grey1,
                            // ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: const Icon(
                            Iconsax.close_circle,
                            color: TAColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: TAColors.color1),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            TATypography.subparagraph(
                              text: 'Day',
                              color: TAColors.grey1,
                            ),
                            TATypography.paragraph(
                              text: formattedDate,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Iconsax.calendar_25,
                                  color: TAColors.purple,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TATypography.paragraph(
                                        text: event.event.eventName,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      TATypography.paragraph(
                                        text: 'by ${event.event.userCreator?.firstName} ${event.event.userCreator?.lastName}',
                                        color: TAColors.grey1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TATypography.paragraph(
                            text: 'Start',
                            color: TAColors.grey1,
                          ),
                          const SizedBox(width: 10),
                          TATypography.paragraph(
                            text: startTime,
                            color: TAColors.textColor,
                            fontWeight: FontWeight.w700,
                          ),
                          const SizedBox(width: 10),
                          TATypography.paragraph(
                            text: 'End',
                            color: TAColors.grey1,
                          ),
                          const SizedBox(width: 10),
                          TATypography.paragraph(
                            text: endTime,
                            color: TAColors.textColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: TAColors.color1),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.people),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TATypography.paragraph(
                                  text: 'Assistants',
                                  color: TAColors.grey1,
                                ),
                                ...List.generate(
                                  event.event.guests.length,
                                  (index) {
                                    return TATypography.paragraph(
                                      text:
                                          '${event.event.guests[index].firstName.capitalizeWord()} ${event.event.guests[index].lastName.capitalizeWord()}',
                                      fontWeight: FontWeight.w600,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 36.w,
                    child: TAPrimaryButton(
                      text: 'SHARE',
                      icon: Iconsax.share,
                      onTap: () {
                        context.push(
                          Uri(
                            path: AppRoutes.contactList,
                            queryParameters: {
                              'id': '',
                              'name': '',
                              'action': 'isSharingCalendar',
                            },
                          ).toString(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
