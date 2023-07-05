import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/design_system/components/inputs/dropdown_input.dart';
import 'package:team_aid/design_system/components/inputs/multi_dropdown.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/calendar/entities/hour.model.dart';
import 'package:team_aid/features/common/functions/global_functions.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/location.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/travels/controllers/travels.controller.dart';
import 'package:team_aid/features/travels/entities/itinerary.model.dart';

/// The statelessWidget that handles the current screen
class ItineraryTravelScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const ItineraryTravelScreen({
    required this.pageController,
    super.key,
  });

  /// The page controller
  final PageController pageController;

  @override
  ConsumerState<ItineraryTravelScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends ConsumerState<ItineraryTravelScreen> {
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
    final locationDescription = useState('');
    final isLoading = useState(false);
    final transportation = useState('');
    final eventName = useTextEditingController();
    final locationController = useTextEditingController();
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
                      ref.read(travelsControllerProvider.notifier).getContactList(teamId: teamId.value);
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
                    TATypography.h3(text: 'Add a itinerary'),
                  ],
                ),
                const SizedBox(height: 20),
                TAPrimaryInput(
                  label: 'Event Description',
                  textEditingController: eventName,
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
                LocationWidget(
                  onChanged: (v) {
                    if (v != null) {
                      locationController.text = v.id;
                      locationDescription.value = v.item;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TADropdown(
                  label: 'Transportation',
                  items: TAConstants.transportsList,
                  placeholder: '',
                  onChange: (v) {
                    if (v != null) {
                      transportation.value = v.id;
                    }
                  },
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
                // TAPrimaryInput(
                //   placeholder: '',
                //   textEditingController: guestController,
                //   label: 'Guest',
                // ),
                const SizedBox(height: 20),
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
                              if (eventName.text.isEmpty) {
                                unawaited(
                                  FailureWidget.build(
                                    title: 'Something went wrong!',
                                    message: 'Please enter event name to continue.',
                                    context: context,
                                  ),
                                );
                                return;
                              }
                              if (locationController.text.isEmpty) {
                                unawaited(
                                  FailureWidget.build(
                                    title: 'Something went wrong!',
                                    message: 'Please enter location to continue.',
                                    context: context,
                                  ),
                                );
                                return;
                              }

                              final newGuests = <Guest>[];

                              for (final guest in selectedGuests.value) {
                                newGuests.add(Guest(userId: guest.id));
                              }

                              final itinerary = ItineraryModel(
                                name: eventName.text.trim(),
                                transportation: transportation.value,
                                startDate: _fromDate.toIso8601String(),
                                endDate: _toDate.toIso8601String(),
                                location: locationController.text.trim(),
                                locationDescription: locationDescription.value,
                                guests: newGuests,
                              );

                              isLoading.value = true;
                              final res = await ref.read(travelsControllerProvider.notifier).addItinerary(itinerary: itinerary);
                              isLoading.value = false;

                              if (res.ok && mounted) {
                                await SuccessWidget.build(
                                  title: 'Success!',
                                  message: 'Itinerary has been added successfully.',
                                  context: context,
                                );
                                if (!mounted) return;
                              } else {
                                unawaited(
                                  FailureWidget.build(
                                    title: 'Something went wrong!',
                                    message: 'There was an error adding the Itinerary.',
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
