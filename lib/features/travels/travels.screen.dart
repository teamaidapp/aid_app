import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/enums/role.enum.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/travels/controllers/travels.controller.dart';
import 'package:team_aid/features/travels/screens/files.screen.dart';
import 'package:team_aid/features/travels/screens/hotel.screen.dart';
import 'package:team_aid/features/travels/screens/itinerary.screen.dart';
import 'package:team_aid/features/travels/screens/meeting.screen.dart';
import 'package:team_aid/main.dart';

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
      ref.read(travelsControllerProvider.notifier).getHotels();
      ref.read(travelsControllerProvider.notifier).getCalendarData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    final formPageController = usePageController();
    final teams = ref.read(homeControllerProvider).userTeams;
    final prefs = ref.watch(sharedPrefs);

    return teams.when(
      data: (teamData) {
        return Scaffold(
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
                  if (teamData.isNotEmpty) {
                    selectedIndex.value = index;
                    formPageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  }
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
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.document),
                    label: 'Files',
                  ),
                ],
              ),
            ),
          ),
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
                child: prefs.when(
                  data: (prefs) {
                    final role = prefs.getString(TAConstants.role);
                    debugPrint(role);
                    if (teamData.isNotEmpty || role == Role.coach.name) {
                      return Column(
                        children: [
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
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: TATypography.paragraph(
                            text: 'You need to be part of a team to access this feature.',
                            color: TAColors.purple,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }
                  },
                  error: (e, s) {
                    return const SizedBox();
                  },
                  loading: () {
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        );
      },
      error: (_, __) {
        return const SizedBox();
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(
            color: TAColors.purple,
          ),
        );
      },
    );
  }
}
