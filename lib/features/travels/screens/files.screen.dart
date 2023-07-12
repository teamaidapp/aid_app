import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/entities/guest.model.dart';
import 'package:team_aid/design_system/components/inputs/dropdown_input.dart';
import 'package:team_aid/design_system/components/inputs/multi_dropdown.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/home/controllers/home.controller.dart';
import 'package:team_aid/features/travels/controllers/travels.controller.dart';
import 'package:team_aid/features/travels/screens/view_file.screen.dart';

/// The statelessWidget that handles the current screen
class FilesScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const FilesScreen({
    required this.pageController,
    super.key,
  });

  /// The page controller
  final PageController pageController;

  @override
  ConsumerState<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends ConsumerState<FilesScreen> {
  File? selectedFile;

  XFile? selectedImage;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(travelsControllerProvider.notifier).getFiles();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final showAddFiles = useState(true);
    final descriptionController = useTextEditingController();
    final selectedGuests = useState(<TADropdownModel>[]);
    final filesList = ref.watch(travelsControllerProvider).filesList;
    final teams = ref.watch(homeControllerProvider).userTeams;
    final guests = ref.watch(travelsControllerProvider).contactList;
    final teamId = useState('');
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: GestureDetector(
                  key: const Key('add'),
                  onTap: () {
                    showAddFiles.value = true;
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: showAddFiles.value ? TAColors.purple : Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: TATypography.paragraph(
                        text: 'Add files',
                        key: const Key('today_title'),
                        color: showAddFiles.value ? Colors.white : const Color(0x0D253C4D).withOpacity(0.3),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 150,
                child: GestureDetector(
                  key: const Key('show_files'),
                  onTap: () {
                    showAddFiles.value = false;
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: !showAddFiles.value ? TAColors.purple : Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: TATypography.paragraph(
                        text: 'View files',
                        color: !showAddFiles.value ? Colors.white : const Color(0x0D253C4D).withOpacity(0.3),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (showAddFiles.value)
            TAContainer(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
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
                        teamId.value = selectedValue.id;
                        ref.read(travelsControllerProvider.notifier).getContactList(teamId: teamId.value);
                      }
                    },
                  );
                },
                error: (e, s) => const SizedBox(),
                loading: () => const SizedBox(),
              ),
            ),
          if (showAddFiles.value)
            TAContainer(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.note_215,
                        size: 20,
                        color: TAColors.purple,
                      ),
                      const SizedBox(width: 10),
                      TATypography.h3(text: 'Add files'),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TATypography.paragraph(
                      text: 'Choose file from:',
                      color: TAColors.color2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: pickFile,
                        child: Row(
                          children: [
                            const Icon(
                              Iconsax.document_upload,
                              size: 20,
                              color: TAColors.purple,
                            ),
                            const SizedBox(width: 10),
                            TATypography.paragraph(
                              text: 'Files',
                              color: TAColors.purple,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: pickImage,
                        child: Row(
                          children: [
                            const Icon(
                              Iconsax.gallery_export,
                              size: 20,
                              color: TAColors.purple,
                            ),
                            const SizedBox(width: 10),
                            TATypography.paragraph(
                              text: 'Gallery',
                              color: TAColors.purple,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  TAPrimaryInput(
                    label: 'File Description',
                    textEditingController: descriptionController,
                    placeholder: '',
                  ),
                  const SizedBox(height: 10),
                  TAMultiDropdown(
                    label: 'Guests',
                    items: List.generate(
                      guests.valueOrNull?.length ?? 0,
                      (index) {
                        final item = guests.valueOrNull?[index];
                        return TADropdownModel(
                          item: item != null ? item.user.firstName : '',
                          id: item != null ? item.id : '',
                        );
                      },
                    ),
                    placeholder: '',
                    onChange: (v) {
                      selectedGuests.value = v;
                    },
                  ),
                  const SizedBox(height: 30),
                  if (selectedFile != null || selectedImage != null)
                    Row(
                      children: [
                        const Icon(
                          Iconsax.document_upload,
                          size: 20,
                          color: TAColors.purple,
                        ),
                        const SizedBox(width: 10),
                        if (selectedFile != null)
                          Expanded(
                            child: TATypography.paragraph(
                              text: selectedFile!.path.split('/').last,
                              color: TAColors.color2,
                            ),
                          ),
                        if (selectedImage != null)
                          Expanded(
                            child: TATypography.paragraph(
                              text: selectedImage!.path.split('/').last,
                              color: TAColors.color2,
                            ),
                          ),
                      ],
                    ),
                  const Divider(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TAPrimaryButton(
                      text: 'UPLOAD',
                      height: 50,
                      isLoading: isLoading.value,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onTap: () async {
                        if (selectedFile == null && selectedImage == null) {
                          unawaited(
                            FailureWidget.build(
                              title: 'Oops',
                              message: 'Please select a file',
                              context: context,
                            ),
                          );
                          return;
                        }
                        File newFile;
                        if (selectedFile != null) {
                          newFile = selectedFile!;
                        } else {
                          newFile = File(selectedImage!.path);
                        }
                        isLoading.value = true;

                        /// First upload the file
                        final res = await ref.read(travelsControllerProvider.notifier).uploadFile(file: newFile);

                        if (res.ok && mounted) {
                          final newGuests = <Guest>[];

                          for (final guest in selectedGuests.value) {
                            newGuests.add(Guest(userId: guest.id));
                          }

                          /// Ater uploading the file, patch the file and add the guests and description to it
                          final patchRes = await ref.read(travelsControllerProvider.notifier).patchFile(
                                description: descriptionController.text.trim(),
                                fileId: ref.read(travelsControllerProvider).fileId,
                                guests: newGuests,
                              );
                          isLoading.value = false;
                          if (patchRes.ok && mounted) {
                            setState(() {
                              selectedFile = null;
                              selectedImage = null;
                              descriptionController.clear();
                              selectedGuests.value = [];
                            });
                            unawaited(
                              SuccessWidget.build(
                                title: 'Success',
                                message: 'File uploaded successfully',
                                context: context,
                              ),
                            );
                          } else {
                            unawaited(
                              FailureWidget.build(
                                title: 'Oops',
                                message: 'Something went wrong',
                                context: context,
                              ),
                            );
                          }
                        } else {
                          isLoading.value = false;
                          unawaited(
                            FailureWidget.build(
                              title: 'Oops',
                              message: 'Something went wrong',
                              context: context,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          else
            TAContainer(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.note_215,
                        size: 20,
                        color: TAColors.purple,
                      ),
                      const SizedBox(width: 10),
                      TATypography.h3(text: 'My files'),
                    ],
                  ),
                  filesList.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return TATypography.paragraph(
                          text: 'Add new files',
                          color: TAColors.color2,
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 30),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final file = data[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (context) => ViewFileScreen(
                                      url: file.fileKey,
                                    ),
                                  ),
                                );
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Iconsax.document_upload,
                                        size: 20,
                                        color: TAColors.purple,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TATypography.paragraph(
                                          text: file.fileName,
                                          color: TAColors.color2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    error: (_, __) => const SizedBox(),
                    loading: () => const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path!);
      setState(() {
        selectedFile = file;
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    } else {
      // User canceled the picker
    }
  }
}
