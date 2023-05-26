import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';

/// The statelessWidget that handles the current screen
class CreateAccountCoachScreen extends StatelessWidget {
  /// The constructor.
  const CreateAccountCoachScreen({super.key});

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
                      text: 'Coach / Admin',
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
                final firstNameController = useTextEditingController();
                final lastNameController = useTextEditingController();
                final emailController = useTextEditingController();
                final phoneNumberController = useTextEditingController();
                final addressController = useTextEditingController();
                final passwordController = useTextEditingController();
                final agreeToTerms = useState(false);
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
                                label: 'First name',
                                textEditingController: firstNameController,
                                placeholder: 'Enter your first name',
                              ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'Last name',
                                textEditingController: lastNameController,
                                placeholder: 'Enter your last name',
                              ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'E-mail',
                                textEditingController: emailController,
                                placeholder: 'Enter your email',
                              ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'Phone number',
                                textEditingController: phoneNumberController,
                                placeholder: 'Enter your phone number',
                              ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'Address',
                                textEditingController: addressController,
                                placeholder: 'Enter your address',
                              ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'Password',
                                textEditingController: passwordController,
                                isPassword: true,
                                placeholder: 'Enter your password',
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Switch.adaptive(
                                value: agreeToTerms.value,
                                activeColor: const Color(0xff586DF4),
                                onChanged: (v) {
                                  agreeToTerms.value = v;
                                },
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
                            text: 'CREATE ACCOUNT',
                            height: 50,
                            mainAxisAlignment: MainAxisAlignment.center,
                            onTap: () {
                              context.push(AppRoutes.createAccountTeam);
                            },
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
