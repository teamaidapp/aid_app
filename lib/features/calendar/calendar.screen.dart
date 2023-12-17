import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/core/extensions.dart';
import 'package:team_aid/design_system/components/buttons/secondary_button.dart';
import 'package:team_aid/design_system/components/inputs/multi_dropdown.dart';
import 'package:team_aid/design_system/components/inputs/time_picker.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/calendar/controllers/calendar.controller.dart';
import 'package:team_aid/features/calendar/entities/event.model.dart';
import 'package:team_aid/features/calendar/entities/event_hour.model.dart';
import 'package:team_aid/features/calendar/entities/event_shared.model.dart';
import 'package:team_aid/features/calendar/entities/hour.model.dart';
import 'package:team_aid/features/calendar/entities/schedule.model.dart';
import 'package:team_aid/features/calendar/widgets/event.widget.dart';
import 'package:team_aid/features/common/functions/global_functions.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/location.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';

/// The statelessWidget that handles the current screen
class CalendarScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const CalendarScreen({
    required this.addToCalendar,
    super.key,
  });

  /// If we need to show first the create schedule widget
  final bool addToCalendar;

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  @override
  void initState() {
    ref.read(calendarControllerProvider.notifier).getCalendarData();
    ref.read(calendarControllerProvider.notifier).getSharedCalendar();
    ref.read(calendarControllerProvider.notifier).getCalendarInvitations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentSelectedWidget = useState(0);
    final formattedDate = DateFormat('dd / MMM').format(DateTime.now()).toUpperCase();
    final formattedDay = DateFormat('EEEE').format(DateTime.now()).toUpperCase();

    final events = ref.watch(calendarControllerProvider).calendarEvents;
    final sharedEvents = ref.watch(calendarControllerProvider).sharedCalendar;
    final createSchedule = useState(widget.addToCalendar);

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
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 34),
            child: PageView(
              controller: PageController(viewportFraction: 0.4),
              padEnds: false,
              children: [
                SizedBox(
                  width: 120,
                  child: GestureDetector(
                    key: const Key('today'),
                    onTap: () {
                      currentSelectedWidget.value = 0;
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: currentSelectedWidget.value == 0 ? const Color(0xffF5F8FB) : Colors.white,
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
                          color: currentSelectedWidget.value == 0 ? TAColors.textColor : const Color(0x0D253C4D).withOpacity(0.3),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: GestureDetector(
                    key: const Key('full_calendar'),
                    onTap: () {
                      currentSelectedWidget.value = 1;
                    },
                    child: Container(
                      height: 50,
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: currentSelectedWidget.value == 1 ? const Color(0xffF5F8FB) : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: TATypography.paragraph(
                          text: 'Full Calendar',
                          color: currentSelectedWidget.value == 1 ? TAColors.textColor : const Color(0x0D253C4D).withOpacity(0.3),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: GestureDetector(
                    key: const Key('invitations'),
                    onTap: () {
                      currentSelectedWidget.value = 2;
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: currentSelectedWidget.value == 2 ? const Color(0xffF5F8FB) : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: TATypography.paragraph(
                          text: 'Invitations',
                          color: currentSelectedWidget.value == 2 ? TAColors.textColor : const Color(0x0D253C4D).withOpacity(0.3),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                            text: createSchedule.value ? 'BACK' : 'SCHEDULE',
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            icon: createSchedule.value ? null : Iconsax.add,
                            onTap: () {
                              if (createSchedule.value) {
                                createSchedule.value = false;
                              } else {
                                createSchedule.value = true;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (createSchedule.value)
                    const Expanded(
                      child: _CreateScheduleWidget(),
                    )
                  else if (currentSelectedWidget.value == 0)
                    _TodayWidget(events: events, sharedEvents: sharedEvents)
                  else if (currentSelectedWidget.value == 1)
                    _FullCalendarWidget(events: events)
                  else
                    const _InvitationsWidget(),
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
    required this.sharedEvents,
  });

  final AsyncValue<List<CalendarEvent>> events;

  final AsyncValue<List<EventShared>> sharedEvents;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: events.when(
          data: (events) {
            return sharedEvents.when(
              data: (shared) {
                // Filter events by dateKey
                final filteredEvents = events.where((event) {
                  return event.dateKey.split('T')[0] == DateTime.now().toIso8601String().split('T')[0];
                }).toList();

                final filteredSharedEvents = events.where((event) {
                  return event.dateKey.split('T')[0] == DateTime.now().toIso8601String().split('T')[0];
                }).toList();

                if (filteredEvents.isNotEmpty || filteredSharedEvents.isNotEmpty) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredEvents.length,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final event = filteredEvents[index];
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
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: shared.length,
                          itemBuilder: (context, index) {
                            final event = shared[index];
                            final startTime = DateFormat('hh:mm a').format(event.event.startDate).toUpperCase();
                            final endTime = DateFormat('hh:mm a').format(event.event.endDate).toUpperCase();
                            return Column(
                              children: [
                                const SizedBox(height: 20),
                                EventWidget(
                                  eventName: event.event.eventName.capitalizeWord(),
                                  organizerName: event.inviteUser.firstName,
                                  startTime: startTime,
                                  endTime: endTime,
                                  event: event,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: TATypography.paragraph(
                      text: 'Hurrah! You have no events for today :)',
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
            );
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
      ),
    );
  }
}

class _FullCalendarWidget extends ConsumerStatefulWidget {
  const _FullCalendarWidget({required this.events});

  final AsyncValue<List<CalendarEvent>> events;

  @override
  ConsumerState<_FullCalendarWidget> createState() => _FullCalendarWidgetState();
}

class _FullCalendarWidgetState extends ConsumerState<_FullCalendarWidget> {
  late String currentMonth;
  late String nextMonth;
  late String previousMonth;
  final currentMonthDays = <DateTime>[];
  // final hours = <EventHourModel>[];
  // final todayHours = <EventHourModel>[];
  final calendar = <CalendarModel>[];

  var _initialDate = DateTime.now();

  final _scrollController = AutoScrollController();

  @override
  void initState() {
    getMonths();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final todayDay = DateTime.now().day - 1;
      await _scrollController.scrollToIndex(todayDay, preferPosition: AutoScrollPosition.begin);
    });
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
      child: widget.events.when(
        data: (events) {
          // todayHours.addAll(generateHourListFromCurrentHour(events: events));
          // hours.addAll(generateHourList(events: events));
          calendar.addAll(generateCalendar(events: events));
          return Column(
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
                      _initialDate = _initialDate.subtract(const Duration(days: 30));
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
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    final dayName = calendar[index].dayLabel;
                    final dayNumber = calendar[index].dayNumber;
                    final monthName = getMonthName(currentMonthDays[index]);

                    return AutoScrollTag(
                      key: ValueKey(index),
                      index: index,
                      controller: _scrollController,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final hoursWidth = calendar[index].hours.length * 120.0;
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                            height: 100,
                                            child: ListView.builder(
                                              itemCount: calendar[index].hours.length,
                                              // shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, hoursIndex) {
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
                                                            text: calendar[index].hours[hoursIndex].label,
                                                            color: TAColors.textColor.withOpacity(0.25),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 10),
                                                      if (calendar[index].hours[hoursIndex].event != null)
                                                        Expanded(
                                                          child: ListView.builder(
                                                            itemCount: calendar[index].hours[hoursIndex].event!.length,
                                                            itemBuilder: (context, indexFromVerticalList) {
                                                              return Container(
                                                                decoration: BoxDecoration(
                                                                  color: TAColors.purple,
                                                                  borderRadius: BorderRadius.circular(28),
                                                                ),
                                                                padding: const EdgeInsets.all(10),
                                                                margin: const EdgeInsets.only(bottom: 4),
                                                                child: TATypography.subparagraph(
                                                                  color: Colors.white,
                                                                  text:
                                                                      calendar[index].hours[hoursIndex].event![indexFromVerticalList].event.eventName,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        )
                                                      // else if (hours[index].event != null)
                                                      //   Expanded(
                                                      //     child: ListView.builder(
                                                      //       itemCount: hours[index].event!.length,
                                                      //       itemBuilder: (context, indexFromVerticalList) {
                                                      //         return Container(
                                                      //           decoration: BoxDecoration(
                                                      //             color: TAColors.purple,
                                                      //             borderRadius: BorderRadius.circular(28),
                                                      //           ),
                                                      //           padding: const EdgeInsets.all(10),
                                                      //           margin: const EdgeInsets.only(bottom: 4),
                                                      //           child: TATypography.subparagraph(
                                                      //             color: Colors.white,
                                                      //             text: hours[index].event![indexFromVerticalList].event.eventName,
                                                      //             fontWeight: FontWeight.w600,
                                                      //           ),
                                                      //         );
                                                      //       },
                                                      //     ),
                                                      //   )
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
                      ),
                    );
                  },
                ),
              ),
            ],
          );
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

  // List<EventHourModel> generateHourListFromCurrentHour({required List<CalendarEvent> events}) {
  //   todayHours.clear();
  //   final currentHour = DateTime.now().hour;

  //   final hourList = List<EventHourModel>.generate(
  //     24 - currentHour,
  //     (index) {
  //       final hour = '${currentHour + index}';
  //       final label = '${currentHour + index} ${currentHour + index >= 12 ? 'PM' : 'AM'}';
  //       final event = events.where((event) => event.event.startDate.hour == currentHour + index).toList();

  //       return EventHourModel(
  //         hour: hour,
  //         label: label,
  //         event: event,
  //       );
  //     },
  //   );

  //   return hourList;
  // }

  // List<EventHourModel> generateHourList({required List<CalendarEvent> events}) {
  //   hours.clear();
  //   final currentEventFromEvents = events.where((event) {
  //     return currentMonthDays.any((day) => event.dateKey.split('T')[0] == day.toIso8601String().split('T')[0]);
  //   }).toList();

  //   final currentDateEvents = currentEventFromEvents.where((event) {
  //     return event.dateKey.split('T')[0] == DateTime.now().toIso8601String().split('T')[0];
  //   }).toList();

  //   final hourList = List<EventHourModel>.generate(
  //     17,
  //     (index) {
  //       final hour = '${index + 8}';
  //       final label = '${index + 8} ${index + 8 >= 12 && index + 8 < 24 ? 'PM' : 'AM'}';
  //       final event = currentDateEvents.where((event) => event.event.startDate.hour == index + 8).toList();

  //       return EventHourModel(
  //         hour: hour,
  //         label: label,
  //         event: event,
  //       );
  //     },
  //   );

  //   return hourList;
  // }

  List<CalendarModel> generateCalendar({
    required List<CalendarEvent> events,
    int startHour = 8,
    int endHour = 23,
  }) {
    calendar.clear();

    final currentEventFromEvents = events.where((event) {
      return currentMonthDays.any((day) => event.dateKey.split('T')[0] == day.toIso8601String().split('T')[0]);
    }).toList();

    final calendarDays = <CalendarModel>[];

    for (var i = 0; i < currentMonthDays.length; i++) {
      final currentDay = currentMonthDays[i];
      final currentDayEvents = currentEventFromEvents.where((event) {
        final eventDate = event.event.startDate;
        return eventDate.year == currentDay.year && eventDate.month == currentDay.month && eventDate.day == currentDay.day;
      }).toList();

      final dayHours = List<EventHourModel>.generate(
        endHour - startHour + 1,
        (index) {
          final hour = '${index + startHour}';
          final label = '${index + startHour} ${index + startHour >= 12 && index + startHour < 24 ? 'PM' : 'AM'}';
          final events = currentDayEvents.where((event) => event.event.startDate.hour == index + startHour).toList();

          return EventHourModel(
            hour: hour,
            label: label,
            event: events.isEmpty ? null : events,
          );
        },
      );

      calendarDays.add(
        CalendarModel(
          dayLabel: DateFormat('EEEE').format(currentDay),
          dayNumber: currentDay.day,
          hours: dayHours,
        ),
      );
    }

    return calendarDays;
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

class _CreateScheduleWidget extends StatefulHookConsumerWidget {
  const _CreateScheduleWidget();

  @override
  ConsumerState<_CreateScheduleWidget> createState() => _CreateScheduleWidgetState();
}

class _CreateScheduleWidgetState extends ConsumerState<_CreateScheduleWidget> {
  final fromHours = <HourModel>[];
  final tohours = <HourModel>[];
  final days = <DateTime>[];
  final months = <String>[];
  final years = <String>[];
  var _currentDay = DateTime.now().day;
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
        month: _currentSelectedMonth,
        year: _currentSelectedYear,
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
    final teamId = useState('');
    final periodicity = useState('once');
    final isLoading = useState(false);
    final locationDescription = useState('');
    final eventName = useTextEditingController();
    final selectedGuests = useState(<TADropdownModel>[]);
    final locationController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final teams = ref.watch(homeControllerProvider).userTeams;
    final guests = ref.watch(calendarControllerProvider).contactList;
    return teams.when(
      error: (e, s) => const SizedBox(),
      loading: () => const SizedBox(),
      data: (data) {
        if (data.isNotEmpty) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TAContainer(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
                  child: TADropdown(
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
                        ref.read(calendarControllerProvider.notifier).getContactList(teamId: teamId.value);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TAContainer(
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
                                item: _currentDay.toString(),
                                id: _currentDay.toString(),
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
                                  setState(() {
                                    _currentDay = int.parse(v.item);
                                    _fromDate = DateTime(
                                      _currentSelectedYear,
                                      _currentSelectedMonth,
                                      _currentDay,
                                    );
                                  });
                                }
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
                                      _currentDay,
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
                                      _currentDay,
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
                              label: 'Check In',
                              pickedDate: _fromDate,
                              onChanged: (date) {
                                setState(() {
                                  _fromDate = DateTime(
                                    _currentSelectedYear,
                                    _currentSelectedMonth,
                                    _currentDay,
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
                              label: 'Check Out',
                              pickedDate: _toDate,
                              hourFrom: _toDate != null ? _fromDate!.hour + 1 : null,
                              onChanged: (date) {
                                setState(() {
                                  _toDate = DateTime(
                                    _currentSelectedYear,
                                    _currentSelectedMonth,
                                    _currentDay,
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
                      LocationWidget(
                        onChanged: (v) {
                          if (v != null) {
                            locationController.text = v.id;
                            locationDescription.value = v.item;
                          }
                        },
                      ),
                      // TAPrimaryInput(
                      //   placeholder: '',
                      //   textEditingController: locationController,
                      //   label: 'Location',
                      // ),
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

                                    if (_fromDate == null) {
                                      unawaited(
                                        FailureWidget.build(
                                          title: 'Something went wrong!',
                                          message: 'Please select the hour of the check out.',
                                          context: context,
                                        ),
                                      );
                                      return;
                                    }
                                    if (_toDate == null) {
                                      unawaited(
                                        FailureWidget.build(
                                          title: 'Something went wrong!',
                                          message: 'Please select the hour of the check in.',
                                          context: context,
                                        ),
                                      );
                                      return;
                                    }

                                    isLoading.value = true;

                                    final newGuests = <Guest>[];

                                    for (final guest in selectedGuests.value) {
                                      newGuests.add(Guest(userId: guest.id));
                                    }

                                    final event = ScheduleModel(
                                      eventName: eventName.text,
                                      locationDescription: locationDescription.value,
                                      startDate: _fromDate!.toIso8601String(),
                                      endDate: _toDate!.toIso8601String(),
                                      location: locationController.text,
                                      eventDescription: descriptionController.text,
                                      guest: newGuests,
                                      periodicity: periodicity.value,
                                    );
                                    final res = await ref.read(calendarControllerProvider.notifier).addSchedule(schedule: event);
                                    isLoading.value = false;

                                    if (res.ok && mounted) {
                                      await SuccessWidget.build(
                                        title: 'Success!',
                                        message: 'Event has been added successfully.',
                                        context: context,
                                      );
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
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
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: TATypography.paragraph(
                text: 'You need to be part of a team to access this feature.',
                color: TAColors.purple,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }
      },
    );
  }
}

class _InvitationsWidget extends ConsumerWidget {
  const _InvitationsWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invitations = ref.watch(calendarControllerProvider).calendarInvitationsEvents;

    return Expanded(
      child: invitations.when(
        data: (data) {
          if (data.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                return TAContainer(
                  child: Column(
                    children: [
                      TATypography.paragraph(
                        text: '${data[index].recipientUserId.firstName.trim().capitalizeWord()} shared a calendar with you',
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: TASecondaryButton(
                              text: 'DECLINE',
                              mainAxisAlignment: MainAxisAlignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              onTap: () async {
                                final res = await ref.read(calendarControllerProvider.notifier).changeStatusInvitation(
                                      id: data[index].id,
                                      status: 'rejected',
                                    );
                                if (!context.mounted) return;
                                if (res.ok) {
                                  await SuccessWidget.build(
                                    title: 'Success!',
                                    message: 'Invitation declined successfully.',
                                    context: context,
                                  );
                                } else {
                                  unawaited(
                                    FailureWidget.build(
                                      title: 'Something went wrong!',
                                      message: 'There was an error declining the invitation.',
                                      context: context,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TAPrimaryButton(
                              text: 'ACCEPT',
                              mainAxisAlignment: MainAxisAlignment.center,
                              onTap: () async {
                                final res = await ref.read(calendarControllerProvider.notifier).changeStatusInvitation(
                                      id: data[index].id,
                                      status: 'accepted',
                                    );
                                if (!context.mounted) return;
                                if (res.ok) {
                                  await SuccessWidget.build(
                                    title: 'Success!',
                                    message: 'Invitation accepted successfully.',
                                    context: context,
                                  );
                                } else {
                                  unawaited(
                                    FailureWidget.build(
                                      title: 'Something went wrong!',
                                      message: 'There was an error accepting the invitation.',
                                      context: context,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: TATypography.paragraph(
                text: 'You have no invitations.',
                color: TAColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            );
          }
        },
        error: (_, __) => const SizedBox(),
        loading: () => const SizedBox(),
      ),
    );
  }
}
