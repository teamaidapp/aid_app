import 'dart:async';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/design_system/components/inputs/dropdown_input.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/home/controllers/add_player.controller.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/home/entities/player.model.dart';

/// The statelessWidget that handles the current screen
class AddPlayerScreen extends HookWidget {
  /// The constructor.
  const AddPlayerScreen({super.key});

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
                      text: 'Add Player',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: GestureDetector(
                  key: const Key('add_player'),
                  onTap: () {
                    addPlayerScreen.value = true;
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: addPlayerScreen.value
                          ? const Color(0xffF5F8FB)
                          : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: TATypography.paragraph(
                        text: 'Add Player',
                        key: const Key('add_player_title'),
                        color: addPlayerScreen.value
                            ? TAColors.textColor
                            : const Color(0x0D253C4D).withOpacity(0.3),
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
                    addPlayerScreen.value = false;
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: !addPlayerScreen.value
                          ? const Color(0xffF5F8FB)
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: TATypography.paragraph(
                        text: 'Search Player',
                        color: !addPlayerScreen.value
                            ? TAColors.textColor
                            : const Color(0x0D253C4D).withOpacity(0.3),
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
              child: SingleChildScrollView(
                child: addPlayerScreen.value
                    ? const _AddPlayerWidget()
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
  const _AddPlayerWidget();

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
                placeholder: 'Enter the team',
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
              ),
              const SizedBox(height: 20),
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
                      color: const Color(0xff999999),
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
              isLoading.value = true;
              final res = await ref
                  .read(addPlayerControllerProvider.notifier)
                  .sendPlayerInvitation(
                    email: emailController.text,
                    phone: phoneController.text,
                    teamId: teamId.value,
                    isCoach: makeAdmin.value,
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
        TATypography.paragraph(
          text: 'Go to teams',
          underline: true,
          color: TAColors.textColor,
        ),
      ],
    );
  }
}

class _SearchPlayerWidget extends HookConsumerWidget {
  const _SearchPlayerWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sportController = useState('');
    final levelController = useState('');
    final positionController = useState('');
    final nameController = useTextEditingController();
    final cityState = useState('');
    final currentSelectedState = useState('');
    final isLoading = useState(false);
    final showForm = useState(true);

    final players = ref.watch(addPlayerControllerProvider).listOfPlayers;

    if (showForm.value) {
      return Column(
        children: [
          // TAContainer(
          //   margin: const EdgeInsets.only(
          //     left: 20,
          //     right: 20,
          //     top: 30,
          //   ),
          //   padding: const EdgeInsets.only(
          //     top: 20,
          //     left: 20,
          //     right: 20,
          //     bottom: 30,
          //   ),
          //   child: TADropdown(
          //     label: 'Team',
          //     placeholder: 'Enter the team',
          //     items: [
          //       TADropdownModel(item: 'One', id: ''),
          //     ],
          //     onChange: (selectedValue) {},
          //   ),
          // ),
          TAContainer(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 6),
                  child: TATypography.paragraph(
                    text: 'Search by any option',
                    fontWeight: FontWeight.w600,
                    color: TAColors.textColor,
                  ),
                ),
                const SizedBox(height: 10),
                TAPrimaryInput(
                  label: 'Name',
                  placeholder: 'Search by name',
                  textEditingController: nameController,
                ),
                const SizedBox(height: 10),
                TADropdown(
                  label: 'Sport',
                  placeholder: 'Select the sport',
                  items: [
                    TADropdownModel(
                      item: 'Cheerleading',
                      id: '',
                    )
                  ],
                  onChange: (selectedValue) {
                    if (selectedValue != null) {
                      sportController.value = selectedValue.item;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TADropdown(
                  label: 'Level',
                  placeholder: 'Select a level',
                  items: [
                    TADropdownModel(
                      item: 'Elite',
                      id: '',
                    ),
                    TADropdownModel(
                      item: 'Amateur',
                      id: '',
                    )
                  ],
                  onChange: (selectedValue) {},
                ),
                const SizedBox(height: 20),
                TADropdown(
                  label: 'Position',
                  placeholder: 'Select a position',
                  items: [
                    TADropdownModel(item: 'One', id: ''),
                  ],
                  onChange: (selectedValue) {},
                ),
                const SizedBox(height: 20),
                TADropdown(
                  label: 'State',
                  placeholder: 'Select a state',
                  items: List.generate(
                    TAConstants.statesList.length,
                    (index) => TADropdownModel(
                      item: TAConstants.statesList[index].name,
                      id: TAConstants.statesList[index].id,
                    ),
                  ),
                  onChange: (selectedValue) {
                    if (selectedValue != null) {
                      debugPrint(selectedValue.id);
                      currentSelectedState.value = selectedValue.id;
                    }
                  },
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TATypography.paragraph(
                      text: 'City',
                      fontWeight: FontWeight.w500,
                      color: TAColors.color1,
                    ),
                    SizedBox(height: 0.5.h),
                    DropdownSearch<TADropdownModel>(
                      asyncItems: (filter) async {
                        final response = await http.get(
                          Uri.parse(
                            '${dotenv.env['API_URL']}/cities/cities/${currentSelectedState.value}',
                          ),
                        );

                        if (response.statusCode == 200) {
                          final data = (jsonDecode(response.body)
                              as Map)['data'] as List;
                          return data.map((e) {
                            final taDropdownModel = TADropdownModel(
                              item: (e as Map)['name'] as String,
                              id: e['id'] as String,
                            );
                            return taDropdownModel;
                          }).toList();
                        } else {
                          return [];
                        }
                      },
                      onChanged: (value) {
                        if (value != null) {
                          cityState.value = value.id;
                        }
                      },
                      itemAsString: (item) => item.item,
                      dropdownButtonProps: const DropdownButtonProps(
                        icon: Icon(
                          Iconsax.arrow_down_1,
                          size: 14,
                          color: Colors.black,
                        ),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        baseStyle: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: TAColors.color2,
                        ),
                        dropdownSearchDecoration: InputDecoration(
                          hintText: 'Select a city',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: TAColors.color1.withOpacity(0.5),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: TAColors.color1.withOpacity(0.5),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: TAColors.color1,
                            ),
                          ),
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: TAColors.color2,
                          ),
                        ),
                      ),
                      popupProps: PopupProps.menu(
                        fit: FlexFit.loose,
                        constraints: const BoxConstraints.tightFor(),
                        menuProps: MenuProps(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                // TADropdown(
                //   label: 'City',
                //   textEditingController: cityController,
                //   placeholder: 'Select a city',
                //   items: [
                //     TADropdownModel(item: 'One', id: ''),
                //   ],
                //   onChange: (selectedValue) {},
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 80),
          Consumer(
            builder: (context, ref, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TAPrimaryButton(
                  text: 'SEARCH',
                  height: 50,
                  isLoading: isLoading.value,
                  mainAxisAlignment: MainAxisAlignment.center,
                  onTap: () async {
                    isLoading.value = true;
                    final res = await ref
                        .read(addPlayerControllerProvider.notifier)
                        .searchPlayer(
                          name: nameController.text,
                          level: levelController.value,
                          position: positionController.value,
                          state: currentSelectedState.value,
                          city: cityState.value,
                          sport: sportController.value,
                          page: 1,
                        );
                    isLoading.value = false;
                    if (res.ok && context.mounted) {
                      // showForm.value = false;
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
        ],
      );
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return PlayerCard(
            onTap: () {},
            player: players.value![index],
          );
        },
      );
    }
  }
}

/// The PlayerCard class is a stateless widget that displays a player's avatar, first name, and role,
/// and can be tapped to trigger a callback function.
class PlayerCard extends StatelessWidget {
  /// Constructor
  const PlayerCard({
    required this.player,
    required this.onTap,
    super.key,
  });

  /// Player model
  final PlayerModel player;

  /// On tap callback
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TAContainer(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    player.avatar ?? 'https://picsum.photos/200',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TATypography.paragraph(
                    text: player.firstName,
                    fontWeight: FontWeight.w500,
                    color: TAColors.color1,
                  ),
                  const SizedBox(height: 5),
                  TATypography.paragraph(
                    text: player.role,
                    fontWeight: FontWeight.w500,
                    color: TAColors.color1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
