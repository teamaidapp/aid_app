import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/calendar/entities/hour.model.dart';
import 'package:team_aid/features/common/functions/global_functions.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/location.widget.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/travels/controllers/travels.controller.dart';

class TravelScreen extends StatefulHookConsumerWidget {
  const TravelScreen({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  ConsumerState<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends ConsumerState<TravelScreen> {
  final fromHours = <HourModel>[];
  final tohours = <HourModel>[];
  final days = <DateTime>[];
  final months = <String>[];
  final years = <String>[];

  /// Arrival variables
  var currentDay = DateTime.now().day;
  var _currentSelectedMonth = DateTime.now().month;
  var _currentSelectedYear = DateTime.now().year;

  /// Departure variables
  var endDay = DateTime.now().day;
  var _currentEndSelectedMonth = DateTime.now().month;
  var _currentEndSelectedYear = DateTime.now().year;

  DateTime? _fromDate;
  DateTime? _toDate;

  final fileExpandableController = ExpandableController(initialExpanded: false);
  // File? selectedFile;
  // XFile? selectedImage;

  @override
  void initState() {
    _fromDate = DateTime(_currentSelectedYear, _currentSelectedMonth, currentDay);
    _toDate = DateTime(_currentSelectedYear, _currentSelectedMonth, currentDay);
    fromHours.addAll(GlobalFunctions.generateHourModels(8));
    tohours.addAll(GlobalFunctions.generateHourModels(8));
    days.addAll(
      GlobalFunctions.getDaysInMonth(
        year: _currentSelectedYear,
        month: _currentSelectedMonth,
      ),
    );
    years.addAll(
      ['2023', '2024', '2025', '2026', '2027'],
    );
    months.addAll(GlobalFunctions.aheadMonths(_currentSelectedYear));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final teamId = useState('');
    // final showItineraries = useState(true);
    final locationDescription = useState('');
    final isLoading = useState(false);
    final transportation = useState('');
    final eventName = useTextEditingController();
    final locationController = useTextEditingController();
    final teams = ref.watch(homeControllerProvider).userTeams;
    ref.watch(travelsControllerProvider);
    // final guests = ref.watch(travelsControllerProvider).contactList;
    // final itineraries = ref.watch(travelsLegacyControllerProvider).itineraryList;
    // final selectedGuests = useState(<TADropdownModel>[]);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TAContainer(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
            margin: const EdgeInsets.only(top: 20),
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
                    TATypography.h3(text: 'Add a travel'),
                  ],
                ),
                const SizedBox(height: 20),
                TAPrimaryInput(
                  label: 'Event name',
                  textEditingController: eventName,
                  placeholder: '',
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TATypography.paragraph(
                    text: 'Arrival date',
                    fontWeight: FontWeight.w600,
                    color: TAColors.color1,
                  ),
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
                            months.clear();
                            setState(() {
                              _fromDate = DateTime(
                                _currentSelectedYear,
                                _currentSelectedMonth,
                                currentDay,
                              );
                              _currentSelectedYear = int.parse(v.id);
                              months.addAll(GlobalFunctions.aheadMonths(_currentSelectedYear));
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TATypography.paragraph(
                    text: 'Departure date',
                    fontWeight: FontWeight.w500,
                    color: TAColors.color1,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TADropdown(
                        label: 'Day',
                        selectedValue: TADropdownModel(
                          item: endDay.toString(),
                          id: endDay.toString(),
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
                          if (v != null) {
                            endDay = int.parse(v.id);
                            _toDate = DateTime(
                              _currentSelectedYear,
                              _currentSelectedMonth,
                              endDay,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TADropdown(
                        label: 'Month',
                        selectedValue: TADropdownModel(
                          item: _currentEndSelectedMonth.toString(),
                          id: _currentEndSelectedMonth.toString(),
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
                              _currentEndSelectedMonth = int.parse(v.id);

                              _toDate = DateTime(
                                _currentEndSelectedYear,
                                _currentEndSelectedMonth,
                                endDay,
                              );

                              days
                                ..clear()
                                ..addAll(
                                  GlobalFunctions.getDaysInMonth(
                                    month: _currentEndSelectedMonth,
                                    year: _currentEndSelectedYear,
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
                          item: _currentEndSelectedYear.toString(),
                          id: _currentEndSelectedYear.toString(),
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
                            months.clear();
                            setState(() {
                              _toDate = DateTime(
                                _currentEndSelectedYear,
                                _currentEndSelectedMonth,
                                endDay,
                              );
                              _currentEndSelectedYear = int.parse(v.id);
                              months.addAll(GlobalFunctions.aheadMonths(_currentEndSelectedYear));
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
                // const SizedBox(height: 10),
                // TAMultiDropdown(
                //   label: 'Guests',
                //   items: List.generate(
                //     guests.valueOrNull?.length ?? 0,
                //     (index) {
                //       final item = guests.valueOrNull?[index];
                //       return TADropdownModel(
                //         item: item != null ? '${item.user.firstName} ${item.user.lastName}' : '',
                //         id: item != null ? item.user.id : '',
                //       );
                //     },
                //   ),
                //   placeholder: '',
                //   onChange: (v) {
                //     selectedGuests.value = v;
                //   },
                // ),
                // TAPrimaryInput(
                //   placeholder: '',
                //   textEditingController: guestController,
                //   label: 'Guest',
                // ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: SizedBox(
                        width: 100,
                        child: TATypography.paragraph(
                          text: 'Cancel',
                          underline: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: Consumer(
                        builder: (context, ref, child) {
                          return TAPrimaryButton(
                            text: 'NEXT',
                            isLoading: isLoading.value,
                            mainAxisAlignment: MainAxisAlignment.center,
                            onTap: () {
                              if (teamId.value.isEmpty) {
                                FailureWidget.build(
                                  title: 'Something went wrong!',
                                  message: 'Select a team.',
                                  context: context,
                                );
                                return;
                              }

                              if (eventName.text.isEmpty) {
                                FailureWidget.build(
                                  title: 'Something went wrong!',
                                  message: 'Enter an event name.',
                                  context: context,
                                );
                                return;
                              }

                              if (locationController.text.isEmpty) {
                                FailureWidget.build(
                                  title: 'Something went wrong!',
                                  message: 'Select a location.',
                                  context: context,
                                );
                                return;
                              }

                              if (transportation.value.isEmpty) {
                                FailureWidget.build(
                                  title: 'Something went wrong!',
                                  message: 'Select a transportation.',
                                  context: context,
                                );
                                return;
                              }

                              ref.read(travelsControllerProvider.notifier).setTravelName(name: eventName.text);
                              ref.read(travelsControllerProvider.notifier).setTravelLocation(location: locationController.text);
                              ref
                                  .read(travelsControllerProvider.notifier)
                                  .setTravelLocationDescription(locationDescription: locationDescription.value);
                              ref.read(travelsControllerProvider.notifier).setTravelStartDate(startDate: _fromDate.toString());
                              ref.read(travelsControllerProvider.notifier).setTravelEndDate(endDate: _toDate.toString());
                              ref.read(travelsControllerProvider.notifier).setTravelTransportation(transportation: transportation.value);

                              widget.pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
