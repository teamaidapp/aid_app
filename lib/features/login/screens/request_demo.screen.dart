import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/entities/request_demo.model.dart';
import 'package:team_aid/core/functions.dart';
import 'package:team_aid/design_system/components/buttons/primary_button.dart';
import 'package:team_aid/design_system/components/container.dart';
import 'package:team_aid/design_system/components/inputs/primary_input.dart';
import 'package:team_aid/design_system/components/typography/typography.dart';
import 'package:team_aid/design_system/utils/colors.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/login/controllers/createAccount.controller.dart';

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
                child: HookBuilder(
                  builder: (context) {
                    final isLoading = useState(false);
                    final nameController = useTextEditingController();
                    final emailController = useTextEditingController();
                    final phoneController = useTextEditingController();
                    final leagueController = useTextEditingController();
                    final agreeTerms = useState(false);
                    return Column(
                      children: [
                        const SizedBox(height: 10),
                        Stack(
                          children: [
                            TAContainer(
                              margin: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 50,
                              ),
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
                                  TAPrimaryInput(
                                    label: 'Your name',
                                    textEditingController: nameController,
                                    placeholder: 'Enter your name',
                                  ),
                                  const SizedBox(height: 10),
                                  TAPrimaryInput(
                                    label: 'Email',
                                    textEditingController: emailController,
                                    placeholder: 'Enter your email',
                                  ),
                                  const SizedBox(height: 10),
                                  TAPrimaryInput(
                                    label: 'Phone number',
                                    textEditingController: phoneController,
                                    placeholder: 'Enter your phone number',
                                    inputListFormatter: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  TAPrimaryInput(
                                    label: 'League or Club',
                                    textEditingController: leagueController,
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
                                value: agreeTerms.value,
                                activeColor: const Color(0xff586DF4),
                                onChanged: (v) {
                                  agreeTerms.value = v;
                                },
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TATypography.subparagraph(
                                  text: 'I agree to terms of service and privacy policy',
                                  color: TAColors.grey1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Consumer(
                            builder: (context, ref, child) {
                              return TAPrimaryButton(
                                text: 'REQUEST DEMO',
                                height: 50,
                                isLoading: isLoading.value,
                                mainAxisAlignment: MainAxisAlignment.center,
                                onTap: () async {
                                  if (nameController.text.isEmpty) {
                                    unawaited(
                                      FailureWidget.build(
                                        title: 'Missing field',
                                        message: 'Please enter your name.',
                                        context: context,
                                      ),
                                    );
                                    return;
                                  }

                                  if (emailController.text.isEmpty) {
                                    unawaited(
                                      FailureWidget.build(
                                        title: 'Missing field',
                                        message: 'Please enter your email.',
                                        context: context,
                                      ),
                                    );
                                    return;
                                  }

                                  if (phoneController.text.isEmpty) {
                                    unawaited(
                                      FailureWidget.build(
                                        title: 'Missing field',
                                        message: 'Please enter your phone number.',
                                        context: context,
                                      ),
                                    );
                                    return;
                                  }

                                  if (leagueController.text.isEmpty) {
                                    unawaited(
                                      FailureWidget.build(
                                        title: 'Missing field',
                                        message: 'Please enter your league or club.',
                                        context: context,
                                      ),
                                    );
                                    return;
                                  }
                                  if (!agreeTerms.value) {
                                    unawaited(
                                      FailureWidget.build(
                                        title: 'Agree to terms of service',
                                        message: 'Please agree to terms of service and privacy policy.',
                                        context: context,
                                      ),
                                    );
                                    return;
                                  }

                                  if (!isValidPhoneNumber(phoneController.text.trim())) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please enter a valid phone number'),
                                      ),
                                    );
                                  }

                                  isLoading.value = true;
                                  final demo = RequestDemoModel(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    leagueOrClub: leagueController.text,
                                  );
                                  final res = await ref
                                      .read(
                                        createAccountControllerProvider.notifier,
                                      )
                                      .requestDemo(demo: demo);
                                  isLoading.value = false;

                                  if (res.ok && context.mounted) {
                                    unawaited(
                                      SuccessWidget.build(
                                        title: 'Thank you!',
                                        message: 'Your request has been sent successfully.',
                                        context: context,
                                      ),
                                    );
                                  } else {
                                    unawaited(
                                      FailureWidget.build(
                                        title: 'Something went wrong!',
                                        message: 'There was an error while sending your request. Please try again.',
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
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
