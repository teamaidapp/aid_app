import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/extensions.dart';
import 'package:team_aid/design_system/components/buttons/secondary_button.dart';
import 'package:team_aid/design_system/components/inputs/dropdown_input.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/calendar/controllers/calendar.controller.dart';
import 'package:team_aid/features/calendar/entities/event.model.dart';
import 'package:team_aid/features/calendar/entities/hour.model.dart';
import 'package:team_aid/features/calendar/entities/schedule.model.dart';
import 'package:team_aid/features/calendar/widgets/event.widget.dart';
import 'package:team_aid/features/common/functions/global_functions.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/location.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';

/// The statelessWidget that handles the current screen
class CalendarScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  @override
  void initState() {
    ref.read(calendarControllerProvider.notifier).getCalendarData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showTodayWidget = useState(true);
    final formattedDate =
        DateFormat('dd / MMM').format(DateTime.now()).toUpperCase();
    final formattedDay =
        DateFormat('EEEE').format(DateTime.now()).toUpperCase();

    final events = ref.watch(calendarControllerProvider).calendarEvents;
    final createSchedule = useState(false);

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
                      text: 'My Calendar',
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
                  key: const Key('today'),
                  onTap: () {
                    showTodayWidget.value = true;
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: showTodayWidget.value
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
                        text: 'Today',
                        key: const Key('today_title'),
                        color: showTodayWidget.value
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
                  key: const Key('full_calendar'),
                  onTap: () {
                    showTodayWidget.value = false;
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: !showTodayWidget.value
                          ? const Color(0xffF5F8FB)
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: TATypography.paragraph(
                        text: 'Full Calendar',
                        color: !showTodayWidget.value
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
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TAContainer(
                          radius: 28,
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 18,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Iconsax.calendar,
                                color: TAColors.purple,
                              ),
                              const SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TATypography.subparagraph(
                                    text: formattedDay,
                                    color: TAColors.grey1,
                                  ),
                                  TATypography.paragraph(
                                    text: formattedDate,
                                    fontWeight: FontWeight.w600,
                                    color: TAColors.textColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 80),
                        Expanded(
                          child: TAPrimaryButton(
                            text: 'SCHEDULE',
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            icon: Iconsax.add,
                            onTap: () {
                              createSchedule.value = true;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (createSchedule.value)
                    const Expanded(
                      child: const _CreateScheduleWidget(),
                    )
                  else
                    showTodayWidget.value
                        ? _TodayWidget(events: events)
                        : _FullCalendarWidget(events: events),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayWidget extends StatelessWidget {
  const _TodayWidget({
    required this.events,
  });

  final AsyncValue<List<CalendarEvent>> events;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: events.when(
        data: (data) {
          // Filter events by dateKey
          final filteredEvents = data.where((event) {
            return event.dateKey ==
                DateTime.now().toIso8601String().split('T')[0];
          }).toList();

          if (filteredEvents.isNotEmpty) {
            return ListView.builder(
              itemCount: filteredEvents.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    EventWidget(
                      eventName: event.event.eventName.capitalizeWord(),
                      organizerName: 'Coach Felipe',
                      startTime: '3:30 PM',
                      endTime: '4:30 PM',
                    ),
                  ],
                );
              },
            );
          } else {
            return Center(
              child: TATypography.paragraph(
                text: 'Hurrah! You have no events :)',
                color: TAColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            );
          }
        },
        error: (error, stackTrace) {
          return const SizedBox();
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                TAColors.purple,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FullCalendarWidget extends StatefulWidget {
  const _FullCalendarWidget({required this.events});

  final AsyncValue<List<CalendarEvent>> events;

  @override
  State<_FullCalendarWidget> createState() => _FullCalendarWidgetState();
}

class _FullCalendarWidgetState extends State<_FullCalendarWidget> {
  late String currentMonth;
  late String nextMonth;
  late String previousMonth;
  final currentMonthDays = <DateTime>[];
  final hours = <String>[];
  final todayHours = <String>[];

  var _initialDate = DateTime.now();

  @override
  void initState() {
    getMonths();
    todayHours.addAll(generateHourListFromCurrentHour());
    hours.addAll(generateHourList());
    super.initState();
  }

  void getMonths() {
    currentMonth = getCurrentMonth(_initialDate);
    nextMonth = getNextMonth(_initialDate);
    previousMonth = getPreviousMonth(_initialDate);
    currentMonthDays
      ..clear()
      ..addAll(getDaysInCurrentMonth(_initialDate));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TATypography.h3(
                text: previousMonth.toUpperCase(),
                color: TAColors.textColor.withOpacity(0.25),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  _initialDate =
                      _initialDate.subtract(const Duration(days: 30));
                  setState(getMonths);
                },
                behavior: HitTestBehavior.translucent,
                child: const Icon(
                  Iconsax.arrow_left_2,
                  size: 20,
                  color: TAColors.textColor,
                ),
              ),
              const SizedBox(width: 20),
              TATypography.h3(
                text: currentMonth.toUpperCase(),
                color: TAColors.textColor,
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  _initialDate = _initialDate.add(const Duration(days: 30));
                  setState(getMonths);
                },
                behavior: HitTestBehavior.translucent,
                child: const Icon(
                  Iconsax.arrow_right_3,
                  size: 20,
                  color: TAColors.textColor,
                ),
              ),
              const SizedBox(width: 20),
              TATypography.h3(
                text: nextMonth.toUpperCase(),
                color: TAColors.textColor.withOpacity(0.25),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentMonthDays.length,
              itemBuilder: (context, index) {
                final dayName = getDayName(currentMonthDays[index]);
                final dayNumber = currentMonthDays[index].day;
                final monthName = getMonthName(currentMonthDays[index]);
                final isToday =
                    currentMonthDays[index].day == DateTime.now().day;
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final hoursWidth = isToday
                        ? todayHours.length * 120.0
                        : hours.length * 120.0;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        width: hoursWidth,
                        child: Column(
                          children: [
                            TAContainer(
                              radius: 28,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TATypography.subparagraph(
                                        text: dayName,
                                        color: TAColors.color3,
                                      ),
                                      Row(
                                        children: [
                                          TATypography.paragraph(
                                            text: dayNumber.toString(),
                                            fontWeight: FontWeight.w600,
                                            color: TAColors.textColor,
                                          ),
                                          const SizedBox(width: 10),
                                          TATypography.paragraph(
                                            text: monthName,
                                            fontWeight: FontWeight.w600,
                                            color: TAColors.textColor,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      SizedBox(
                                        width: 76,
                                        child: TASecondaryButton(
                                          text: 'VIEW',
                                          padding: EdgeInsets.zero,
                                          onTap: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  const SizedBox(
                                    height: 80,
                                    child: VerticalDivider(),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 80,
                                      child: ListView.builder(
                                        itemCount: isToday
                                            ? todayHours.length
                                            : hours.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: 110,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                      child: VerticalDivider(),
                                                    ),
                                                    TATypography.paragraph(
                                                      text: isToday
                                                          ? todayHours[index]
                                                          : hours[index],
                                                      color: TAColors.textColor
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<String> generateHourListFromCurrentHour() {
    final currentHour = DateTime.now().hour;

    final hourList = List<String>.generate(
      24 - currentHour,
      (index) =>
          '${currentHour + index} ${currentHour + index >= 12 ? 'PM' : 'AM'}',
    );

    return hourList;
  }

  List<String> generateHourList() {
    final hourList = List<String>.generate(
      24,
      (index) => '${index + 1} ${index + 1 >= 12 ? 'PM' : 'AM'}',
    );

    return hourList;
  }

  String getDayName(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  String getMonthName(DateTime dateTime) {
    return DateFormat('MMM').format(dateTime).toUpperCase();
  }

  /// This function generates a list of all the days in the current month.
  ///
  /// Returns:
  ///   The function `getDaysInCurrentMonth()` returns a list of `DateTime` objects representing all the
  /// days in the current month.
  List<DateTime> getDaysInCurrentMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    final daysInMonth = lastDayOfMonth.difference(firstDayOfMonth).inDays + 1;
    final days = List<DateTime>.generate(
      daysInMonth,
      (index) => firstDayOfMonth.add(Duration(days: index)),
    );

    return days;
  }

  String getCurrentMonth(DateTime dateTime) {
    return DateFormat('MMM').format(dateTime).toUpperCase();
  }

  String getNextMonth(DateTime dateTime) {
    final nextMonth = DateTime(dateTime.year, dateTime.month + 1);
    return DateFormat('MMM').format(nextMonth).toUpperCase();
  }

  String getPreviousMonth(DateTime dateTime) {
    final previousMonth = DateTime(dateTime.year, dateTime.month - 1);
    return DateFormat('MMM').format(previousMonth).toUpperCase();
  }
}

class _CreateScheduleWidget extends StatefulHookWidget {
  const _CreateScheduleWidget();

  @override
  State<_CreateScheduleWidget> createState() => _CreateScheduleWidgetState();
}

class _CreateScheduleWidgetState extends State<_CreateScheduleWidget> {
  final hours = <HourModel>[];
  final days = <DateTime>[];
  final months = <String>[];
  final years = <String>[];
  final currentDay = DateTime.now().day;
  var currentSelectedMonth = DateTime.now().month;
  var currentSelectedYear = DateTime.now().year;

  var fromDate = DateTime.now();
  var toDate = DateTime.now();

  @override
  void initState() {
    hours.addAll(GlobalFunctions.generateHourModels());
    days.addAll(
      GlobalFunctions.getDaysInMonth(
        month: currentSelectedMonth,
        year: currentSelectedYear,
      ),
    );
    months.addAll(
      ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    );
    years.addAll(
      ['2023', '2024', '2025', '2026', '2027', '2028', '2029', '2030'],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventName = useTextEditingController();
    final locationController = useTextEditingController();
    final guestController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final periodicity = useState('');
    final isLoading = useState(false);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TAContainer(
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Iconsax.calendar_2,
                  size: 20,
                  color: TAColors.purple,
                ),
                const SizedBox(width: 10),
                TATypography.h3(text: 'Add a schedule'),
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
              label: 'Event Description',
              textEditingController: descriptionController,
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
                      fromDate = DateTime(
                        currentSelectedYear,
                        currentSelectedMonth,
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
                      item: currentSelectedMonth.toString(),
                      id: currentSelectedMonth.toString(),
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
                          currentSelectedMonth = int.parse(v.id);

                          fromDate = DateTime(
                            currentSelectedYear,
                            currentSelectedMonth,
                            currentDay,
                          );

                          days
                            ..clear()
                            ..addAll(
                              GlobalFunctions.getDaysInMonth(
                                month: currentSelectedMonth,
                                year: currentSelectedYear,
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
                      item: currentSelectedYear.toString(),
                      id: currentSelectedYear.toString(),
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
                          fromDate = DateTime(
                            currentSelectedYear,
                            currentSelectedMonth,
                            currentDay,
                          );
                          currentSelectedYear = int.parse(v.id);
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
                          fromDate = DateTime(
                            currentSelectedYear,
                            currentSelectedMonth,
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
                          toDate = DateTime(
                            currentSelectedYear,
                            currentSelectedMonth,
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
            TADropdown(
              label: 'Repeat',
              items: [
                TADropdownModel(item: 'Daily', id: 'daily'),
                TADropdownModel(item: 'Weekly', id: 'weekly'),
                TADropdownModel(item: 'Monthly', id: 'monthly'),
                TADropdownModel(item: 'Yearly', id: 'yearly'),
              ],
              placeholder: '',
              onChange: (v) {
                if (v != null) {
                  setState(() {
                    periodicity.value = v.id;
                  });
                }
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
            // TAPrimaryInput(
            //   placeholder: '',
            //   textEditingController: locationController,
            //   label: 'Location',
            // ),
            const SizedBox(height: 10),
            TAPrimaryInput(
              placeholder: '',
              textEditingController: guestController,
              label: 'Guest',
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
                        text: 'SAVE',
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
                          isLoading.value = true;
                          final event = ScheduleModel(
                            eventName: eventName.text,
                            startDate: fromDate.toIso8601String(),
                            endDate: toDate.toIso8601String(),
                            location: locationController.text,
                            eventDescription: descriptionController.text,
                            guest: [],
                            periodicity: periodicity.value,
                          );
                          inspect(event);
                          final res = await ref
                              .read(calendarControllerProvider.notifier)
                              .addSchedule(schedule: event);
                          isLoading.value = false;

                          if (res.ok && mounted) {
                            unawaited(
                              SuccessWidget.build(
                                title: 'Success!',
                                message: 'Event has been added successfully.',
                                context: context,
                              ),
                            );
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
    );
  }
}
