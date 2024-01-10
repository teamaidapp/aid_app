import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/extensions.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/calendar/controllers/calendar.controller.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/messages/controllers/messages.controller.dart';
import 'package:team_aid/features/teams/controllers/teams.controller.dart';
import 'package:team_aid/features/teams/entities/contact.model.dart';

/// The statelessWidget that handles the current screen
class ContactsListScreen extends ConsumerStatefulWidget {
  /// The constructor.
  const ContactsListScreen({
    required this.teamId,
    required this.teamName,
    required this.action,
    super.key,
  });

  /// The team id.
  final String teamId;

  /// The team name.
  final String teamName;

  /// The is sharing calendar.
  final String action;

  @override
  ConsumerState<ContactsListScreen> createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends ConsumerState<ContactsListScreen> {
  TADropdownModel? selectedValue;

  @override
  void initState() {
    getContactList(id: widget.teamId);
    selectedValue = TADropdownModel(
      item: widget.teamName,
      id: widget.teamId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final teams = ref.watch(homeControllerProvider).userTeams;
    final contactList = ref.watch(teamsControllerProvider).contactList;
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
                      text: 'Contact List',
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TAContainer(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: teams.when(
                        data: (data) {
                          return TADropdown(
                            label: 'Team',
                            placeholder: 'Select a team',
                            selectedValue: selectedValue,
                            items: List.generate(
                              data.length,
                              (index) => TADropdownModel(
                                item: data[index].teamName,
                                id: data[index].id,
                              ),
                            ),
                            onChange: (selectedValue) {
                              if (selectedValue != null) {
                                getContactList(id: selectedValue.id);
                              }
                            },
                          );
                        },
                        error: (e, s) => const SizedBox(),
                        loading: () => const SizedBox(),
                      ),
                    ),
                    TAContainer(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: contactList.when(
                        data: (data) {
                          if (data.isEmpty) {
                            return const Center(
                              child: Text('Selected team has no contacts'),
                            );
                          } else {
                            return SizedBox(
                              height: 70.h,
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: SearchableList<ContactModel>(
                                  initialList: data,
                                  style: GoogleFonts.poppins(
                                    color: TAColors.textColor,
                                  ),
                                  builder: (ContactModel user) {
                                    return GestureDetector(
                                      onTap: () async {
                                        if (widget.action == 'isSharingCalendar') {
                                          final result = await ref.read(calendarControllerProvider.notifier).shareCalendar(
                                                email: user.user.id,
                                              );

                                          if (!context.mounted) return;

                                          if (result.ok) {
                                            await SuccessWidget.build(
                                              title: 'Success',
                                              message: 'Calendar shared successfully',
                                              context: context,
                                            );
                                            if (mounted) {
                                              context.pop();
                                            }
                                          } else {
                                            unawaited(
                                              FailureWidget.build(
                                                title: 'Error',
                                                message: result.message,
                                                context: context,
                                              ),
                                            );
                                          }
                                        } else if (widget.action == 'call') {
                                          try {
                                            await FlutterPhoneDirectCaller.callNumber(
                                              user.user.phoneNumber,
                                            );
                                            if (!context.mounted) return;
                                          } catch (e) {
                                            unawaited(
                                              FailureWidget.build(
                                                title: 'Error',
                                                message: "The call wasn't placed",
                                                context: context,
                                              ),
                                            );
                                          }
                                        } else {
                                          final id = '${user.user.id};${user.user.firstName.capitalize()} ${user.user.lastName.capitalize()}';
                                          ref.read(messagesControllerProvider.notifier).setToId(id);
                                          context.pop();
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Iconsax.user,
                                              color: TAColors.purple,
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  TATypography.paragraph(
                                                    text: '${user.user.firstName.capitalize()} ${user.user.lastName.capitalize()}',
                                                    color: TAColors.textColor,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  TATypography.paragraph(
                                                    text: user.user.role,
                                                    color: TAColors.textColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              selectIcon(widget.action),
                                              color: TAColors.purple,
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  filter: (value) => data
                                      .where(
                                        (element) => element.user.firstName.toLowerCase().contains(value),
                                      )
                                      .toList(),
                                  emptyWidget: const Center(
                                    child: Text('Selected team has no contacts'),
                                  ),
                                  displayClearIcon: false,
                                  cursorColor: TAColors.purple,
                                  inputDecoration: InputDecoration(
                                    filled: true,
                                    prefixIcon: const Icon(
                                      Iconsax.sms_search,
                                      color: TAColors.color1,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w,
                                      vertical: 1.5.h,
                                    ),
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: TAColors.color1.withOpacity(0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    labelStyle: GoogleFonts.poppins(
                                      color: TAColors.color1,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: TAColors.color1.withOpacity(0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Search...',
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        error: (error, stackTrace) => Center(
                          child: Text(
                            error.toString(),
                          ),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData selectIcon(String action) {
    switch (action) {
      case 'message':
        return Iconsax.add_circle;
      case 'isSharingCalendar':
        return Iconsax.share;
      case 'call':
        return Iconsax.call_calling;
      default:
        return Iconsax.user;
    }
  }

  Future<void> getContactList({required String id}) {
    return ref.read(teamsControllerProvider.notifier).getContactList(teamId: id);
  }
}
