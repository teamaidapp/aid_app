import 'dart:async';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/functions.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/calendar/entities/hour.model.dart';
import 'package:team_aid/features/common/functions/global_functions.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/location.widget.dart';
import 'package:team_aid/features/travels-legacy/entities/hotel.model.dart';
import 'package:team_aid/features/travels/controllers/travels.controller.dart';

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
  final fromHours = <HourModel>[];
  final tohours = <HourModel>[];
  final days = <DateTime>[];
  final departureDays = <DateTime>[];
  final months = <String>[];
  final years = <String>[];

  /// Arrival variables
  var currentDay = DateTime.now().day;
  var _currentSelectedMonth = DateTime.now().month;
  var _currentSelectedYear = DateTime.now().year;

  /// Departure variables
  var departureDay = DateTime.now().day;
  var _currentDepartureSelectedMonth = DateTime.now().month;
  var _currentDepartureSelectedYear = DateTime.now().year;

  DateTime? _fromDate;
  DateTime? _toDate;

  final fileExpandableController = ExpandableController(initialExpanded: false);
  File? selectedFile;
  XFile? selectedImage;

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
    departureDays.addAll(
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
    final isLoading = useState(false);
    final name = useTextEditingController();
    final googleDescription = useTextEditingController();
    // final description = useTextEditingController();
    final reservationController = useTextEditingController();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // TAContainer(
          //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
          //   margin: const EdgeInsets.only(top: 20),
          //   child: teams.when(
          //     data: (data) {
          //       return TADropdown(
          //         label: 'Team',
          //         placeholder: 'Select a team',
          //         items: List.generate(
          //           data.length,
          //           (index) => TADropdownModel(
          //             item: data[index].teamName,
          //             id: data[index].id,
          //           ),
          //         ),
          //         onChange: (selectedValue) {
          //           if (selectedValue != null) {
          //             teamId.value = selectedValue.id;
          //             ref.read(travelsLegacyControllerProvider.notifier).getContactList(teamId: teamId.value);
          //           }
          //         },
          //       );
          //     },
          //     error: (e, s) => const SizedBox(),
          //     loading: () => const SizedBox(),
          //   ),
          // ),
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
                LocationWidget(
                  title: 'Hotel address',
                  onChanged: (v) {
                    if (v != null) {
                      name.text = v.item;
                      googleDescription.text = v.id;
                    }
                  },
                ),
                // const SizedBox(height: 10),
                // TAPrimaryInput(
                //   label: 'Description',
                //   textEditingController: description,
                //   placeholder: '',
                // ),
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
                          if (v != null) {
                            currentDay = int.parse(v.id);
                            _fromDate = DateTime(
                              _currentSelectedYear,
                              _currentSelectedMonth,
                              currentDay,
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: TATypography.paragraph(
                    text: 'Departure date',
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
                          item: departureDay.toString(),
                          id: departureDay.toString(),
                        ),
                        items: List.generate(
                          departureDays.length,
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
                            departureDay = int.parse(v.id);
                            _toDate = DateTime(
                              _currentDepartureSelectedYear,
                              _currentDepartureSelectedMonth,
                              departureDay,
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
                          item: _currentDepartureSelectedMonth.toString(),
                          id: _currentDepartureSelectedMonth.toString(),
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
                              _currentDepartureSelectedMonth = int.parse(v.id);

                              _toDate = DateTime(
                                _currentDepartureSelectedYear,
                                _currentDepartureSelectedMonth,
                                departureDay,
                              );

                              departureDays
                                ..clear()
                                ..addAll(
                                  GlobalFunctions.getDaysInMonth(
                                    month: _currentDepartureSelectedMonth,
                                    year: _currentDepartureSelectedYear,
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
                          item: _currentDepartureSelectedYear.toString(),
                          id: _currentDepartureSelectedYear.toString(),
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
                              _toDate = DateTime(
                                _currentDepartureSelectedYear,
                                _currentDepartureSelectedMonth,
                                departureDay,
                              );
                              _currentDepartureSelectedYear = int.parse(v.id);
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      width: 140,
                      child: Consumer(
                        builder: (context, ref, child) {
                          return TAPrimaryButton(
                            text: 'NEXT',
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

                              if (_fromDate == null) {
                                unawaited(
                                  FailureWidget.build(
                                    title: 'Something went wrong!',
                                    message: 'Please select the arrival date.',
                                    context: context,
                                  ),
                                );
                                return;
                              }
                              if (_toDate == null) {
                                unawaited(
                                  FailureWidget.build(
                                    title: 'Something went wrong!',
                                    message: 'Please select the departure date.',
                                    context: context,
                                  ),
                                );
                                return;
                              }
                              ref.read(travelsControllerProvider.notifier).setTravelHotel(hotel: name.text);
                              ref.read(travelsControllerProvider.notifier).setTravelHotelGoogle(hotelGoogle: googleDescription.text);
                              ref.read(travelsControllerProvider.notifier).setTravelArrivalDate(arrivalDate: _fromDate!.toIso8601String());
                              ref.read(travelsControllerProvider.notifier).setTravelDepartureDate(departureDate: _toDate!.toIso8601String());

                              await widget.pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );

                              /// If theres a file or an image we upload it
                              // if (selectedFile != null || selectedImage != null) {
                              //   File newFile;
                              //   if (selectedFile != null) {
                              //     newFile = selectedFile!;
                              //   } else {
                              //     newFile = File(selectedImage!.path);
                              //   }
                              //   isLoading.value = true;

                              //   /// First upload the file
                              //   final res = await ref.read(travelsLegacyControllerProvider.notifier).uploadFile(file: newFile);

                              //   if (!res.ok && mounted) {
                              //     unawaited(
                              //       FailureWidget.build(
                              //         title: 'Oops',
                              //         message: 'Something went wrong while trying to upload the file',
                              //         context: context,
                              //       ),
                              //     );
                              //   }
                              // }
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

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path!);
      setState(() {
        selectedFile = file;
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    } else {
      // User canceled the picker
    }
  }
}

class _HotelWidget extends StatelessWidget {
  const _HotelWidget({
    required this.hotel,
  });

  final HotelModel hotel;

  @override
  Widget build(BuildContext context) {
    /// The formatted date to display.
    final formattedDate = DateFormat('dd MMM').format(DateTime.parse(hotel.startDate)).toUpperCase();
    final formattedEndDate = DateFormat('dd MMM').format(DateTime.parse(hotel.endDate)).toUpperCase();
    final startDateHour = DateFormat('hh:mm a').format(DateTime.parse(hotel.startDate));
    final endDateHour = DateFormat('hh:mm a').format(DateTime.parse(hotel.endDate));

    /// The formatted day to display.
    final formattedDay = DateFormat('EEEE').format(DateTime.parse(hotel.endDate)).toUpperCase();

    return TAContainer(
      padding: EdgeInsets.zero,
      child: ExpandablePanel(
        collapsed: const SizedBox(),
        theme: const ExpandableThemeData(hasIcon: false),
        header: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(
                Iconsax.house,
                color: TAColors.purple,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TATypography.paragraph(
                    text: hotel.place,
                    fontWeight: FontWeight.w600,
                  ),
                  TATypography.paragraph(
                    text: hotel.reservationCode,
                    color: TAColors.grey1,
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(
                height: 90,
                child: VerticalDivider(),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  TATypography.paragraph(
                    text: formattedDay,
                    color: TAColors.grey1,
                  ),
                  TATypography.paragraph(
                    text: formattedDate,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
        expanded: Column(
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.house),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TATypography.subparagraph(
                                text: 'Start',
                                color: TAColors.grey1,
                              ),
                              TATypography.paragraph(
                                text: formattedDate,
                                fontWeight: FontWeight.w600,
                              ),
                              TATypography.paragraph(
                                text: startDateHour,
                                color: TAColors.grey1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 60),
                      Row(
                        children: [
                          const Icon(Iconsax.house),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TATypography.subparagraph(
                                text: 'End',
                                color: TAColors.grey1,
                              ),
                              TATypography.paragraph(
                                text: formattedEndDate,
                                fontWeight: FontWeight.w600,
                              ),
                              TATypography.paragraph(
                                text: endDateHour,
                                color: TAColors.grey1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Iconsax.people),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TATypography.subparagraph(
                              text: 'Assistants',
                              color: TAColors.grey1,
                            ),
                            ...List.generate(
                              hotel.guests.length,
                              (index) {
                                return TATypography.paragraph(
                                  text: '${hotel.guests[index].firstName} ${hotel.guests[index].lastName}',
                                  fontWeight: FontWeight.w600,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Iconsax.building_4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TATypography.subparagraph(
                              text: 'Location',
                              color: TAColors.grey1,
                            ),
                            TATypography.paragraph(
                              text: hotel.placeDescription,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          openLink('https://www.google.com/maps/place/?q=place_id:${hotel.place}');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: TAColors.purple,
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Iconsax.location,
                            color: TAColors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     const Icon(Iconsax.user_tag),
                  //     const SizedBox(width: 8),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           TATypography.subparagraph(
                  //             text: 'Meeting',
                  //             color: TAColors.grey1,
                  //           ),
                  //           TATypography.paragraph(
                  //             text: 'Doral Campus Academy',
                  //             fontWeight: FontWeight.w600,
                  //           ),
                  //           TATypography.paragraph(
                  //             text: '9025 W Cactus Ave, Las Vegas, NV 89178',
                  //             color: TAColors.grey1,
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border: Border.all(
                  //           color: TAColors.purple,
                  //         ),
                  //       ),
                  //       padding: const EdgeInsets.all(6),
                  //       child: const Icon(
                  //         Iconsax.location,
                  //         color: TAColors.purple,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
