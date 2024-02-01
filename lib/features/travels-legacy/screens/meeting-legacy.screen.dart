import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/extensions.dart';
import 'package:team_aid/design_system/components/inputs/multi_dropdown.dart';
import 'package:team_aid/design_system/components/inputs/time_picker.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/calendar/controllers/calendar.controller.dart';
import 'package:team_aid/features/calendar/entities/hour.model.dart';
import 'package:team_aid/features/calendar/entities/schedule.model.dart';
import 'package:team_aid/features/calendar/widgets/event.widget.dart';
import 'package:team_aid/features/common/functions/global_functions.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/location.widget.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/travels-legacy/controllers/travels-legacy.controller.dart';

/// The statelessWidget that handles the current screen
class MeetingTravelScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const MeetingTravelScreen({
    required this.pageController,
    super.key,
  });

  /// The page controller
  final PageController pageController;
  @override
  ConsumerState<MeetingTravelScreen> createState() => _MeetingTravelScreenState();
}

class _MeetingTravelScreenState extends ConsumerState<MeetingTravelScreen> {
  final fromHours = <HourModel>[];
  final tohours = <HourModel>[];
  final days = <DateTime>[];
  final months = <String>[];
  final years = <String>[];
  final currentDay = DateTime.now().day;
  var _currentSelectedMonth = DateTime.now().month;
  var _currentSelectedYear = DateTime.now().year;
  var _selectedRepeat = TADropdownModel(item: 'Once', id: 'once');

  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    fromHours.addAll(GlobalFunctions.generateHourModels(8));
    tohours.addAll(GlobalFunctions.generateHourModels(8));
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
    final periodicity = useState('once');
    final isLoading = useState(false);
    final showMeetings = useState(false);
    final eventName = useTextEditingController();
    final eventDescription = useTextEditingController();
    final locationController = useTextEditingController();
    final teams = ref.watch(homeControllerProvider).userTeams;
    final guests = ref.watch(travelsLegacyControllerProvider).contactList;
    final selectedGuests = useState(<TADropdownModel>[]);
    final meetings = ref.watch(travelsLegacyControllerProvider).calendarEvents;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              child: GestureDetector(
                key: const Key('add_meet'),
                onTap: () {
                  showMeetings.value = false;
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: !showMeetings.value ? TAColors.purple : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: TATypography.paragraph(
                      text: 'Add meet',
                      key: const Key('add_meeting_title'),
                      color: !showMeetings.value ? Colors.white : const Color(0x0D253C4D).withOpacity(0.3),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 170,
              child: GestureDetector(
                key: const Key('show_meetings'),
                onTap: () {
                  showMeetings.value = true;
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: showMeetings.value ? TAColors.purple : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: TATypography.paragraph(
                      text: 'View meetings',
                      color: showMeetings.value ? Colors.white : const Color(0x0D253C4D).withOpacity(0.3),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (showMeetings.value)
          Expanded(
            child: meetings.when(
              data: (data) {
                if (data.isEmpty) {
                  return Center(
                    child: TATypography.paragraph(
                      text: 'No meetings added yet',
                      color: const Color(0x0D253C4D).withOpacity(0.3),
                      fontWeight: FontWeight.w700,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    padding: const EdgeInsets.all(20),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final event = data[index];
                      final startTime = DateFormat('hh:mm a').format(event.event.startDate).toUpperCase();
                      final endTime = DateFormat('hh:mm a').format(event.event.endDate).toUpperCase();
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          EventWidget(
                            eventName: event.event.eventName.capitalizeWord(),
                            organizerName: event.event.userCreator?.firstName ?? '',
                            startTime: startTime,
                            endTime: endTime,
                            event: event,
                          ),
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
                  child: CircularProgressIndicator(
                    color: TAColors.purple,
                  ),
                );
              },
            ),
          )
        else
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
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
                              ref.read(travelsLegacyControllerProvider.notifier).getContactList(teamId: teamId.value);
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
                            TATypography.h3(text: 'Add a meet'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TAPrimaryInput(
                          label: 'Event Name',
                          textEditingController: eventName,
                          placeholder: '',
                        ),
                        const SizedBox(height: 10),
                        TAPrimaryInput(
                          label: 'Event description',
                          textEditingController: eventDescription,
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
                              child: TATimePicker(
                                label: 'Start',
                                pickedDate: _fromDate,
                                onChanged: (date) {
                                  setState(() {
                                    _fromDate = DateTime(
                                      _currentSelectedYear,
                                      _currentSelectedMonth,
                                      currentDay,
                                      date.hour,
                                      date.minute,
                                    );
                                    tohours
                                      ..clear()
                                      ..addAll(GlobalFunctions.generateHourModels(date.hour + 1));
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: TATimePicker(
                                label: 'End',
                                pickedDate: _toDate,
                                hourFrom: _toDate != null ? _fromDate!.hour + 1 : null,
                                onChanged: (date) {
                                  setState(() {
                                    _toDate = DateTime(
                                      _currentSelectedYear,
                                      _currentSelectedMonth,
                                      currentDay,
                                      date.hour,
                                      date.minute,
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TADropdown(
                          label: 'Repeat',
                          items: [
                            TADropdownModel(item: 'Once', id: 'once'),
                            TADropdownModel(item: 'Daily', id: 'daily'),
                            TADropdownModel(item: 'Weekly', id: 'weekly'),
                            TADropdownModel(item: 'Monthly', id: 'monthly'),
                            TADropdownModel(item: 'Yearly', id: 'yearly'),
                          ],
                          placeholder: '',
                          selectedValue: _selectedRepeat,
                          onChange: (v) {
                            if (v != null) {
                              setState(() {
                                periodicity.value = v.id;
                                _selectedRepeat = TADropdownModel(item: v.item, id: v.id);
                              });
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
                                item: item != null ? '${item.user.firstName} ${item.user.lastName}' : '',
                                id: item != null ? item.user.id : '',
                              );
                            },
                          ),
                          placeholder: '',
                          onChange: (v) {
                            selectedGuests.value = v;
                          },
                        ),
                        const SizedBox(height: 10),
                        LocationWidget(
                          onChanged: (v) {
                            if (v != null) {
                              locationController.text = v.id;
                            }
                          },
                        ),
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
                                    text: 'NEXT',
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

                                      if (_fromDate == null) {
                                        unawaited(
                                          FailureWidget.build(
                                            title: 'Something went wrong!',
                                            message: 'Please select the hour of the End.',
                                            context: context,
                                          ),
                                        );
                                        return;
                                      }
                                      if (_toDate == null) {
                                        unawaited(
                                          FailureWidget.build(
                                            title: 'Something went wrong!',
                                            message: 'Please select the hour of the Start.',
                                            context: context,
                                          ),
                                        );
                                        return;
                                      }

                                      isLoading.value = true;
                                      final event = ScheduleModel(
                                        eventName: eventName.text,
                                        startDate: _fromDate!.toIso8601String(),
                                        endDate: _toDate!.toIso8601String(),
                                        location: locationController.text,
                                        eventDescription: eventDescription.text,
                                        locationDescription: locationController.text,
                                        guest: [],
                                        periodicity: periodicity.value,
                                      );
                                      final res = await ref.read(calendarControllerProvider.notifier).addSchedule(schedule: event);
                                      isLoading.value = false;

                                      if (res.ok && mounted) {
                                        await widget.pageController.nextPage(
                                          duration: const Duration(milliseconds: 300),
                                          curve: Curves.easeIn,
                                        );
                                        // await SuccessWidget.build(
                                        //   title: 'Success!',
                                        //   message: 'Event has been added successfully.',
                                        //   context: context,
                                        // );
                                        // if (context.mounted) {
                                        //   context.pop();
                                        // }
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
            ),
          ),
      ],
    );
  }
}
