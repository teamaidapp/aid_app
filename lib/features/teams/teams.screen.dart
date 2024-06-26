import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/enums/role.enum.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/teams/widgets/invitations.widget.dart';
import 'package:team_aid/features/teams/widgets/team_card.widget.dart';
import 'package:team_aid/main.dart';

/// The statelessWidget that handles the current screen
class TeamsScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const TeamsScreen({super.key});

  @override
  ConsumerState<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends ConsumerState<TeamsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeControllerProvider.notifier).getUserTeams();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final teamsScreen = useState(true);
    final prefsProvider = ref.watch(sharedPrefs);
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
                      text: 'Teams',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: GestureDetector(
                  key: const Key('teams_player'),
                  onTap: () {
                    teamsScreen.value = true;
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: teamsScreen.value ? const Color(0xffF5F8FB) : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: TATypography.paragraph(
                        text: 'Teams',
                        key: const Key('add_player_title'),
                        color: teamsScreen.value ? TAColors.textColor : const Color(0x0D253C4D).withOpacity(0.3),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 150,
                child: GestureDetector(
                  key: const Key('search_player'),
                  onTap: () {
                    teamsScreen.value = false;
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: !teamsScreen.value ? const Color(0xffF5F8FB) : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: TATypography.paragraph(
                        text: 'Invitations',
                        color: !teamsScreen.value ? TAColors.textColor : const Color(0x0D253C4D).withOpacity(0.3),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              child: teamsScreen.value ? const TeamsListWidget() : const MyInvitationsWidget(),
            ),
          ),
          prefsProvider.when(
            data: (prefs) {
              final role = prefs.getString(TAConstants.role);
              if (role == Role.admin.name) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TAPrimaryButton(
                    text: 'ADD NEW TEAM',
                    mainAxisAlignment: MainAxisAlignment.center,
                    onTap: () {
                      context.push(AppRoutes.createAccountTeamForCoach);
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
            error: (_, __) {
              return const SizedBox();
            },
            loading: () {
              return const SizedBox();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

/// The TeamsListWidget is a Flutter widget that displays a list of teams based on data retrieved from a
/// home controller provider.
class TeamsListWidget extends ConsumerWidget {
  /// The constructor.
  const TeamsListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(homeControllerProvider).userTeams;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 30,
      ),
      child: teams.when(
        data: (data) {
          if (data.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: TATypography.paragraph(
                  text: 'Your teams will appear here once you create or join a team.',
                  color: TAColors.purple,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TeamCardWidget(
                    team: data[index],
                  ),
                );
              },
            );
          }
        },
        error: (error, stack) {
          return const SizedBox();
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
