import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/enums/role.enum.dart';
import 'package:team_aid/core/functions.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/home/controllers/add_player.controller.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';

/// The statelessWidget that handles the current screen
class AddCoachScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const AddCoachScreen({super.key});

  @override
  ConsumerState<AddCoachScreen> createState() => _AddCoachScreenState();
}

class _AddCoachScreenState extends ConsumerState<AddCoachScreen> {
  @override
  void initState() {
    ref.read(homeControllerProvider.notifier).getUserTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTeamId = useState('');
    final isLoading = useState(false);
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final teams = ref.watch(homeControllerProvider).userTeams;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 10),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  TATypography.h3(
                    text: 'Add team coach',
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
                            items: List.generate(
                              data.length,
                              (index) => TADropdownModel(
                                item: data[index].teamName,
                                id: data[index].id,
                              ),
                            ),
                            onChange: (selectedValue) {
                              if (selectedValue != null) {
                                selectedTeamId.value = selectedValue.id;
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TAPrimaryInput(
                            label: 'Email',
                            placeholder: 'Enter the coach email',
                            textEditingController: emailController,
                          ),
                          const SizedBox(height: 10),
                          TAPrimaryInput(
                            label: 'Phone Number',
                            placeholder: 'Enter the coach phone number',
                            textEditingController: phoneController,
                            inputListFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(12),
                              PhoneInputFormatter(defaultCountryCode: 'US')
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TAPrimaryButton(
                        text: 'ADD COACH',
                        height: 50,
                        mainAxisAlignment: MainAxisAlignment.center,
                        isLoading: isLoading.value,
                        onTap: () async {
                          if (selectedTeamId.value.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select the team'),
                              ),
                            );
                            return;
                          }
                          if (emailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill the email'),
                              ),
                            );
                            return;
                          }

                          if (phoneController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill the phone number'),
                              ),
                            );
                            return;
                          }

                          if (!isValidEmail(emailController.text.trim())) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a valid email'),
                              ),
                            );
                            return;
                          }

                          // if (!isValidPhoneNumber(phoneController.text.trim())) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       content: Text('Please enter a valid phone number'),
                          //     ),
                          //   );
                          // }
                          isLoading.value = true;
                          final res = await ref.read(addPlayerControllerProvider.notifier).sendPlayerInvitation(
                                email: emailController.text.trim(),
                                phone: phoneController.text.replaceAll('(', '').replaceAll(')', ''),
                                teamId: selectedTeamId.value,
                                role: Role.coach.name,
                              );
                          isLoading.value = false;
                          if (res.ok && context.mounted) {
                            await SuccessWidget.build(
                              title: 'Success',
                              message: 'Your invitation has been sent successfully.',
                              context: context,
                            );
                            if (context.mounted) {
                              context.go(AppRoutes.home);
                            }
                          } else {
                            unawaited(
                              FailureWidget.build(
                                title: 'Error',
                                message: res.message,
                                context: context,
                              ),
                            );
                          }
                        },
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
