import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/functions.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';

/// The statelessWidget that handles the current screen
class AddCollaboratorScreen extends StatelessWidget {
  /// The constructor.
  const AddCollaboratorScreen({super.key});

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
                      text: 'Add collaborator',
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
                  child: _AddCollaboratorWidget(
                isPlayer: false,
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddCollaboratorWidget extends HookConsumerWidget {
  const _AddCollaboratorWidget({required this.isPlayer});

  final bool isPlayer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamId = useState('');
    final makeEditor = useState(false);
    final isLoading = useState(false);
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final teams = ref.watch(homeControllerProvider).userTeams;
    return Column(
      children: [
        TAContainer(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
          ),
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 30,
          ),
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
                    teamId.value = selectedValue.id;
                  }
                },
              );
            },
            error: (e, s) => const SizedBox(),
            loading: () => const SizedBox(),
          ),
        ),
        TAContainer(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TAPrimaryInput(
                label: 'E-mail',
                textEditingController: emailController,
                placeholder: 'Enter the email',
              ),
              const SizedBox(height: 10),
              TAPrimaryInput(
                label: 'Phone',
                textEditingController: phoneController,
                placeholder: 'Enter the phone number',
                inputListFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12),
                  PhoneInputFormatter(defaultCountryCode: 'US'),
                ],
              ),
              const SizedBox(height: 20),
              if (!isPlayer)
                Row(
                  children: [
                    Switch.adaptive(
                      value: makeEditor.value,
                      activeColor: const Color(0xff586DF4),
                      onChanged: (v) {
                        makeEditor.value = v;
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TATypography.subparagraph(
                        text: 'Editor',
                        color: TAColors.grey1,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TAPrimaryButton(
            text: 'ADD',
            height: 50,
            isLoading: isLoading.value,
            mainAxisAlignment: MainAxisAlignment.center,
            onTap: () async {
              if (teamId.value.isEmpty) {
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
              }

              await SuccessWidget.build(
                title: 'Success',
                message: 'Collaborator added successfully.',
                context: context,
              );
              if (context.mounted) {
                Navigator.pop(context);
              }

              // if (!isValidPhoneNumber(phoneController.text.trim())) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //       content: Text('Please enter a valid phone number'),
              //     ),
              //   );
              // }

              // isLoading.value = true;
              // final res = await ref.read(addPlayerControllerProvider.notifier).sendPlayerInvitation(
              //       email: emailController.text,
              //       phone: phoneController.text,
              //       teamId: teamId.value,
              //       role: isPlayer ? Role.player.name : Role.coach.name,
              //     );
              // isLoading.value = false;
              // if (res.ok && context.mounted) {
              //   await SuccessWidget.build(
              //     title: 'Success',
              //     message: 'Your invitation has been sent successfully.',
              //     context: context,
              //   );
              //   if (context.mounted) {
              //     Navigator.pop(context);
              //   }
              // } else {
              //   unawaited(
              //     FailureWidget.build(
              //       title: 'Error',
              //       message: res.message,
              //       context: context,
              //     ),
              //   );
              // }
            },
          ),
        ),
        // const SizedBox(height: 30),
        // GestureDetector(
        //   onTap: () {
        //     context.push(AppRoutes.teams);
        //   },
        //   child: TATypography.paragraph(
        //     text: 'Go to teams',
        //     underline: true,
        //     color: TAColors.textColor,
        //   ),
        // ),
      ],
    );
  }
}
