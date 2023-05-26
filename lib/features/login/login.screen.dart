import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/components/buttons/primary_button.dart';
import 'package:team_aid/design_system/components/inputs/primary_input.dart';
import 'package:team_aid/design_system/components/typography/typography.dart';
import 'package:team_aid/design_system/utils/colors.dart';
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TAPrimaryButton(
                      height: 60,
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
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
        TAPrimaryButton(
          text: 'LOGIN',
          mainAxisAlignment: MainAxisAlignment.center,
          onTap: () {},
        ),
        const SizedBox(height: 8),
        Align(
          child: TATypography.paragraph(
            text: 'Forgot your password?',
            color: TAColors.color2,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TATypography.paragraph(
              text: 'Or login with',
              color: TAColors.color3,
            ),
            const SizedBox(width: 14),
            Image.asset('assets/login/google.png', height: 36),
            Image.asset('assets/login/fb.png', height: 36),
          ],
        ),
      ],
    );
  }
}

class _CreateAccountPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final teamPlayerSelected = useState(false);
    return teamPlayerSelected.value
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TATypography.h3(
                      text: 'Team player',
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TeamPlayerWidget(
                    subtitle: 'Under age',
                    title: 'Parents',
                    icon: Iconsax.profile_2user,
                    description: 'School sponsored / Elementary / Middle and High School',
                    onTap: () {
                      context.push(AppRoutes.createAccountParents);
                    },
                  ),
                  const SizedBox(height: 20),
                  TeamPlayerWidget(
                    subtitle: 'Starting college',
                    title: 'Team player',
                    icon: Iconsax.people,
                    description: 'College / Youth Leagues / Athletic Associations / Professional players',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          )
        : Column(
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
                    text: 'Coach / Admin',
                    icon: Iconsax.user,
                    onTap: () {
                      context.push(AppRoutes.createAccountCoach);
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
              const SizedBox(height: 20),
              Align(
                child: TATypography.paragraph(
                  text: 'Free trial for 15 days',
                  color: TAColors.color2,
                ),
              ),
            ],
          );
  }
}

class _RegisterOptionWidget extends StatelessWidget {
  const _RegisterOptionWidget({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;

  final String text;

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
            child: Icon(
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
          )
        ],
      ),
    );
  }
}
