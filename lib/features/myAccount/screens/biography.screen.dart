import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/core/enums/role.enum.dart';
import 'package:team_aid/core/functions.dart';
import 'package:team_aid/design_system/components/inputs/textfield_input.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/household/entities/household.model.dart';
import 'package:team_aid/features/myAccount/controllers/myAccount.controller.dart';
import 'package:team_aid/main.dart';

/// The statelessWidget that handles the current screen
class BiographyScreen extends HookConsumerWidget {
  /// The constructor.
  const BiographyScreen({
    required this.houseHold,
    super.key,
  });

  /// The household to edit
  final HouseholdModel? houseHold;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final biographyController = useSharedPrefsTextEditingController(sharedPreferencesKey: TAConstants.biography);
    final isLoading = useState(false);
    final isVisible = useState(false);
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
                      text: 'Biography',
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
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        TAContainer(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 30),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TATypography.paragraph(
                                  text: 'Edit biography',
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TATextFieldInput(
                                label: 'Biography',
                                maxLines: 6,
                                placeholder: '',
                                textEditingController: biographyController,
                              ),
                              const SizedBox(height: 20),
                              ref.watch(sharedPrefs).when(
                                    data: (prefs) {
                                      isVisible.value = prefs.getBool(TAConstants.isBiographyVisible) ?? false;
                                      return Row(
                                        children: [
                                          Switch.adaptive(
                                            value: isVisible.value,
                                            activeColor: const Color(0xff586DF4),
                                            onChanged: (v) {
                                              isVisible.value = v;
                                              prefs.setBool(TAConstants.isBiographyVisible, v);
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TATypography.paragraph(
                                              text: 'Visible to public',
                                              color: TAColors.grey1,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    error: (_, __) => const SizedBox(),
                                    loading: () => const SizedBox(),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: TATypography.paragraph(
                                text: 'Cancel',
                                underline: true,
                              ),
                            ),
                          ),
                          Flexible(
                            child: TAPrimaryButton(
                              text: 'SAVE',
                              height: 50,
                              isLoading: isLoading.value,
                              isDisabled: isLoading.value,
                              mainAxisAlignment: MainAxisAlignment.center,
                              onTap: () async {
                                if (biographyController.text.isEmpty) {
                                  await FailureWidget.build(
                                    title: 'Oops',
                                    message: 'Please enter your biography',
                                    context: context,
                                  );
                                  return;
                                }

                                final user = UserModel(
                                  firstName: '',
                                  lastName: '',
                                  email: '',
                                  phoneNumber: '',
                                  password: '',
                                  sportId: '',
                                  role: Role.coach,
                                  cityId: '',
                                  stateId: '',
                                  biography: biographyController.text,
                                  isBiographyVisible: isVisible.value,
                                  isAvatarVisible: null,
                                  isEmailVisible: null,
                                  isFatherVisible: null,
                                  isPhoneVisible: null,
                                );

                                isLoading.value = true;
                                final res = await ref.read(myAccountControllerProvider.notifier).updateUserData(
                                      user: user,
                                      uid: houseHold != null ? houseHold!.userId.id : '',
                                    );
                                isLoading.value = false;

                                if (res.ok && context.mounted) {
                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.setString(TAConstants.biography, biographyController.text.trim());
                                  if (context.mounted) {
                                    await SuccessWidget.build(
                                      title: 'Hurray!',
                                      message: 'Your biography has been updated successfully',
                                      context: context,
                                    );
                                    if (context.mounted) {
                                      context.pop();
                                    }
                                  }
                                } else {
                                  await FailureWidget.build(
                                    title: 'Oops',
                                    message: res.message,
                                    context: context,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
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
