import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/entities/team.model.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/household/widget/child.screen.dart';

/// The statelessWidget that handles the current screen
class HouseholdScreen extends StatelessWidget {
  /// The constructor.
  const HouseholdScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    ChildWidget(
                      team: TeamModel(
                        teamName: 'Team 1',
                        sport: 'Cheerleading',
                        gender: 'Male',
                        organization: 'Organization',
                        country: 'USA',
                        zipCode: '78374',
                        state: 'Michigan',
                        level: 'Middleschool',
                        id: '',
                        city: 'Detroit',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TAPrimaryButton(
                text: 'ADD HOUSEHOLD MEMBER',
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
