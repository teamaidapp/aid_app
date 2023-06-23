import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/travels/screens/hotel.screen.dart';
import 'package:team_aid/features/travels/screens/itinerary.screen.dart';
import 'package:team_aid/features/travels/screens/meeting.screen.dart';

/// The statelessWidget that handles the current screen
class TravelsScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const TravelsScreen({super.key});

  @override
  ConsumerState<TravelsScreen> createState() => _TravelsScreenState();
}

class _TravelsScreenState extends ConsumerState<TravelsScreen> {
  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('dd / MMM').format(DateTime.now()).toUpperCase();
    final formattedDay =
        DateFormat('EEEE').format(DateTime.now()).toUpperCase();
    final seeTravels = useState(true);
    final formPageController = usePageController();
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
                      text: 'Travels',
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
          SizedBox(height: 2.h),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffF5F8FB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  if (seeTravels.value)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TAContainer(
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
                          ),
                          const SizedBox(width: 80),
                          Expanded(
                            child: TAPrimaryButton(
                              text: 'NEW TRAVEL',
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              icon: Iconsax.add,
                              onTap: () {
                                seeTravels.value = false;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (seeTravels.value)
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(20),
                        children: [
                          TAContainer(
                            padding: EdgeInsets.zero,
                            child: ExpandablePanel(
                              collapsed: const SizedBox(),
                              theme: const ExpandableThemeData(hasIcon: false),
                              header: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Iconsax.airplane5,
                                      color: TAColors.purple,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TATypography.paragraph(
                                          text: 'Dallas Competition',
                                          fontWeight: FontWeight.w600,
                                        ),
                                        TATypography.paragraph(
                                          text: 'Flight',
                                          color: TAColors.grey1,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const SizedBox(
                                      height: 90,
                                      child: VerticalDivider(),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      children: [
                                        TATypography.paragraph(
                                          text: 'Monday',
                                          color: TAColors.grey1,
                                        ),
                                        TATypography.paragraph(
                                          text: '28 MAY',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ),
                              expanded: Column(
                                children: [
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 20,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Iconsax.airplane),
                                                const SizedBox(width: 8),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TATypography.subparagraph(
                                                      text: 'FROM',
                                                      color: TAColors.grey1,
                                                    ),
                                                    TATypography.paragraph(
                                                      text: '01 JUN',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    TATypography.paragraph(
                                                      text: '8:15AM',
                                                      color: TAColors.grey1,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 60),
                                            Row(
                                              children: [
                                                const Icon(Iconsax.airplane),
                                                const SizedBox(width: 8),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TATypography.subparagraph(
                                                      text: 'TO',
                                                      color: TAColors.grey1,
                                                    ),
                                                    TATypography.paragraph(
                                                      text: '01 JUN',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    TATypography.paragraph(
                                                      text: '9:15AM',
                                                      color: TAColors.grey1,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            const Icon(Iconsax.building_4),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TATypography.subparagraph(
                                                    text: 'Hotel',
                                                    color: TAColors.grey1,
                                                  ),
                                                  TATypography.paragraph(
                                                    text: 'Rio All Suites',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  TATypography.paragraph(
                                                    text:
                                                        '3700 W Flamingo Rd, Las Vegas, NV 89103',
                                                    color: TAColors.grey1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: TAColors.purple,
                                                ),
                                              ),
                                              padding: const EdgeInsets.all(6),
                                              child: const Icon(
                                                Iconsax.location,
                                                color: TAColors.purple,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            const Icon(Iconsax.user_tag),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TATypography.subparagraph(
                                                    text: 'Meeting',
                                                    color: TAColors.grey1,
                                                  ),
                                                  TATypography.paragraph(
                                                    text:
                                                        'Doral Campus Academy',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  TATypography.paragraph(
                                                    text:
                                                        '9025 W Cactus Ave, Las Vegas, NV 89178',
                                                    color: TAColors.grey1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: TAColors.purple,
                                                ),
                                              ),
                                              padding: const EdgeInsets.all(6),
                                              child: const Icon(
                                                Iconsax.location,
                                                color: TAColors.purple,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: PageView(
                        controller: formPageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ItineraryTravelScreen(
                            pageController: formPageController,
                          ),
                          HotelTravelScreen(
                            pageController: formPageController,
                          ),
                          MeetingTravelScreen(
                            pageController: formPageController,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
