import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/user.model.dart';
import 'package:team_aid/core/enums/role.enum.dart';
import 'package:team_aid/core/functions.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/components/buttons/secondary_button.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/myAccount/controllers/myAccount.controller.dart';
import 'package:team_aid/main.dart';

/// The statelessWidget that handles the current screen
class MyAccountScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const MyAccountScreen({super.key});

  @override
  ConsumerState<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends ConsumerState<MyAccountScreen> {
  XFile? selectedImage;
  @override
  Widget build(BuildContext context) {
    final nameController = useSharedPrefsTextEditingController(sharedPreferencesKey: TAConstants.firstName);
    final roleController = useSharedPrefsTextEditingController(sharedPreferencesKey: TAConstants.role);
    final originalName = useState(nameController.text);
    final isLoading = useState(false);
    final prefs = ref.watch(sharedPrefs);
    // final sportController = useSharedPrefsTextEditingController(sharedPreferencesKey: TAConstants.sport);

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
                              GestureDetector(
                                onTap: pickImage,
                                child: TATypography.paragraph(
                                  underline: true,
                                  text: 'Change image',
                                  color: TAColors.purple,
                                ),
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
                              const SizedBox(height: 20),
                              TAPrimaryInput(
                                label: 'Role',
                                placeholder: '',
                                isReadOnly: true,
                                textEditingController: roleController,
                              ),
                              // const SizedBox(height: 10),
                              // TADropdown(
                              //   label: 'Sport',
                              //   placeholder: 'Select your sport',
                              //   items: TAConstants.sportsList,
                              //   onChange: (selectedValue) {
                              //     if (selectedValue != null) {
                              //       sportController.text = selectedValue.item;
                              //     }
                              //   },
                              // ),
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
                              // const Divider(),
                              // _OptionalWidget(
                              //   title: 'Birthdate',
                              //   icon: Iconsax.cake,
                              //   description: 'Add your birthdate',
                              //   onTap: () {},
                              // ),
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
                          child: SizedBox(
                            height: 90,
                            width: 90,
                            child: prefs.when(
                              data: (data) {
                                final avatar = data.getString(TAConstants.avatar);

                                if (selectedImage != null) {
                                  return CircleAvatar(
                                    radius: 48,
                                    backgroundColor: Colors.white,
                                    backgroundImage: FileImage(
                                      File(selectedImage!.path),
                                    ),
                                  );
                                } else {
                                  if (avatar == null || avatar.isEmpty) {
                                    return const CircleAvatar(
                                      radius: 48,
                                      backgroundColor: Colors.white,
                                      backgroundImage: AssetImage(
                                        'assets/black-logo.png',
                                      ),
                                    );
                                  }
                                  return CircleAvatar(
                                    radius: 48,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(avatar),
                                  );
                                }
                              },
                              error: (_, __) {
                                return const SizedBox();
                              },
                              loading: () {
                                return const SizedBox();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TASecondaryButton(
                        text: 'Delete account',
                        height: 50,
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete account'),
                                content: const Text('Are you sure you want to delete your account?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final res = await ref.read(myAccountControllerProvider.notifier).deleteAccount();
                                      if (!context.mounted) return;
                                      if (res.ok) {
                                        final prefs = await SharedPreferences.getInstance();
                                        await prefs.clear();
                                        if (!context.mounted) return;
                                        context.go(AppRoutes.login);
                                      } else {
                                        await FailureWidget.build(
                                          title: 'Oops',
                                          message: res.message,
                                          context: context,
                                        );
                                      }
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
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
                              isDisabled: isLoading.value,
                              isLoading: isLoading.value,
                              mainAxisAlignment: MainAxisAlignment.center,
                              onTap: () async {
                                if (nameController.text == originalName.value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No changes were made'),
                                    ),
                                  );
                                  return;
                                }

                                String? avatar;

                                /// If theres a file or an image we upload it
                                if (selectedImage != null) {
                                  File newFile;
                                  newFile = File(selectedImage!.path);
                                  isLoading.value = true;

                                  /// First upload the file
                                  final res = await ref.read(myAccountControllerProvider.notifier).uploadFile(file: newFile);
                                  if (!mounted) return;

                                  if (res.ok) {
                                    /// Ater uploading the file, patch the file and add the guests and description to it
                                    final patchRes = await ref.read(myAccountControllerProvider.notifier).patchFile(
                                      description: '',
                                      fileId: res.message,
                                      guests: [],
                                    );
                                    if (!mounted) return;

                                    if (!patchRes.ok) {
                                      return unawaited(
                                        FailureWidget.build(
                                          title: 'Oops',
                                          message: 'Something went wrong while trying to upload the file',
                                          context: context,
                                        ),
                                      );
                                    } else {
                                      avatar = patchRes.message;
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.setString(TAConstants.avatar, avatar);
                                    }
                                  } else {
                                    return unawaited(
                                      FailureWidget.build(
                                        title: 'Oops',
                                        message: 'Something went wrong while trying to upload the file',
                                        context: context,
                                      ),
                                    );
                                  }
                                }

                                final user = UserModel(
                                  firstName: nameController.text.trim(),
                                  lastName: '',
                                  email: '',
                                  phoneNumber: '',
                                  password: '',
                                  sportId: '',

                                  /// This is not sent to the server
                                  role: Role.coach,
                                  cityId: '',
                                  stateId: '',
                                  avatar: avatar,
                                );

                                isLoading.value = true;
                                final res = await ref.read(myAccountControllerProvider.notifier).updateUserData(user: user, uid: '');
                                isLoading.value = false;

                                if (res.ok && context.mounted) {
                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.setString(TAConstants.firstName, nameController.text.trim());
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

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          selectedImage = image;
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      await FailureWidget.build(
        title: 'Oops',
        message: 'There was a problem while trying to pick an image, check the format',
        context: context,
      );
    }
  }
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
