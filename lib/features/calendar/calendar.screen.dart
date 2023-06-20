import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/components/buttons/secondary_button.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/calendar/widgets/event.widget.dart';

/// The statelessWidget that handles the current screen
class CalendarScreen extends HookWidget {
  /// The constructor.
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final showTodayWidget = useState(true);
    final formattedDate =
        DateFormat('dd / MMM').format(DateTime.now()).toUpperCase();
    final formattedDay =
        DateFormat('EEEE').format(DateTime.now()).toUpperCase();
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
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: showTodayWidget.value
                        ? const _TodayWidget()
                        : const _FullCalendarWidget(),
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

class _TodayWidget extends StatelessWidget {
  const _TodayWidget();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 20),
        EventWidget(
          eventName: 'Fundraising meeting',
          organizerName: 'Coach Felipe',
          startTime: '3:30 PM',
          endTime: '4:30 PM',
        ),
      ],
    );
  }
}

class _FullCalendarWidget extends StatefulWidget {
  const _FullCalendarWidget();

  @override
  State<_FullCalendarWidget> createState() => _FullCalendarWidgetState();
}

class _FullCalendarWidgetState extends State<_FullCalendarWidget> {
  late String currentMonth;
  late String nextMonth;
  late String previousMonth;
  final currentMonthDays = <DateTime>[];
  final hours = <String>[];

  var _initialDate = DateTime.now();

  @override
  void initState() {
    getMonths();
    hours.addAll(generateHourListFromCurrentHour());
    super.initState();
  }

  void getMonths() {
    currentMonth = getCurrentMonth(_initialDate);
    nextMonth = getNextMonth(_initialDate);
    previousMonth = getPreviousMonth(_initialDate);
    currentMonthDays.addAll(getDaysInCurrentMonth());
  }

  @override
  Widget build(BuildContext context) {
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
            itemBuilder: (context, index) {
              final dayName = getDayName(currentMonthDays[index]);
              final dayNumber = currentMonthDays[index].day;
              final monthName = getMonthName(currentMonthDays[index]);
              return LayoutBuilder(
                builder: (context, constraints) {
                  final hoursWidth = hours.length * 120.0;
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
                                    height: 80,
                                    child: ListView.builder(
                                      itemCount: hours.length,
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
                                                    text: hours[index],
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
  List<DateTime> getDaysInCurrentMonth() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

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
