import 'dart:async';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/core/functions.dart';
import 'package:team_aid/design_system/components/inputs/multi_dropdown.dart';
import 'package:team_aid/design_system/components/inputs/time_picker.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/calendar/entities/hour.model.dart';
import 'package:team_aid/features/common/functions/global_functions.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/location.widget.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/travels-legacy/controllers/travels-legacy.controller.dart';
import 'package:team_aid/features/travels-legacy/entities/itinerary.model.dart';

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
  final fromHours = <HourModel>[];
  final tohours = <HourModel>[];
  final days = <DateTime>[];
  final months = <String>[];
  final years = <String>[];
  final currentDay = DateTime.now().day;
  var _currentSelectedMonth = DateTime.now().month;
  var _currentSelectedYear = DateTime.now().year;

  DateTime? _fromDate;
  DateTime? _toDate;

  final fileExpandableController = ExpandableController(initialExpanded: false);
  File? selectedFile;
  XFile? selectedImage;

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
    years.addAll(
      ['2023', '2024', '2025', '2026', '2027'],
    );
    months.addAll(GlobalFunctions.aheadMonths(_currentSelectedYear));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final teamId = useState('');
    final showItineraries = useState(true);
    final locationDescription = useState('');
    final isLoading = useState(false);
    final transportation = useState('');
    final eventName = useTextEditingController();
    final locationController = useTextEditingController();
    final teams = ref.watch(homeControllerProvider).userTeams;
    final guests = ref.watch(travelsLegacyControllerProvider).contactList;
    final itineraries = ref.watch(travelsLegacyControllerProvider).itineraryList;
    final selectedGuests = useState(<TADropdownModel>[]);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 140,
              child: GestureDetector(
                key: const Key('add_itineraries'),
                onTap: () {
                  showItineraries.value = false;
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: !showItineraries.value ? TAColors.purple : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: TATypography.paragraph(
                      text: 'Add itinerary',
                      key: const Key('add_itinerary_title'),
                      color: !showItineraries.value ? Colors.white : const Color(0x0D253C4D).withOpacity(0.3),
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
                key: const Key('show_itineraries'),
                onTap: () {
                  showItineraries.value = true;
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: showItineraries.value ? TAColors.purple : Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: TATypography.paragraph(
                      text: 'View itineraries',
                      color: showItineraries.value ? Colors.white : const Color(0x0D253C4D).withOpacity(0.3),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (showItineraries.value)
          Expanded(
            child: itineraries.when(
              data: (data) {
                if (data.isEmpty) {
                  return Center(
                    child: TATypography.paragraph(
                      text: 'No itineraries added yet',
                      color: TAColors.purple,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          _ItineraryWidget(
                            itinerary: data[index],
                          ),
                          const SizedBox(height: 10),
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
                  child: CircularProgressIndicator(),
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
                        Row(
                          children: [
                            Expanded(
                              child: TATimePicker(
                                label: 'Start',
                                pickedDate: _fromDate,
                                cupertinoDatePickerMode: CupertinoDatePickerMode.date,
                                onChanged: (date) {
                                  setState(() {
                                    _fromDate = date;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: TATimePicker(
                                label: 'End',
                                pickedDate: _toDate,
                                cupertinoDatePickerMode: CupertinoDatePickerMode.date,
                                hourFrom: _toDate != null ? _fromDate!.hour + 1 : null,
                                onChanged: (date) {
                                  setState(() {
                                    _toDate = date;
                                  });
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
                        // TAPrimaryInput(
                        //   placeholder: '',
                        //   textEditingController: guestController,
                        //   label: 'Guest',
                        // ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TAContainer(
                    child: ExpandablePanel(
                      controller: fileExpandableController,
                      header: TATypography.h3(
                        text: 'Add a file',
                        color: TAColors.textColor,
                      ),
                      collapsed: const SizedBox(),
                      expanded: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TATypography.paragraph(
                              text: 'Choose file from:',
                              color: TAColors.color2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: pickFile,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Iconsax.document_upload,
                                      size: 20,
                                      color: TAColors.purple,
                                    ),
                                    const SizedBox(width: 10),
                                    TATypography.paragraph(
                                      text: 'Files',
                                      color: TAColors.purple,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: pickImage,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Iconsax.gallery_export,
                                      size: 20,
                                      color: TAColors.purple,
                                    ),
                                    const SizedBox(width: 10),
                                    TATypography.paragraph(
                                      text: 'Gallery',
                                      color: TAColors.purple,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 20),
                          if (selectedFile != null || selectedImage != null)
                            Row(
                              children: [
                                const Icon(
                                  Iconsax.document_upload,
                                  size: 20,
                                  color: TAColors.purple,
                                ),
                                const SizedBox(width: 10),
                                if (selectedFile != null)
                                  Expanded(
                                    child: TATypography.paragraph(
                                      text: selectedFile!.path.split('/').last,
                                      color: TAColors.color2,
                                    ),
                                  ),
                                if (selectedImage != null)
                                  Expanded(
                                    child: TATypography.paragraph(
                                      text: selectedImage!.path.split('/').last,
                                      color: TAColors.color2,
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
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
                        width: 130,
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

                                /// If theres a file or an image we upload it
                                if (selectedFile != null || selectedImage != null) {
                                  File newFile;
                                  if (selectedFile != null) {
                                    newFile = selectedFile!;
                                  } else {
                                    newFile = File(selectedImage!.path);
                                  }
                                  isLoading.value = true;

                                  /// First upload the file
                                  final res = await ref.read(travelsLegacyControllerProvider.notifier).uploadFile(file: newFile);

                                  if (!res.ok && mounted) {
                                    unawaited(
                                      FailureWidget.build(
                                        title: 'Oops',
                                        message: 'Something went wrong while trying to upload the file',
                                        context: context,
                                      ),
                                    );
                                  }
                                }

                                final newGuests = <Guest>[];

                                for (final guest in selectedGuests.value) {
                                  newGuests.add(Guest(userId: guest.id));
                                }

                                String? fileId = ref.read(travelsLegacyControllerProvider).fileId;

                                if (fileId.isEmpty) {
                                  fileId = null;
                                }

                                final itinerary = ItineraryLegacyModel(
                                  guests: newGuests,
                                  name: eventName.text.trim(),
                                  endDate: _toDate!.toIso8601String(),
                                  startDate: _fromDate!.toIso8601String(),
                                  transportation: transportation.value,
                                  location: locationController.text.trim(),
                                  locationDescription: locationDescription.value,
                                  fileId: fileId,
                                );

                                isLoading.value = true;
                                final res = await ref.read(travelsLegacyControllerProvider.notifier).addItinerary(itinerary: itinerary);
                                isLoading.value = false;

                                if (res.ok && mounted) {
                                  ref.read(travelsLegacyControllerProvider.notifier).setFileId(fileId: '');
                                  await widget.pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                  // await SuccessWidget.build(
                                  //   title: 'Success!',
                                  //   message: 'Itinerary has been added successfully.',
                                  //   context: context,
                                  // );
                                  // if (context.mounted) {
                                  //   context.pop();
                                  // }
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
          ),
      ],
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

class _ItineraryWidget extends StatelessWidget {
  const _ItineraryWidget({
    required this.itinerary,
  });

  final ItineraryLegacyModel itinerary;

  @override
  Widget build(BuildContext context) {
    /// The formatted date to display.
    final formattedDate = DateFormat('dd MMM').format(DateTime.parse(itinerary.startDate)).toUpperCase();
    final formattedEndDate = DateFormat('dd MMM').format(DateTime.parse(itinerary.endDate)).toUpperCase();
    final startDateHour = DateFormat('hh:mm a').format(DateTime.parse(itinerary.startDate));
    final endDateHour = DateFormat('hh:mm a').format(DateTime.parse(itinerary.endDate));

    /// The formatted day to display.
    final formattedDay = DateFormat('EE').format(DateTime.parse(itinerary.endDate)).toUpperCase();

    return TAContainer(
      padding: EdgeInsets.zero,
      child: ExpandablePanel(
        collapsed: const SizedBox(),
        theme: const ExpandableThemeData(hasIcon: false),
        header: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                itinerary.transportation == 'Airplane' ? Iconsax.airplane5 : Iconsax.bus5,
                color: TAColors.purple,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TATypography.paragraph(
                      text: itinerary.name,
                      fontWeight: FontWeight.w600,
                    ),
                    TATypography.paragraph(
                      text: itinerary.transportation,
                      color: TAColors.grey1,
                    ),
                  ],
                ),
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
                          Icon(itinerary.transportation == 'Airplane' ? Iconsax.airplane5 : Iconsax.bus),
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
                          Icon(itinerary.transportation == 'Airplane' ? Iconsax.airplane5 : Iconsax.bus),
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
                              itinerary.guests.length,
                              (index) {
                                return TATypography.paragraph(
                                  text: '${itinerary.guests[index].firstName} ${itinerary.guests[index].lastName}',
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
                              text: itinerary.locationDescription,
                              fontWeight: FontWeight.w600,
                            ),
                            // TATypography.paragraph(
                            //   text: itinerary.locationDescription,
                            //   color: TAColors.grey1,
                            // ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          openLink('https://www.google.com/maps/place/?q=place_id:${itinerary.location}');
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
                  if (itinerary.userCreator != null)
                    Column(
                      children: [
                        TATypography.paragraph(
                          text: 'Organized by ',
                          color: TAColors.grey1,
                        ),
                        TATypography.paragraph(
                          text: '${itinerary.userCreator!.firstName} ${itinerary.userCreator!.lastName}',
                          underline: true,
                          color: TAColors.grey1,
                        ),
                        const SizedBox(height: 10),
                      ],
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
