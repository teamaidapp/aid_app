import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/enums/role.enum.dart';
import 'package:team_aid/core/extensions.dart';
import 'package:team_aid/core/functions.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/home/controllers/add_player.controller.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/home/entities/player.model.dart';
import 'package:team_aid/features/home/widgets/player_card.widget.dart';
import 'package:team_aid/features/home/widgets/search_form.widget.dart';

/// The statelessWidget that handles the current screen
class AddPlayerScreen extends HookWidget {
  /// The constructor.
  const AddPlayerScreen({
    required this.isPlayer,
    super.key,
  });

  /// If the current flow is adding a player or a coach.
  final bool isPlayer;

  @override
  Widget build(BuildContext context) {
    final addPlayerScreen = useState(true);
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
                      text: isPlayer ? 'Players' : 'Coaches',
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
          const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: 120,
          //       child: GestureDetector(
          //         key: const Key('add_player'),
          //         onTap: () {
          //           addPlayerScreen.value = true;
          //         },
          //         child: Container(
          //           height: 50,
          //           decoration: BoxDecoration(
          //             color: addPlayerScreen.value ? const Color(0xffF5F8FB) : Colors.white,
          //             borderRadius: const BorderRadius.only(
          //               topRight: Radius.circular(20),
          //               topLeft: Radius.circular(20),
          //             ),
          //           ),
          //           padding: const EdgeInsets.symmetric(horizontal: 6),
          //           child: Center(
          //             child: TATypography.paragraph(
          //               text: isPlayer ? 'Add Player' : 'Add Coach',
          //               key: const Key('add_player_title'),
          //               color: addPlayerScreen.value ? TAColors.textColor : const Color(0x0D253C4D).withOpacity(0.3),
          //               fontWeight: FontWeight.w700,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 10),
          //     SizedBox(
          //       width: 150,
          //       child: GestureDetector(
          //         key: const Key('search_player'),
          //         onTap: () {
          //           addPlayerScreen.value = false;
          //         },
          //         child: Container(
          //           height: 50,
          //           padding: const EdgeInsets.symmetric(horizontal: 10),
          //           decoration: BoxDecoration(
          //             color: !addPlayerScreen.value ? const Color(0xffF5F8FB) : Colors.transparent,
          //             borderRadius: const BorderRadius.only(
          //               topRight: Radius.circular(20),
          //               topLeft: Radius.circular(20),
          //             ),
          //           ),
          //           child: Center(
          //             child: TATypography.paragraph(
          //               text: isPlayer ? 'Search Player' : 'Search Coach',
          //               color: !addPlayerScreen.value ? TAColors.textColor : const Color(0x0D253C4D).withOpacity(0.3),
          //               fontWeight: FontWeight.w700,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
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
              child: SingleChildScrollView(
                child: addPlayerScreen.value
                    ? _AddPlayerWidget(
                        isPlayer: isPlayer,
                      )
                    : const _SearchPlayerWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddPlayerWidget extends HookConsumerWidget {
  const _AddPlayerWidget({required this.isPlayer});

  final bool isPlayer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamId = useState('');
    final makeAdmin = useState(false);
    final isLoading = useState(false);
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final teams = ref.watch(homeControllerProvider).userTeams;
    return Column(
      children: [
        TAContainer(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
          ),
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 30,
          ),
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
                    teamId.value = selectedValue.id;
                  }
                },
              );
            },
            error: (e, s) => const SizedBox(),
            loading: () => const SizedBox(),
          ),
        ),
        TAContainer(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TAPrimaryInput(
                label: 'E-mail',
                textEditingController: emailController,
                placeholder: 'Enter the email',
              ),
              const SizedBox(height: 10),
              TAPrimaryInput(
                label: 'Phone',
                textEditingController: phoneController,
                placeholder: 'Enter the phone number',
                inputListFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12),
                  PhoneInputFormatter(defaultCountryCode: 'US'),
                ],
              ),
              const SizedBox(height: 20),
              if (!isPlayer)
                Row(
                  children: [
                    Switch.adaptive(
                      value: makeAdmin.value,
                      activeColor: const Color(0xff586DF4),
                      onChanged: (v) {
                        makeAdmin.value = v;
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TATypography.subparagraph(
                        text: 'Make an administator',
                        color: TAColors.grey1,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TAPrimaryButton(
            text: 'ADD',
            height: 50,
            isLoading: isLoading.value,
            mainAxisAlignment: MainAxisAlignment.center,
            onTap: () async {
              if (teamId.value.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select the team'),
                  ),
                );
                return;
              }
              if (emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill the email'),
                  ),
                );
                return;
              }

              if (phoneController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill the phone number'),
                  ),
                );
                return;
              }

              if (!isValidEmail(emailController.text.trim())) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a valid email'),
                  ),
                );
              }

              // if (!isValidPhoneNumber(phoneController.text.trim())) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //       content: Text('Please enter a valid phone number'),
              //     ),
              //   );
              //   return;
              // }
              isLoading.value = true;
              final res = await ref.read(addPlayerControllerProvider.notifier).sendPlayerInvitation(
                    email: emailController.text,
                    phone: phoneController.text.replaceAll('(', '').replaceAll(')', ''),
                    teamId: teamId.value,
                    role: isPlayer ? Role.player.name : Role.coach.name,
                  );
              isLoading.value = false;
              if (res.ok && context.mounted) {
                await SuccessWidget.build(
                  title: 'Success',
                  message: 'Your invitation has been sent successfully.',
                  context: context,
                );
                if (context.mounted) {
                  Navigator.pop(context);
                }
              } else {
                unawaited(
                  FailureWidget.build(
                    title: 'Error',
                    message: res.message,
                    context: context,
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {
            context.push(AppRoutes.teams);
          },
          child: TATypography.paragraph(
            text: 'Go to teams',
            underline: true,
            color: TAColors.textColor,
          ),
        ),
      ],
    );
  }
}

class _SearchPlayerWidget extends HookConsumerWidget {
  const _SearchPlayerWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showForm = useState(true);
    final teamId = useState('');
    final players = ref.watch(addPlayerControllerProvider).listOfPlayers;

    if (showForm.value) {
      return SearchFormWidget(
        teamId: teamId,
        showForm: showForm,
      );
    } else {
      return PlayersSearchWidget(
        players: players,
        showForm: showForm,
        teamId: teamId,
      );
    }
  }
}

/// The PlayersSearchWidget class is a hook widget in Dart.
class PlayersSearchWidget extends HookWidget {
  /// Calls the constructor of the superclass with the given key.
  const PlayersSearchWidget({
    required this.teamId,
    required this.players,
    required this.showForm,
    super.key,
  });

  /// The asynchronous value of a list of [PlayerModel] objects.
  final AsyncValue<List<PlayerModel>> players;

  /// A [ValueNotifier] that controls whether to show the form or not.
  final ValueNotifier<bool> showForm;

  /// A [ValueNotifier] that controls the team id.
  final ValueNotifier<String> teamId;

  @override
  Widget build(BuildContext context) {
    final showPlayerInfo = useState(false);
    final playerInfo = useState(PlayerModel.initDefault());
    if (showPlayerInfo.value) {
      return TAContainer(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      playerInfo.value.avatar.isEmpty ? 'https://placehold.co/400x200/png' : playerInfo.value.avatar,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TATypography.paragraph(
                    text: playerInfo.value.firstName,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      TATypography.paragraph(
                        text: 'Sport',
                        fontWeight: FontWeight.w600,
                        color: TAColors.color1,
                      ),
                      const SizedBox(width: 10),
                      TATypography.paragraph(
                        text: playerInfo.value.userHasSports.fold<String>('', (previousValue, element) => '$previousValue${element.sportsId.name} '),
                        color: TAColors.color1,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TATypography.paragraph(
                        text: 'Level',
                        fontWeight: FontWeight.w600,
                        color: TAColors.color1,
                      ),
                      const SizedBox(width: 10),
                      TATypography.paragraph(
                        text: playerInfo.value.role.capitalize(),
                        color: TAColors.color1,
                      ),
                    ],
                  ),
                  if (playerInfo.value.address.isNotEmpty)
                    Row(
                      children: [
                        TATypography.paragraph(
                          text: 'Addresss',
                          fontWeight: FontWeight.w600,
                          color: TAColors.color1,
                        ),
                        const SizedBox(width: 10),
                        TATypography.paragraph(
                          text: playerInfo.value.address,
                          color: TAColors.color1,
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            showForm.value = true;
                          },
                          child: TATypography.paragraph(
                            text: 'Cancel',
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
                              padding: EdgeInsets.zero,
                              child: TAPrimaryButton(
                                text: 'SEND INVITATION',
                                height: 50,
                                isLoading: isLoading.value,
                                mainAxisAlignment: MainAxisAlignment.center,
                                onTap: () async {
                                  if (playerInfo.value.email.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Can't send the invitation because user has the email private"),
                                      ),
                                    );
                                    return;
                                  }
                                  isLoading.value = true;
                                  final res = await ref.read(addPlayerControllerProvider.notifier).sendPlayerInvitation(
                                        email: playerInfo.value.email,
                                        phone: playerInfo.value.phoneNumber,
                                        teamId: teamId.value,
                                        role: Role.player.name,
                                      );
                                  isLoading.value = false;
                                  if (res.ok && context.mounted) {
                                    await SuccessWidget.build(
                                      title: 'Success',
                                      message: 'Your invitation has been sent successfully.',
                                      context: context,
                                    );
                                    if (context.mounted) {
                                      context.go(AppRoutes.home);
                                    }
                                  } else {
                                    unawaited(
                                      FailureWidget.build(
                                        title: 'Error',
                                        message: res.message,
                                        context: context,
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 72.h,
            child: players.when(
              data: (data) {
                if (data.isEmpty) {
                  return Center(
                    child: TATypography.paragraph(
                      text: 'No players found',
                      color: TAColors.color1,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                } else {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return PlayerCard(
                        onTap: () {
                          showPlayerInfo.value = true;
                          playerInfo.value = data[index];
                        },
                        player: data[index],
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TAPrimaryButton(
              text: 'NEW SEARCH',
              height: 50,
              mainAxisAlignment: MainAxisAlignment.center,
              onTap: () {
                showForm.value = true;
              },
            ),
          ),
        ],
      );
    }
  }
}
