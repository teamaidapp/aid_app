import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/functions.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/today.widget.dart';
import 'package:team_aid/features/travels/controllers/travels.controller.dart';
import 'package:team_aid/features/travels/entities/itinerary.model.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(travelsControllerProvider.notifier).getItineraries();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final seeTravels = useState(true);
    final selectedIndex = useState(0);
    final formPageController = usePageController();
    final itineraries = ref.watch(travelsControllerProvider).itineraryList;
    return Scaffold(
      bottomNavigationBar: !seeTravels.value
          ? Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(28),
                  topLeft: Radius.circular(28),
                ),
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 11,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                child: BottomNavigationBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  selectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: TAColors.textColor,
                  unselectedItemColor: TAColors.color1,
                  currentIndex: selectedIndex.value,
                  onTap: (index) {
                    selectedIndex.value = index;
                    formPageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.bus),
                      label: 'Itinerary',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.building_4),
                      label: 'Hotel',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.user_tag),
                      label: 'Meeting',
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox(),
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
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  if (seeTravels.value)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TodayWidget(),
                          const SizedBox(width: 80),
                          Expanded(
                            child: TAPrimaryButton(
                              text: 'NEW TRAVEL',
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      child: Column(
                        children: [
                          TATypography.h3(text: 'Itineraries'),
                          Expanded(
                            child: itineraries.when(
                              data: (data) {
                                return ListView.builder(
                                  padding: const EdgeInsets.all(20),
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        _ItineraryWidget(
                                          itinerary: data[index],
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                );
                              },
                              error: (error, stackTrace) {
                                return const SizedBox();
                              },
                              loading: () {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
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

class _ItineraryWidget extends StatelessWidget {
  const _ItineraryWidget({
    required this.itinerary,
  });

  final ItineraryModel itinerary;

  @override
  Widget build(BuildContext context) {
    /// The formatted date to display.
    final formattedDate = DateFormat('dd MMM').format(DateTime.parse(itinerary.startDate)).toUpperCase();
    final formattedEndDate = DateFormat('dd MMM').format(DateTime.parse(itinerary.endDate)).toUpperCase();
    final startDateHour = DateFormat('hh:mm a').format(DateTime.parse(itinerary.startDate));
    final endDateHour = DateFormat('hh:mm a').format(DateTime.parse(itinerary.endDate));

    /// The formatted day to display.
    final formattedDay = DateFormat('EEEE').format(DateTime.parse(itinerary.endDate)).toUpperCase();

    return TAContainer(
      padding: EdgeInsets.zero,
      child: ExpandablePanel(
        collapsed: const SizedBox(),
        theme: const ExpandableThemeData(hasIcon: false),
        header: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                itinerary.transportation == 'Airport' ? Iconsax.airplane5 : Iconsax.bus5,
                color: TAColors.purple,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TATypography.paragraph(
                    text: itinerary.name,
                    fontWeight: FontWeight.w600,
                  ),
                  TATypography.paragraph(
                    text: itinerary.transportation,
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
                    text: formattedDay,
                    color: TAColors.grey1,
                  ),
                  TATypography.paragraph(
                    text: formattedDate,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TATypography.subparagraph(
                                text: 'FROM',
                                color: TAColors.grey1,
                              ),
                              TATypography.paragraph(
                                text: formattedDate,
                                fontWeight: FontWeight.w600,
                              ),
                              TATypography.paragraph(
                                text: startDateHour,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TATypography.subparagraph(
                                text: 'TO',
                                color: TAColors.grey1,
                              ),
                              TATypography.paragraph(
                                text: formattedEndDate,
                                fontWeight: FontWeight.w600,
                              ),
                              TATypography.paragraph(
                                text: endDateHour,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              text: '3700 W Flamingo Rd, Las Vegas, NV 89103',
                              color: TAColors.grey1,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          openLink('https://www.google.com/maps/place/?q=place_id:${itinerary.location}');
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     const Icon(Iconsax.user_tag),
                  //     const SizedBox(width: 8),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           TATypography.subparagraph(
                  //             text: 'Meeting',
                  //             color: TAColors.grey1,
                  //           ),
                  //           TATypography.paragraph(
                  //             text: 'Doral Campus Academy',
                  //             fontWeight: FontWeight.w600,
                  //           ),
                  //           TATypography.paragraph(
                  //             text: '9025 W Cactus Ave, Las Vegas, NV 89178',
                  //             color: TAColors.grey1,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border: Border.all(
                  //           color: TAColors.purple,
                  //         ),
                  //       ),
                  //       padding: const EdgeInsets.all(6),
                  //       child: const Icon(
                  //         Iconsax.location,
                  //         color: TAColors.purple,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
