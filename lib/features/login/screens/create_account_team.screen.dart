import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/components/inputs/dropdown_input.dart';
import 'package:team_aid/design_system/design_system.dart';

/// The statelessWidget that handles the current screen
class CreateAccountTeamScreen extends StatelessWidget {
  /// The constructor.
  const CreateAccountTeamScreen({super.key});

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
                      text: 'Create a team',
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
            child: HookBuilder(
              builder: (context) {
                final teamNameController = useTextEditingController();
                final sportController = useTextEditingController();
                final ageGroupController = useTextEditingController();
                final genderController = useTextEditingController();
                final organizationController = useTextEditingController();
                final countryController = useTextEditingController();

                return Container(
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TAPrimaryInput(
                                label: 'Team name',
                                textEditingController: teamNameController,
                                placeholder: 'Enter your team name',
                              ),
                              const SizedBox(height: 10),
                              TADropdown(
                                label: 'Sport',
                                textEditingController: sportController,
                                placeholder: 'Select your sport',
                                items: const [
                                  'Football',
                                  'Basketball',
                                  'Volleyball',
                                ],
                              ),
                              const SizedBox(height: 10),
                              TADropdown(
                                label: 'Age group',
                                textEditingController: ageGroupController,
                                placeholder: 'Select age group',
                                items: const ['U-12', 'U-14', 'U-16', 'U-18'],
                              ),
                              const SizedBox(height: 10),
                              TADropdown(
                                label: 'Select gender',
                                textEditingController: genderController,
                                placeholder: 'Select gender',
                                items: const [
                                  'Men',
                                  'Woman',
                                ],
                              ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'Organization',
                                textEditingController: organizationController,
                                placeholder: 'Enter your organization',
                              ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'Country',
                                textEditingController: countryController,
                                placeholder: 'Enter your country',
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 2,
                                child: TATypography.paragraph(
                                  text: 'Skip',
                                  underline: true,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TAPrimaryButton(
                                  text: 'CREATE TEAM',
                                  height: 50,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
