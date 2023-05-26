import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/components/buttons/primary_button.dart';
import 'package:team_aid/design_system/components/container.dart';
import 'package:team_aid/design_system/components/inputs/primary_input.dart';
import 'package:team_aid/design_system/components/typography/typography.dart';
import 'package:team_aid/design_system/utils/colors.dart';

/// The statelessWidget that handles the current screen
class RequestDemoScreen extends StatelessWidget {
  /// The constructor.
  const RequestDemoScreen({super.key});

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
                      text: 'Welcome',
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
                    const SizedBox(height: 10),
                    Stack(
                      children: [
                        TAContainer(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 30),
                              TATypography.paragraph(
                                text:
                                    'If you want to request a demo, please fill in your details and we will give you access to our platform shortly.',
                                color: TAColors.color3,
                              ),
                              const SizedBox(height: 20),
                              const TAPrimaryInput(
                                label: 'Your name',
                                placeholder: 'Enter your name',
                              ),
                              const SizedBox(height: 10),
                              const TAPrimaryInput(
                                label: 'Email',
                                placeholder: 'Enter your email',
                              ),
                              const SizedBox(height: 10),
                              const TAPrimaryInput(
                                label: 'Phone number',
                                placeholder: 'Enter your phone number',
                              ),
                              const SizedBox(height: 10),
                              const TAPrimaryInput(
                                label: 'League or Club',
                                placeholder: 'Enter your league or club',
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(79, 21, 121, 0.1),
                                blurRadius: 22,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            'assets/black-logo.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Switch.adaptive(
                            value: true,
                            activeColor: const Color(0xff586DF4),
                            onChanged: (v) {},
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TATypography.subparagraph(
                              text: 'I agree to terms of service and privacy policy',
                              color: const Color(0xff999999),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TAPrimaryButton(
                        text: 'REQUEST DEMO',
                        height: 50,
                        mainAxisAlignment: MainAxisAlignment.center,
                        onTap: () {},
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
}
