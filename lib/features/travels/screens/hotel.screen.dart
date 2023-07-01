import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/design_system/components/inputs/dropdown_input.dart';
import 'package:team_aid/design_system/components/inputs/multi_dropdown.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/calendar/entities/hour.model.dart';
import 'package:team_aid/features/common/functions/global_functions.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/travels/controllers/travels.controller.dart';
import 'package:team_aid/features/travels/entities/hotel.model.dart';

/// The statelessWidget that handles the current screen
class HotelTravelScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const HotelTravelScreen({
    required this.pageController,
    super.key,
  });

  /// The page controller
  final PageController pageController;
  @override
  ConsumerState<HotelTravelScreen> createState() => _HotelTravelScreenState();
}

class _HotelTravelScreenState extends ConsumerState<HotelTravelScreen> {
  final hours = <HourModel>[];
  final days = <DateTime>[];
  final months = <String>[];
  final years = <String>[];
  final currentDay = DateTime.now().day;
  var _currentSelectedMonth = DateTime.now().month;
  var _currentSelectedYear = DateTime.now().year;

  late DateTime _fromDate;
  late DateTime _toDate;
  @override
  void initState() {
    hours.addAll(GlobalFunctions.generateHourModels());
    days.addAll(
      GlobalFunctions.getDaysInMonth(
        year: _currentSelectedYear,
        month: _currentSelectedMonth,
      ),
    );
    months.addAll(
      ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    );
    years.addAll(
      ['2023', '2024', '2025', '2026', '2027'],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final teamId = useState('');
    final isLoading = useState(false);
    final name = useTextEditingController();
    final reservationController = useTextEditingController();
    final teams = ref.watch(homeControllerProvider).userTeams;
    final guests = ref.watch(travelsControllerProvider).contactList;
    final selectedGuests = useState(<TADropdownModel>[]);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TAContainer(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
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
          const SizedBox(height: 10),
          TAContainer(
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Iconsax.note_215,
                      size: 20,
                      color: TAColors.purple,
                    ),
                    const SizedBox(width: 10),
                    TATypography.h3(text: 'Add a hotel'),
                  ],
                ),
                const SizedBox(height: 20),
                TAPrimaryInput(
                  label: 'Name',
                  textEditingController: name,
                  placeholder: '',
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TADropdown(
                        label: 'Day',
                        selectedValue: TADropdownModel(
                          item: currentDay.toString(),
                          id: currentDay.toString(),
                        ),
                        items: List.generate(
                          days.length,
                          (index) {
                            final item = days[index];
                            return TADropdownModel(
                              item: item.day.toString(),
                              id: item.day.toString(),
                            );
                          },
                        ),
                        placeholder: '',
                        onChange: (v) {
                          _fromDate = DateTime(
                            _currentSelectedYear,
                            _currentSelectedMonth,
                            currentDay,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TADropdown(
                        label: 'Month',
                        selectedValue: TADropdownModel(
                          item: _currentSelectedMonth.toString(),
                          id: _currentSelectedMonth.toString(),
                        ),
                        items: List.generate(
                          months.length,
                          (index) {
                            final item = months[index];
                            return TADropdownModel(
                              item: item,
                              id: item,
                            );
                          },
                        ),
                        placeholder: '',
                        onChange: (v) {
                          if (v != null) {
                            setState(() {
                              _currentSelectedMonth = int.parse(v.id);

                              _fromDate = DateTime(
                                _currentSelectedYear,
                                _currentSelectedMonth,
                                currentDay,
                              );

                              days
                                ..clear()
                                ..addAll(
                                  GlobalFunctions.getDaysInMonth(
                                    month: _currentSelectedMonth,
                                    year: _currentSelectedYear,
                                  ),
                                );
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TADropdown(
                        label: 'Year',
                        selectedValue: TADropdownModel(
                          item: _currentSelectedYear.toString(),
                          id: _currentSelectedYear.toString(),
                        ),
                        items: List.generate(
                          years.length,
                          (index) {
                            final item = years[index];
                            return TADropdownModel(
                              item: item,
                              id: item,
                            );
                          },
                        ),
                        placeholder: '',
                        onChange: (v) {
                          if (v != null) {
                            setState(() {
                              _fromDate = DateTime(
                                _currentSelectedYear,
                                _currentSelectedMonth,
                                currentDay,
                              );
                              _currentSelectedYear = int.parse(v.id);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TADropdown(
                        label: 'From',
                        items: List.generate(
                          hours.length,
                          (index) {
                            final item = hours[index];
                            return TADropdownModel(
                              item: item.description,
                              id: 'hour:${item.hour}minute:${item.minute}',
                            );
                          },
                        ),
                        placeholder: '',
                        onChange: (v) {
                          if (v != null) {
                            setState(() {
                              _fromDate = DateTime(
                                _currentSelectedYear,
                                _currentSelectedMonth,
                                currentDay,
                                int.parse(
                                  v.id.split('hour:')[1].split('minute:')[0],
                                ),
                                int.parse(
                                  v.id.split('hour:')[1].split('minute:')[1],
                                ),
                              );
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TADropdown(
                        label: 'To',
                        items: List.generate(
                          hours.length,
                          (index) {
                            final item = hours[index];
                            return TADropdownModel(
                              item: item.description,
                              id: 'hour:${item.hour}minute:${item.minute}',
                            );
                          },
                        ),
                        placeholder: '',
                        onChange: (v) {
                          if (v != null) {
                            setState(() {
                              _toDate = DateTime(
                                _currentSelectedYear,
                                _currentSelectedMonth,
                                currentDay,
                                int.parse(
                                  v.id.split('hour:')[1].split('minute:')[0],
                                ),
                                int.parse(
                                  v.id.split('hour:')[1].split('minute:')[1],
                                ),
                              );
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TAPrimaryInput(
                  placeholder: '',
                  textEditingController: reservationController,
                  label: 'Reservation Code',
                ),
                const SizedBox(height: 10),
                TAMultiDropdown(
                  label: 'Guests',
                  items: List.generate(
                    guests.valueOrNull?.length ?? 0,
                    (index) {
                      final item = guests.valueOrNull?[index];
                      return TADropdownModel(
                        item: item != null ? item.user.firstName : '',
                        id: item != null ? item.id : '',
                      );
                    },
                  ),
                  placeholder: '',
                  onChange: (v) {
                    selectedGuests.value = v;
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: TATypography.paragraph(
                        text: 'Cancel',
                        underline: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: Consumer(
                        builder: (context, ref, child) {
                          return TAPrimaryButton(
                            text: 'CREATE',
                            isLoading: isLoading.value,
                            mainAxisAlignment: MainAxisAlignment.center,
                            onTap: () async {
                              if (name.text.isEmpty) {
                                unawaited(
                                  FailureWidget.build(
                                    title: 'Something went wrong!',
                                    message: 'Please enter event name to continue.',
                                    context: context,
                                  ),
                                );
                                return;
                              }
                              final newGuests = <Guest>[];

                              for (final guest in selectedGuests.value) {
                                newGuests.add(Guest(userId: guest.id));
                              }

                              isLoading.value = true;
                              final hotel = HotelModel(
                                place: name.text.trim(),
                                startDate: _fromDate.toIso8601String(),
                                endDate: _toDate.toIso8601String(),
                                reservationCode: reservationController.text.trim(),
                                guests: newGuests,
                              );
                              inspect(hotel);
                              final res = await ref.read(travelsControllerProvider.notifier).addHotel(hotel: hotel);
                              isLoading.value = false;

                              if (res.ok && mounted) {
                                unawaited(
                                  SuccessWidget.build(
                                    title: 'Success!',
                                    message: 'Event has been added successfully.',
                                    context: context,
                                  ),
                                );
                                if (!mounted) return;
                                Navigator.pop(context);
                              } else {
                                unawaited(
                                  FailureWidget.build(
                                    title: 'Something went wrong!',
                                    message: 'There was an error adding the event.',
                                    context: context,
                                  ),
                                );
                              }
                            },
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
  }
}
