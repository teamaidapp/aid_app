import 'dart:async';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/home/controllers/add_player.controller.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';

/// Renders the form for searching a player
class SearchFormWidget extends HookConsumerWidget {
  /// Construtor
  const SearchFormWidget({
    required this.showForm,
    required this.teamId,
    super.key,
  });

  /// The value notifier of showForm
  final ValueNotifier<bool> showForm;

  /// The team id shared on other widget
  final ValueNotifier<String> teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sportController = useState('');
    final levelController = useState('');
    final positionController = useState('');
    final nameController = useTextEditingController();
    final cityState = useState('');
    final currentSelectedState = useState('');
    final isLoading = useState(false);
    final teams = ref.watch(homeControllerProvider).userTeams;

    return Column(
      children: [
        teams.when(
          data: (data) {
            return TAContainer(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
              child: TADropdown(
                label: 'Team',
                placeholder: 'Select the team to join',
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
              ),
            );
          },
          error: (e, s) => const SizedBox(),
          loading: () => const SizedBox(),
        ),
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
                items: TAConstants.sportsList,
                onChange: (selectedValue) {
                  if (selectedValue != null) {
                    sportController.value = selectedValue.id;
                  }
                },
              ),
              // const SizedBox(height: 10),
              // TADropdown(
              //   label: 'Level',
              //   placeholder: 'Select a level',
              //   items: [
              //     TADropdownModel(
              //       item: 'Elite',
              //       id: '',
              //     ),
              //     TADropdownModel(
              //       item: 'Amateur',
              //       id: '',
              //     )
              //   ],
              //   onChange: (selectedValue) {},
              // ),
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
                        final data = (jsonDecode(response.body) as Map)['data'] as List;
                        final list = data.map((e) {
                          final taDropdownModel = TADropdownModel(
                            item: (e as Map)['name'] as String,
                            id: e['id'] as String,
                          );
                          return taDropdownModel;
                        }).toList()
                          ..sort((a, b) => a.item.compareTo(b.item));
                        return list;
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
                  if (teamId.value.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select the team'),
                      ),
                    );
                    return;
                  }

                  isLoading.value = true;
                  final res = await ref.read(addPlayerControllerProvider.notifier).searchPlayer(
                        name: nameController.text,
                        level: levelController.value,
                        position: positionController.value,
                        statePlayer: currentSelectedState.value,
                        city: cityState.value,
                        sport: sportController.value,
                        page: 1,
                      );
                  isLoading.value = false;
                  if (res.ok && context.mounted) {
                    showForm.value = false;
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
  }
}
