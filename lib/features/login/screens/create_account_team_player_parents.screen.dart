import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/core/enums/role.enum.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/login/controllers/createAccount.controller.dart';
import 'package:team_aid/main.dart';

/// The statelessWidget that handles the current screen
class CreateAccountParentsScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const CreateAccountParentsScreen({super.key});

  @override
  ConsumerState<CreateAccountParentsScreen> createState() => _CreateAccountParentsScreenState();
}

class _CreateAccountParentsScreenState extends ConsumerState<CreateAccountParentsScreen> {
  @override
  void initState() {
    ref.read(homeControllerProvider.notifier).getAllOrganizations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allOrganizations = ref.watch(homeControllerProvider).allOrganizations;
    final teams = ref.watch(homeControllerProvider).organizationTeams;
    final teamId = useState('');
    final organizationId = useState('');
    final prefs = ref.watch(sharedPrefs);

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
                  // const Icon(
                  //   Iconsax.arrow_left_2,
                  //   color: TAColors.textColor,
                  // ),
                  const Spacer(),
                  TATypography.h3(
                    text: 'Add child as team player',
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
            child: HookBuilder(
              builder: (context) {
                final firstNameController = useTextEditingController();
                final lastNameController = useTextEditingController();
                // final emailController = useTextEditingController();
                final positionController = useTextEditingController();
                final phoneNumberController = useTextEditingController();
                final passwordController = useTextEditingController(text: '1234');
                final agreeToTerms = useState(false);
                final sport = useState('');
                final cityState = useState('');
                final currentSelectedState = useState('');
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
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 30,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TAPrimaryInput(
                                label: 'First name',
                                textEditingController: firstNameController,
                                placeholder: 'Enter the first name of the child',
                              ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'Last name',
                                textEditingController: lastNameController,
                                placeholder: 'Enter the last name of the child',
                              ),
                              // const SizedBox(height: 10),
                              // TAPrimaryInput(
                              //   label: 'E-mail',
                              //   textEditingController: emailController,
                              //   placeholder: 'Enter the email of the child',
                              //   inputListFormatter: [
                              //     FilteringTextInputFormatter.allow(
                              //       RegExp('[a-zA-Z0-9.@_-]'),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(height: 10),
                              TAPrimaryInput(
                                label: 'Position',
                                textEditingController: positionController,
                                placeholder: 'Enter a position',
                              ),
                              const SizedBox(height: 10),
                              TADropdown(
                                label: 'Sports',
                                items: TAConstants.sportsList,
                                placeholder: 'Select a sport',
                                onChange: (v) {
                                  if (v != null) {
                                    sport.value = v.id;
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        TAContainer(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: allOrganizations.when(
                            data: (data) {
                              return TADropdown(
                                label: 'Organizations',
                                placeholder: 'Select a organization',
                                items: List.generate(
                                  data.length,
                                  (index) => TADropdownModel(
                                    item: data[index].name,
                                    id: data[index].id,
                                  ),
                                ),
                                onChange: (selectedValue) {
                                  if (selectedValue != null) {
                                    organizationId.value = selectedValue.id;
                                    ref.read(homeControllerProvider.notifier).getTeamsByOrganization(
                                          organizationId: organizationId.value,
                                        );
                                  }
                                },
                              );
                            },
                            error: (e, s) => const SizedBox(),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TAContainer(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: teams.when(
                            data: (data) {
                              if (data.isEmpty) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: TATypography.paragraph(
                                      text: 'Select an organization',
                                      color: TAColors.grey1,
                                    ),
                                  ),
                                );
                              } else {
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
                              }
                            },
                            error: (e, s) => const SizedBox(),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
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
                                  color: TAColors.grey1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 40,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    context.go(AppRoutes.home);
                                  },
                                  child: TATypography.paragraph(
                                    text: 'Skip',
                                    underline: true,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: HookConsumer(
                                  builder: (context, ref, child) {
                                    final isLoading = useState(false);
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child: TAPrimaryButton(
                                        text: 'CREATE ACCOUNT',
                                        height: 50,
                                        padding: EdgeInsets.zero,
                                        isLoading: isLoading.value,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        onTap: () async {
                                          if (firstNameController.text.isEmpty ||
                                                  lastNameController.text.isEmpty ||
                                                  // emailController.text.isEmpty ||
                                                  // phoneNumberController.text.isEmpty ||
                                                  // passwordController.text.isEmpty ||
                                                  sport.value.isEmpty ||
                                                  positionController.text.isEmpty
                                              // currentSelectedState.value.isEmpty
                                              ) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Please fill all fields'),
                                              ),
                                            );
                                            return;
                                          }

                                          // if (!isValidEmail(emailController.text.trim())) {
                                          //   ScaffoldMessenger.of(context).showSnackBar(
                                          //     const SnackBar(
                                          //       content: Text('Please enter a valid email'),
                                          //     ),
                                          //   );
                                          //   return;
                                          // }

                                          if (!agreeToTerms.value) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Please agree to terms of service and privacy policy',
                                                ),
                                              ),
                                            );
                                            return;
                                          }

                                          final phone = phoneNumberController.text.replaceAll(' ', '').replaceAll('+', '');

                                          final user = UserModel(
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            email: '',
                                            phoneNumber: phone,
                                            password: passwordController.text,
                                            sportId: sport.value,
                                            role: Role.player_under_aged,
                                            cityId: cityState.value,
                                            stateId: currentSelectedState.value,
                                            position: positionController.text,
                                          );
                                          isLoading.value = true;
                                          final res = await ref
                                              .read(
                                                createAccountControllerProvider.notifier,
                                              )
                                              .createChildAccount(user: user);
                                          isLoading.value = false;
                                          if (res.ok && context.mounted) {
                                            final email = prefs.asData?.value.getString(TAConstants.email) ?? '';
                                            final parentPhone = prefs.asData?.value.getString(TAConstants.phoneNumber) ?? '';

                                            final invitationResponse = await ref
                                                .read(
                                                  homeControllerProvider.notifier,
                                                )
                                                .sendPlayerInvitation(
                                                  role: Role.player_under_aged.name,
                                                  email: email,
                                                  phone: parentPhone,
                                                  teamId: teamId.value,
                                                );
                                            if (invitationResponse.ok && context.mounted) {
                                              context.go(AppRoutes.home);
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text("We couldn't send the invitation"),
                                                ),
                                              );
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(res.message),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
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
