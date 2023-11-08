import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/household/controllers/household.controller.dart';
import 'package:team_aid/features/household/widget/child.screen.dart';
import 'package:team_aid/main.dart';

/// The statelessWidget that handles the current screen
class HouseholdScreen extends ConsumerStatefulWidget {
  /// The constructor.
  const HouseholdScreen({super.key});

  @override
  ConsumerState<HouseholdScreen> createState() => _HouseholdScreenState();
}

class _HouseholdScreenState extends ConsumerState<HouseholdScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(householdControllerProvider.notifier).getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final houseHoldList = ref.watch(householdControllerProvider).houseHoldList;
    final prefs = ref.watch(sharedPrefs);
    return Scaffold(
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
                      text: 'Household',
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xffF5F8FB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: houseHoldList.when(
                data: (data) {
                  return prefs.when(
                    data: (prefs) {
                      if (data.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: TATypography.paragraph(
                              text: 'No household members added yet',
                              color: TAColors.purple,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: data.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return ChildWidget(
                              houseHold: data[index],
                              sharedPreferences: prefs,
                            );
                          },
                        );
                      }
                    },
                    error: (_, __) => const SizedBox(),
                    loading: () => const SizedBox(),
                  );
                },
                error: (_, __) => const SizedBox(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TAPrimaryButton(
                text: 'ADD HOUSEHOLD MEMBER',
                height: 50,
                mainAxisAlignment: MainAxisAlignment.center,
                onTap: () {
                  context.push(AppRoutes.createAccountParents);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
