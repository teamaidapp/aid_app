import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';

/// The statelessWidget that handles the current screen
class JoinTeamScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const JoinTeamScreen({super.key});

  @override
  ConsumerState<JoinTeamScreen> createState() => _JoinTeamScreenState();
}

class _JoinTeamScreenState extends ConsumerState<JoinTeamScreen> {
  @override
  void initState() {
    ref.read(homeControllerProvider.notifier).getAllTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final teams = ref.watch(homeControllerProvider).allTeams;
    final selectedTeamId = useState('');
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
                      text: 'Join Team',
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
              child: Column(
                children: [
                  TAContainer(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: teams.when(
                      data: (data) {
                        return TADropdown(
                          label: 'Team',
                          placeholder: 'Select a team',
                          items: List.generate(
                            data.length,
                            (index) => TADropdownModel(
                              item: data[index].teamName,
                              id: data[index].id,
                            ),
                          ),
                          onChange: (selectedValue) {
                            if (selectedValue != null) {
                              selectedTeamId.value = selectedValue.id;
                            }
                          },
                        );
                      },
                      error: (e, s) => const SizedBox(),
                      loading: () => const SizedBox(),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 40,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              context.go(AppRoutes.home);
                            },
                            child: TATypography.paragraph(
                              text: 'Skip',
                              underline: true,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: HookConsumer(
                            builder: (context, ref, child) {
                              final isLoading = useState(false);
                              return Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: TAPrimaryButton(
                                  text: 'JOIN TEAM',
                                  height: 50,
                                  isLoading: isLoading.value,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  onTap: () async {
                                    if (selectedTeamId.value.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please select the team'),
                                        ),
                                      );
                                      return;
                                    }

                                    /// TODO: Send request to backend
                                    context.go(AppRoutes.home);
                                  },
                                ),
                              );
                            },
                          ),
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
