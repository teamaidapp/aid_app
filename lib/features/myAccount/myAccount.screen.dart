import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/components/inputs/dropdown_input.dart';
import 'package:team_aid/design_system/design_system.dart';

/// The statelessWidget that handles the current screen
class MyAccountScreen extends HookWidget {
  /// The constructor.
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useSharedPrefsTextEditingController(sharedPreferencesKey: TAConstants.firstName);
    final sportController = useSharedPrefsTextEditingController(sharedPreferencesKey: TAConstants.sport);

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
                      text: 'Edit profile',
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
                              TATypography.paragraph(
                                underline: true,
                                text: 'Change image',
                                color: TAColors.purple,
                              ),
                              const SizedBox(height: 30),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TATypography.paragraph(
                                  text: 'Edit profile',
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TAPrimaryInput(
                                label: 'Name',
                                placeholder: '',
                                textEditingController: nameController,
                              ),
                              const SizedBox(height: 10),
                              TADropdown(
                                label: 'Sport',
                                placeholder: 'Select your sport',
                                items: TAConstants.sportsList,
                                onChange: (selectedValue) {
                                  if (selectedValue != null) {
                                    sportController.text = selectedValue.item;
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TATypography.paragraph(
                                  text: 'Optional',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _OptionalWidget(
                                title: 'Bio',
                                icon: Iconsax.user,
                                description: 'Add biography',
                                onTap: () {
                                  context.push(AppRoutes.biography);
                                },
                              ),
                              const Divider(),
                              _OptionalWidget(
                                title: 'Phone',
                                icon: Iconsax.call,
                                description: 'Add phone number',
                                onTap: () {
                                  context.push(AppRoutes.phoneProfile);
                                },
                              ),
                              const Divider(),
                              _OptionalWidget(
                                title: 'Birthdate',
                                icon: Iconsax.cake,
                                description: 'Add your birthdate',
                                onTap: () {},
                              ),
                              const Divider(),
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
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: TATypography.paragraph(
                              text: 'Cancel',
                              underline: true,
                            ),
                          ),
                          Flexible(
                            child: TAPrimaryButton(
                              text: 'SAVE',
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
            ),
          ),
        ],
      ),
    );
  }
}

TextEditingController useSharedPrefsTextEditingController({
  required String sharedPreferencesKey,
}) {
  final controller = useTextEditingController();

  useEffect(() {
    SharedPreferences.getInstance().then((prefs) {
      final value = prefs.getString(sharedPreferencesKey) ?? '';
      controller.text = value;
    });
    return () {};
  }, [controller]);

  return controller;
}

class _OptionalWidget extends StatelessWidget {
  const _OptionalWidget({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.description,
  });

  final String title;

  final IconData icon;

  final String description;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: TAColors.purple,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TATypography.paragraph(
                text: title,
                fontWeight: FontWeight.w600,
              ),
              TATypography.paragraph(text: description, color: TAColors.grey1),
            ],
          ),
          const Spacer(),
          const Icon(Iconsax.edit),
        ],
      ),
    );
  }
}
