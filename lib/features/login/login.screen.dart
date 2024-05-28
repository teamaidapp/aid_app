import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/components/buttons/primary_button.dart';
import 'package:team_aid/design_system/components/inputs/primary_input.dart';
import 'package:team_aid/design_system/components/typography/typography.dart';
import 'package:team_aid/design_system/utils/colors.dart';
import 'package:team_aid/features/login/controllers/login.controller.dart';
import 'package:team_aid/features/login/widgets/team_player.widget.dart';

/// The statelessWidget that handles the current screen
class LoginScreen extends HookWidget {
  /// The constructor.
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final launchAnimation = useState(false);
    final isLoginScreen = useState(true);

    return Scaffold(
      body: Container(
        height: 200.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!launchAnimation.value)
              Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    'assets/white-logo.png',
                    height: 20.h,
                  ),
                  const SizedBox(height: 20),
                  TATypography.h2(
                    text: 'Grow your team',
                    color: Colors.white,
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Device.screenType == ScreenType.desktop ? 120 : 20),
                    child: TAPrimaryButton(
                      height: Device.screenType == ScreenType.desktop ? 90 : 60,
                      text: 'GET STARTED',
                      icon: Iconsax.arrow_right_2,
                      onTap: () {
                        launchAnimation.value = true;
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            IgnorePointer(
              ignoring: !launchAnimation.value,
              child: FadeInUp(
                animate: launchAnimation.value,
                duration: const Duration(milliseconds: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: const Color(0xffF4F8FB),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      // padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 30),
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 30,
                        bottom: 20,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: isLoginScreen.value ? _LoginPage() : _CreateAccountPage(),
                      ),
                    ),
                    Container(
                      width: 75.w,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(28),
                          bottomLeft: Radius.circular(28),
                        ),
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              isLoginScreen.value = true;
                            },
                            behavior: HitTestBehavior.translucent,
                            child: TATypography.paragraph(
                              text: 'LOGIN',
                              color: isLoginScreen.value ? Colors.white : Colors.white.withOpacity(0.25),
                            ),
                          ),
                          TATypography.paragraph(
                            text: '|',
                            color: Colors.white,
                          ),
                          GestureDetector(
                            onTap: () {
                              isLoginScreen.value = false;
                            },
                            behavior: HitTestBehavior.translucent,
                            child: TATypography.paragraph(
                              text: 'SIGN UP',
                              color: !isLoginScreen.value ? Colors.white : Colors.white.withOpacity(0.25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TATypography.h3(
          text: 'Welcome back',
          color: TAColors.textColor,
        ),
        const SizedBox(height: 8),
        TATypography.paragraph(
          text: 'Sign in with your account',
          color: TAColors.color3,
        ),
        const SizedBox(height: 20),
        TAPrimaryInput(
          label: 'Email',
          textEditingController: emailController,
          placeholder: 'Enter your email',
        ),
        const SizedBox(height: 8),
        TAPrimaryInput(
          label: 'Password',
          textEditingController: passwordController,
          isPassword: true,
          placeholder: 'Enter your password',
        ),
        const SizedBox(height: 20),
        HookConsumer(
          builder: (context, ref, child) {
            final isLoading = useState(false);
            return TAPrimaryButton(
              text: 'LOGIN',
              isLoading: isLoading.value,
              mainAxisAlignment: MainAxisAlignment.center,
              onTap: () async {
                if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Complete all fields'),
                    ),
                  );
                  return;
                }
                isLoading.value = true;
                final res = await ref.read(loginControllerProvider.notifier).login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                isLoading.value = false;
                if (res.ok && context.mounted) {
                  context.go(AppRoutes.home);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(res.message),
                    ),
                  );
                }
              },
            );
          },
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: Colors.white,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, changeState) {
                    return HookBuilder(
                      builder: (mcontext) {
                        final controller = usePageController();
                        final emailForgotController = useTextEditingController();
                        final otpController = useTextEditingController();
                        final passwordController = useTextEditingController();
                        final error = useState('');
                        final isLoading = useState(false);
                        final height = useState(32.h);

                        return Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: SafeArea(
                            bottom: false,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: height.value,
                                child: PageView(
                                  controller: controller,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TATypography.h3(
                                              text: 'Enter your email',
                                              fontWeight: FontWeight.w700,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                context.pop();
                                              },
                                              child: const Icon(Iconsax.close_circle, color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        TATypography.paragraph(
                                          text: 'If the email exists, we will send you an OTP to reset your password',
                                          color: TAColors.color2,
                                        ),
                                        const SizedBox(height: 20),
                                        TAPrimaryInput(
                                          label: 'Email',
                                          textEditingController: emailForgotController,
                                          placeholder: 'Enter your email',
                                        ),
                                        if (error.value.isNotEmpty)
                                          TATypography.subparagraph(
                                            text: error.value,
                                            color: Colors.red,
                                          ),
                                        const SizedBox(height: 20),
                                        Consumer(
                                          builder: (context, ref, child) {
                                            return TAPrimaryButton(
                                              text: 'Send',
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              isLoading: isLoading.value,
                                              isDisabled: isLoading.value,
                                              onTap: () async {
                                                if (emailForgotController.text.isEmpty) {
                                                  error.value = 'Enter your email';
                                                  return;
                                                }
                                                isLoading.value = true;
                                                final res = await ref.read(loginControllerProvider.notifier).sendForgotEmail(
                                                      email: emailForgotController.text.trim(),
                                                    );
                                                isLoading.value = false;
                                                if (res.ok) {
                                                  error.value = '';
                                                  height.value = 50.h;
                                                  unawaited(
                                                    controller.nextPage(
                                                      duration: const Duration(milliseconds: 400),
                                                      curve: Curves.easeInOut,
                                                    ),
                                                  );
                                                } else {
                                                  error.value = 'There was an error sending the email, try again later';
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TATypography.h3(
                                              text: 'Enter the OTP code',
                                              fontWeight: FontWeight.w700,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                context.pop();
                                              },
                                              child: const Icon(Iconsax.close_circle, color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        TATypography.paragraph(
                                          text: 'Enter the code sent to your email',
                                          color: TAColors.color2,
                                        ),
                                        const SizedBox(height: 20),
                                        TAPrimaryInput(
                                          label: 'OTP code',
                                          textEditingController: otpController,
                                          placeholder: 'Enter the code',
                                        ),
                                        const SizedBox(height: 10),
                                        TAPrimaryInput(
                                          label: 'New password',
                                          textEditingController: passwordController,
                                          placeholder: 'Enter the password',
                                        ),
                                        if (error.value.isNotEmpty)
                                          TATypography.subparagraph(
                                            text: error.value,
                                            color: Colors.red,
                                          ),
                                        const SizedBox(height: 20),
                                        Consumer(
                                          builder: (context, ref, child) {
                                            return TAPrimaryButton(
                                              text: 'Verify',
                                              isLoading: isLoading.value,
                                              isDisabled: isLoading.value,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              onTap: () async {
                                                if (otpController.text.isEmpty) {
                                                  error.value = 'Enter the OTP sent to your email.';
                                                  return;
                                                }
                                                if (passwordController.text.isEmpty) {
                                                  error.value = 'Enter your new password.';
                                                  return;
                                                }

                                                isLoading.value = true;
                                                final res = await ref.read(loginControllerProvider.notifier).recoverPassword(
                                                      email: emailForgotController.text.trim(),
                                                      otp: otpController.text,
                                                      password: passwordController.text,
                                                    );
                                                isLoading.value = false;
                                                if (!context.mounted) return;
                                                if (res.ok) {
                                                  context.pop();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('The passwords has been restored.'),
                                                    ),
                                                  );
                                                } else {
                                                  error.value = 'There was an error sending the email, try again later';
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
          child: Align(
            child: TATypography.paragraph(
              text: 'Forgot your password?',
              color: TAColors.color2,
            ),
          ),
        ),
        // const SizedBox(height: 20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     TATypography.paragraph(
        //       text: 'Or login with',
        //       color: TAColors.color3,
        //     ),
        //     const SizedBox(width: 14),
        //     Image.asset('assets/login/google.png', height: 36),
        //     Image.asset('assets/login/fb.png', height: 36),
        //   ],
        // ),
      ],
    );
  }
}

class _CreateAccountPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final teamPlayerSelected = useState(false);
    final coachOrAdminSelected = useState(false);
    return Column(
      children: [
        if (teamPlayerSelected.value)
          TeamPlayerMenuWidget(teamPlayerSelected: teamPlayerSelected)
        else if (coachOrAdminSelected.value)
          CoachOrAdminWidget(coachOrAdminSelected: coachOrAdminSelected)
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TATypography.h3(
                      text: 'Create account',
                      color: TAColors.textColor,
                    ),
                    const SizedBox(height: 8),
                    TATypography.paragraph(
                      text: 'Who are you?',
                      color: TAColors.color3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _RegisterOptionWidget(
                    text: 'Coach / Org',
                    icon: Iconsax.user,
                    path: 'assets/whistle.png',
                    onTap: () {
                      // context.push(AppRoutes.createAccountCoach);
                      coachOrAdminSelected.value = true;
                    },
                  ),
                  const SizedBox(width: 14),
                  _RegisterOptionWidget(
                    text: 'Team player',
                    icon: Iconsax.people,
                    onTap: () {
                      teamPlayerSelected.value = true;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TAPrimaryButton(
                text: 'REQUEST A FREE DEMO',
                mainAxisAlignment: MainAxisAlignment.center,
                onTap: () {
                  context.push(AppRoutes.requestDemo);
                },
              ),
              const SizedBox(height: 4),
              Align(
                child: TATypography.paragraph(
                  text: 'For your League or Club',
                  color: TAColors.textColor,
                ),
              ),
              // const SizedBox(height: 20),
              // Align(
              //   child: TATypography.paragraph(
              //     text: 'Free trial for 15 days',
              //     color: TAColors.color2,
              //   ),
              // ),
            ],
          ),
      ],
    );
  }
}

class CoachOrAdminWidget extends StatelessWidget {
  /// Constructor
  const CoachOrAdminWidget({
    required this.coachOrAdminSelected,
    super.key,
  });

  final ValueNotifier<bool> coachOrAdminSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TATypography.h3(
                text: 'Organization',
                color: TAColors.textColor,
              ),
              const SizedBox(height: 8),
              TATypography.paragraph(
                text: 'Choose your profile',
                color: TAColors.color3,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _RegisterOptionWidget(
              text: 'Organization',
              subtitle: 'Create organization',
              icon: Iconsax.user,
              path: 'assets/admin.png',
              onTap: () {
                context.pushNamed(
                  AppRoutes.createAccountCoach,
                  queryParameters: {'isAdmin': 'true'},
                );
              },
            ),
            const SizedBox(width: 14),
            _RegisterOptionWidget(
              text: 'Coach',
              subtitle: '',
              icon: Iconsax.people,
              path: 'assets/whistle.png',
              onTap: () {
                context.pushNamed(
                  AppRoutes.createAccountCoach,
                  queryParameters: {'isAdmin': 'false'},
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 40),
        GestureDetector(
          onTap: () {
            coachOrAdminSelected.value = false;
          },
          child: Align(
            child: TATypography.paragraph(
              text: 'Go to back',
              underline: true,
              color: TAColors.textColor,
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class TeamPlayerMenuWidget extends StatelessWidget {
  const TeamPlayerMenuWidget({
    required this.teamPlayerSelected,
    super.key,
  });

  final ValueNotifier<bool> teamPlayerSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TATypography.h3(
                  text: 'Team player',
                  color: TAColors.textColor,
                ),
                GestureDetector(
                  onTap: () {
                    teamPlayerSelected.value = false;
                  },
                  child: const Icon(Iconsax.close_circle),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TATypography.paragraph(
              text: 'Choose your profile',
              color: TAColors.color3,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _RegisterOptionWidget(
              text: 'Parents',
              subtitle: 'Under age',
              icon: Iconsax.user,
              path: 'assets/admin.png',
              onTap: () {
                context.pushNamed(
                  AppRoutes.createAccountTeamPlayer,
                  queryParameters: {
                    'isCreatingSon': 'true',
                  },
                );
              },
            ),
            const SizedBox(width: 14),
            _RegisterOptionWidget(
              text: 'Team Player',
              subtitle: '',
              icon: Iconsax.people5,
              onTap: () {
                context.pushNamed(
                  AppRoutes.createAccountTeamPlayer,
                  queryParameters: {
                    'isCreatingSon': 'false',
                  },
                );
              },
            ),
          ],
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     TeamPlayerWidget(
        //       subtitle: 'Under age',
        //       title: 'Parents',
        //       icon: Iconsax.profile_2user,
        //       description: 'School sponsored / Elementary / Middle and High School',
        //       onTap: () {
        //         context.pushNamed(
        //           AppRoutes.createAccountTeamPlayer,
        //           queryParameters: {
        //             'isCreatingSon': 'true',
        //           },
        //         );
        //       },
        //     ),
        //     const SizedBox(height: 20),
        //     TeamPlayerWidget(
        //       subtitle: 'Starting college',
        //       title: 'Team player',
        //       icon: Iconsax.people,
        //       description: 'College / Youth Leagues / Athletic Associations / Professional players',
        //       onTap: () {
        //         context.pushNamed(
        //           AppRoutes.createAccountTeamPlayer,
        //           queryParameters: {
        //             'isCreatingSon': 'false',
        //           },
        //         );
        //       },
        //     ),
        //   ],
        // ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _RegisterOptionWidget extends StatelessWidget {
  const _RegisterOptionWidget({
    required this.icon,
    required this.text,
    required this.onTap,
    this.subtitle,
    this.path,
  });

  final IconData icon;

  final String? path;

  final String text;

  final String? subtitle;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            height: 128,
            width: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffF4F8FB),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff4F5B79).withOpacity(0.1),
                  blurRadius: 22,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: path != null
                ? Image.asset(path!)
                : Icon(
                    icon,
                    size: 54,
                    color: const Color(0xff496CF1),
                  ),
          ),
          const SizedBox(height: 16),
          TATypography.paragraph(
            text: text,
            fontWeight: FontWeight.w600,
            color: TAColors.textColor,
          ),
          if (subtitle != null)
            TATypography.subparagraph(
              text: subtitle!,
              color: TAColors.grey1,
            ),
        ],
      ),
    );
  }
}
