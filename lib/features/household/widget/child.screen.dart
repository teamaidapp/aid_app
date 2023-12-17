import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/extensions.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/household/controllers/household.controller.dart';
import 'package:team_aid/features/household/entities/household.model.dart';

/// The statelessWidget that handles the current screen
class ChildWidget extends StatelessWidget {
  /// The constructor.
  const ChildWidget({
    required this.houseHold,
    required this.sharedPreferences,
    super.key,
  });

  /// The team model.
  final HouseholdModel houseHold;

  /// The shared preferences.
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return TAContainer(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Iconsax.profile_2user5,
                color: TAColors.purple,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TATypography.paragraph(
                    text: '${houseHold.userId.firstName} ${houseHold.userId.lastName}',
                    color: TAColors.textColor,
                    fontWeight: FontWeight.w700,
                  ),
                  TATypography.paragraph(
                    text: houseHold.userId.email,
                    color: TAColors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                  TATypography.paragraph(
                    text: houseHold.userId.email,
                    color: TAColors.purple,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.white,
                    // barrierColor: Colors.white.withOpacity(0.8),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    builder: (context) {
                      return Wrap(
                        children: [
                          HookBuilder(
                            builder: (context) {
                              final isLoading = useState(false);
                              final isDeleting = useState(false);
                              return SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Stack(
                                    children: [
                                      Align(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(Iconsax.like_1, color: Colors.white, size: 40),
                                            TATypography.h3(
                                              text: 'Options',
                                              fontWeight: FontWeight.w700,
                                            ),
                                            SizedBox(height: 2.h),
                                            TATypography.paragraph(
                                              text: isDeleting.value
                                                  ? 'Are you sure that you want to remove the member of your household?'
                                                  : 'You can edit information of your household member or remove',
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 2.h),
                                            if (!isDeleting.value)
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TAPrimaryButton(
                                                      text: 'REMOVE',
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      onTap: () {
                                                        isDeleting.value = true;
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 18),
                                                  Expanded(
                                                    child: TAPrimaryButton(
                                                      text: 'EDIT',
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        context.push(AppRoutes.editHousehold, extra: houseHold);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            else
                                              Consumer(
                                                builder: (context, ref, child) {
                                                  return TAPrimaryButton(
                                                    text: 'REMOVE',
                                                    isLoading: isLoading.value,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    onTap: () async {
                                                      if (isLoading.value) return;
                                                      isLoading.value = true;
                                                      final response = await ref.read(householdControllerProvider.notifier).deleteHousehold(
                                                            id: houseHold.userId.id,
                                                          );
                                                      await ref.read(householdControllerProvider.notifier).getData();
                                                      isLoading.value = false;
                                                      if (!context.mounted) return;
                                                      if (response.ok) {
                                                        await SuccessWidget.build(
                                                          title: 'Member removed',
                                                          message: 'Your member has been removed of your household',
                                                          context: context,
                                                        );
                                                        if (context.mounted) {
                                                          context.pop();
                                                        }
                                                      } else {
                                                        unawaited(
                                                          FailureWidget.build(
                                                            title: 'Error',
                                                            message: 'There was an error deleting the household',
                                                            context: context,
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  );
                                                },
                                              ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 20,
                                        child: GestureDetector(
                                          onTap: () {
                                            context.pop();
                                          },
                                          child: const Icon(Iconsax.close_circle, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(
                  Iconsax.edit_2,
                  color: TAColors.textColor,
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                TATypography.paragraph(
                  text: 'Parent: ',
                  color: TAColors.color1,
                ),
                TATypography.paragraph(
                  text: (sharedPreferences.getString(TAConstants.firstName) ?? '').capitalizeWord(),
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TAPrimaryButton(
                  text: 'VIEW SCHEDULE',
                  mainAxisAlignment: MainAxisAlignment.center,
                  padding: EdgeInsets.zero,
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.calendar,
                      queryParameters: {
                        'addToCalendar': 'false',
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TAPrimaryButton(
                  text: 'ADD TO CALENDAR',
                  padding: EdgeInsets.zero,
                  mainAxisAlignment: MainAxisAlignment.center,
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.calendar,
                      queryParameters: {
                        'addToCalendar': 'true',
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
