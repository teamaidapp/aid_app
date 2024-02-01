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
import 'package:team_aid/features/travels-legacy/screens/view_file-legacy.screen.dart';
import 'package:team_aid/features/travels/controllers/travels.controller.dart';
import 'package:team_aid/features/travels/entities/travel.model.dart';
import 'package:team_aid/features/travels/entities/travel_api.model.dart';
import 'package:team_aid/features/travels/screens/files.screen.dart';
import 'package:team_aid/features/travels/screens/hotel.screen.dart';
import 'package:team_aid/features/travels/screens/travel.screen.dart';

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
    super.initState();
    ref.read(travelsControllerProvider.notifier).getTravels();
  }

  @override
  Widget build(BuildContext context) {
    // final formattedDate = DateFormat('dd / MMM').format(DateTime.now()).toUpperCase();
    // final formattedDay = DateFormat('EEEE').format(DateTime.now()).toUpperCase();
    final selectedIndex = useState(0);
    final formPageController = usePageController();
    final showTravels = useState(true);

    ref.watch(travelsControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
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
          child: !showTravels.value
              ? BottomNavigationBar(
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
                    // if (teamData.isNotEmpty) {
                    selectedIndex.value = index;
                    formPageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                    // }
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.bus),
                      label: 'Travel',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.building_4),
                      label: 'Hotel',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Iconsax.document),
                      label: 'Files',
                    ),
                  ],
                )
              : null,
        ),
      ),
      body: _TravelScreen(
        pageController: formPageController,
        showTravels: showTravels,
      ),
    );
  }
}

class _TravelScreen extends HookConsumerWidget {
  const _TravelScreen({
    required this.pageController,
    required this.showTravels,
  });

  final PageController pageController;

  final ValueNotifier<bool> showTravels;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedDate = DateFormat('dd / MMM').format(DateTime.now()).toUpperCase();
    final formattedDay = DateFormat('EEEE').format(DateTime.now()).toUpperCase();
    final travels = ref.watch(travelsControllerProvider).travels;
    return Column(
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
            child: showTravels.value
                ? Column(
                    children: [
                      const SizedBox(height: 20),
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
                                text: !showTravels.value ? 'BACK' : 'NEW TRAVEL',
                                mainAxisAlignment: Device.screenType == ScreenType.tablet ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                icon: !showTravels.value ? null : Iconsax.add,
                                onTap: () {
                                  if (showTravels.value) {
                                    showTravels.value = false;
                                  } else {
                                    showTravels.value = true;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: travels.when(
                          data: (data) {
                            if (data.isEmpty) {
                              return Center(
                                child: TATypography.paragraph(
                                  text: 'No travels added yet',
                                  color: TAColors.purple,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: data.length,
                                padding: const EdgeInsets.all(20),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      _TravelModelWidget(
                                        travelModel: data[index],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                },
                              );
                            }
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
                  )
                : Column(
                    children: [
                      const SizedBox(height: 20),
                      Expanded(
                        child: PageView(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            TravelScreen(pageController: pageController),
                            HotelTravelScreen(
                              pageController: pageController,
                            ),
                            const FilesScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class _TravelModelWidget extends StatelessWidget {
  const _TravelModelWidget({
    required this.travelModel,
  });

  final TravelAPIModel travelModel;

  @override
  Widget build(BuildContext context) {
    /// The formatted date to display.
    final formattedDate = DateFormat('dd MMM').format(DateTime.parse(travelModel.itineraryId.startDate)).toUpperCase();
    final formattedEndDate = DateFormat('dd MMM').format(DateTime.parse(travelModel.itineraryId.endDate)).toUpperCase();
    final startDateHour = DateFormat('hh:mm a').format(DateTime.parse(travelModel.itineraryId.startDate));
    final endDateHour = DateFormat('hh:mm a').format(DateTime.parse(travelModel.itineraryId.endDate));

    /// The formatted day to display.
    final formattedDay = DateFormat('EE').format(DateTime.parse(travelModel.itineraryId.endDate)).toUpperCase();

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
                travelModel.itineraryId.transportation == 'Airplane' ? Iconsax.airplane5 : Iconsax.bus5,
                color: TAColors.purple,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TATypography.paragraph(
                      text: travelModel.itineraryId.name,
                      fontWeight: FontWeight.w600,
                    ),
                    TATypography.paragraph(
                      text: travelModel.itineraryId.transportation,
                      color: TAColors.grey1,
                    ),
                  ],
                ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(travelModel.itineraryId.transportation == 'Airplane' ? Iconsax.airplane5 : Iconsax.bus),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TATypography.subparagraph(
                                text: 'Start',
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
                      Row(
                        children: [
                          Icon(travelModel.itineraryId.transportation == 'Airplane' ? Iconsax.airplane5 : Iconsax.bus),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TATypography.subparagraph(
                                text: 'End',
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
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: Colors.white,
                            // barrierColor: Colors.white.withOpacity(0.8),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            builder: (context) {
                              return Wrap(
                                children: [
                                  SafeArea(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Stack(
                                        children: [
                                          Wrap(
                                            children: [
                                              Align(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    TATypography.h3(
                                                      text: 'Attachments',
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                    SizedBox(height: 2.h),
                                                    TATypography.paragraph(
                                                      text: 'Tap to see the attachments of this travel',
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(height: 2.h),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 120,
                                                child: ListView.builder(
                                                  itemCount: travelModel.files.length,
                                                  itemBuilder: (context, index) {
                                                    final fileName = travelModel.files[index].fileName.split('_');
                                                    return GestureDetector(
                                                      behavior: HitTestBehavior.translucent,
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                          MaterialPageRoute<void>(
                                                            builder: (context) => ViewFileScreen(
                                                              url: travelModel.files[index].fileKey,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Iconsax.document_upload,
                                                            size: 20,
                                                            color: TAColors.purple,
                                                          ),
                                                          const SizedBox(width: 8),
                                                          TATypography.paragraph(text: fileName[0] + fileName[1]),
                                                          const Spacer(),
                                                          TATypography.paragraph(
                                                            text: 'View',
                                                            underline: true,
                                                            fontWeight: FontWeight.w600,
                                                            color: TAColors.purple,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            right: 10,
                                            top: 20,
                                            child: GestureDetector(
                                              onTap: () {
                                                context.pop();
                                              },
                                              child: const Icon(Iconsax.close_circle, color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
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
                            Iconsax.attach_circle,
                            color: TAColors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     const Icon(Iconsax.people),
                  //     const SizedBox(width: 8),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           TATypography.subparagraph(
                  //             text: 'Assistants',
                  //             color: TAColors.grey1,
                  //           ),
                  //           ...List.generate(
                  //             travelModel.guests.length,
                  //             (index) {
                  //               return TATypography.paragraph(
                  //                 text: '${travelModel.guests[index].firstName} ${travelModel.guests[index].lastName}',
                  //                 fontWeight: FontWeight.w600,
                  //               );
                  //             },
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                              text: 'Location',
                              color: TAColors.grey1,
                            ),
                            TATypography.paragraph(
                              text: travelModel.itineraryId.locationDescription,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          openLink('https://www.google.com/maps/place/?q=place_id:${travelModel.itineraryId.location}');
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
                              text: travelModel.itineraryId.hotel,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          openLink('https://www.google.com/maps/place/?q=place_id:${travelModel.itineraryId.hotelGoogle}');
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
                  // const SizedBox(height: 20),
                  // if (travelModel.userCreator != null)
                  //   Column(
                  //     children: [
                  //       TATypography.paragraph(
                  //         text: 'Organized by ',
                  //         color: TAColors.grey1,
                  //       ),
                  //       TATypography.paragraph(
                  //         text: '${travelModel.userCreator!.firstName} ${travelModel.userCreator!.lastName}',
                  //         underline: true,
                  //         color: TAColors.grey1,
                  //       ),
                  //       const SizedBox(height: 10),
                  //     ],
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
