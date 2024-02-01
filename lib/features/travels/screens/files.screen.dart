import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/common/widgets/success.widget.dart';
import 'package:team_aid/features/travels/controllers/travels.controller.dart';
import 'package:team_aid/features/travels/entities/travel.model.dart';

/// The statelessWidget that handles the current screen
class FilesScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const FilesScreen({
    super.key,
  });

  @override
  ConsumerState<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends ConsumerState<FilesScreen> {
  List<File> selectedFiles = [];

  List<XFile> selectedImage = [];

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TAContainer(
              margin: const EdgeInsets.only(left: 20, right: 20),
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
                  const SizedBox(height: 30),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedFiles.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          const Icon(
                            Iconsax.document,
                            size: 20,
                            color: TAColors.purple,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TATypography.paragraph(
                              text: selectedFiles[index].path.split('/').last,
                              color: TAColors.color2,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedImage.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          const Icon(
                            Iconsax.document,
                            size: 20,
                            color: TAColors.purple,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TATypography.paragraph(
                              text: selectedImage[index].path.split('/').last,
                              color: TAColors.color2,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: SizedBox(
                          width: 100,
                          child: TATypography.paragraph(
                            text: 'Cancel',
                            underline: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 120,
                        child: Consumer(
                          builder: (context, ref, child) {
                            return TAPrimaryButton(
                              text: 'SAVE',
                              isLoading: isLoading.value,
                              mainAxisAlignment: MainAxisAlignment.center,
                              onTap: () async {
                                final filesIds = <TravelFile>[];

                                isLoading.value = true;

                                if (selectedFiles.isNotEmpty) {
                                  for (final file in selectedFiles) {
                                    isLoading.value = true;

                                    /// First upload the file
                                    final res = await ref.read(travelsControllerProvider.notifier).uploadFile(file: file);

                                    if (!res.ok && mounted) {
                                      isLoading.value = false;
                                      unawaited(
                                        FailureWidget.build(
                                          title: 'Oops',
                                          message: 'Something went wrong while trying to upload the file',
                                          context: context,
                                        ),
                                      );
                                      return;
                                    } else {
                                      filesIds.add(TravelFile(fileId: res.message));
                                    }
                                  }
                                }

                                if (selectedImage.isNotEmpty) {
                                  for (final image in selectedImage) {
                                    isLoading.value = true;

                                    /// First upload the file
                                    final res = await ref.read(travelsControllerProvider.notifier).uploadFile(file: File(image.path));
                                    if (!res.ok && mounted) {
                                      isLoading.value = false;
                                      unawaited(
                                        FailureWidget.build(
                                          title: 'Oops',
                                          message: 'Something went wrong while trying to upload the file',
                                          context: context,
                                        ),
                                      );
                                      return;
                                    } else {
                                      filesIds.add(TravelFile(fileId: res.message));
                                    }
                                  }
                                }

                                ref.read(travelsControllerProvider.notifier).setFilesIds(filesIds: filesIds);

                                inspect(filesIds);

                                final res = await ref.read(travelsControllerProvider.notifier).createTravel();
                                await ref.read(travelsControllerProvider.notifier).getTravels();
                                if (!mounted) return;

                                if (res.ok && mounted) {
                                  isLoading.value = false;
                                  await SuccessWidget.build(
                                    title: 'Success',
                                    message: 'Travel created successfully',
                                    context: context,
                                  );
                                  if (context.mounted) {
                                    context.pop();
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

                                /// If theres a file or an image we upload it
                                // if (selectedFiles.isNotEmpty || selectedImage.isNotEmpty) {
                                //   File newFile;
                                //   if (selectedFiles.isNotEmpty) {
                                //     newFile = selectedFile!;
                                //   } else {
                                //     newFile = File(selectedImage!.path);
                                //   }
                                //   isLoading.value = true;

                                //   /// First upload the file
                                //   final res = await ref.read(calendarControllerProvider.notifier).uploadFile(file: newFile);

                                //   if (!res.ok && mounted) {
                                //     isLoading.value = false;
                                //     unawaited(
                                //       FailureWidget.build(
                                //         title: 'Oops',
                                //         message: 'Something went wrong while trying to upload the file',
                                //         context: context,
                                //       ),
                                //     );
                                //     return;
                                //   } else {
                                //     fileId = res.message;
                                //   }
                                // }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20, right: 20),
                  //   child: TAPrimaryButton(
                  //     text: 'SAVE',
                  //     height: 50,
                  //     isLoading: isLoading.value,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     onTap: () async {
                  //       if (selectedFile == null && selectedImage == null) {
                  //         unawaited(
                  //           FailureWidget.build(
                  //             title: 'Oops',
                  //             message: 'Please select a file',
                  //             context: context,
                  //           ),
                  //         );
                  //         return;
                  //       }

                  //       if (descriptionController.text.isEmpty) {
                  //         unawaited(
                  //           FailureWidget.build(
                  //             title: 'Oops',
                  //             message: 'Please enter a description',
                  //             context: context,
                  //           ),
                  //         );
                  //         return;
                  //       }
                  //       File newFile;
                  //       if (selectedFile != null) {
                  //         newFile = selectedFile!;
                  //       } else {
                  //         newFile = File(selectedImage!.path);
                  //       }
                  //       isLoading.value = true;

                  //       /// First upload the file
                  //       final res = await ref.read(travelsLegacyControllerProvider.notifier).uploadFile(file: newFile);

                  //       if (res.ok && mounted) {
                  //         if (widget.isInTravel) {
                  //           final newGuests = <Guest>[];

                  //           for (final guest in selectedGuests.value) {
                  //             newGuests.add(Guest(userId: guest.id));
                  //           }

                  //           /// Ater uploading the file, patch the file and add the guests and description to it
                  //           final patchRes = await ref.read(travelsLegacyControllerProvider.notifier).patchFile(
                  //                 description: descriptionController.text.trim(),
                  //                 fileId: ref.read(travelsLegacyControllerProvider).fileId,
                  //                 guests: newGuests,
                  //               );
                  //           isLoading.value = false;
                  //           if (patchRes.ok && mounted) {
                  //             setState(() {
                  //               selectedFile = null;
                  //               selectedImage = null;
                  //               descriptionController.clear();
                  //               selectedGuests.value = [];
                  //               ref.read(travelsLegacyControllerProvider.notifier).setFileId(fileId: '');
                  //             });
                  //             unawaited(
                  //               SuccessWidget.build(
                  //                 title: 'Success',
                  //                 message: 'File uploaded successfully',
                  //                 context: context,
                  //               ),
                  //             );
                  //             if (context.mounted) {
                  //               context.pop();
                  //             }
                  //           } else {
                  //             unawaited(
                  //               FailureWidget.build(
                  //                 title: 'Oops',
                  //                 message: 'Something went wrong',
                  //                 context: context,
                  //               ),
                  //             );
                  //           }
                  //         } else {
                  //           /// Ater uploading the file, patch the file and add the guests and description to it
                  //           final patchRes = await ref.read(travelsLegacyControllerProvider.notifier).patchFile(
                  //             description: descriptionController.text.trim(),
                  //             fileId: ref.read(travelsLegacyControllerProvider).fileId,
                  //             guests: [],
                  //           );
                  //           isLoading.value = false;
                  //           if (patchRes.ok && context.mounted) {
                  //             await SuccessWidget.build(
                  //               title: 'Success',
                  //               message: 'File uploaded successfully',
                  //               context: context,
                  //             );
                  //             if (context.mounted) context.pop();
                  //           } else {
                  //             unawaited(
                  //               FailureWidget.build(
                  //                 title: 'Oops',
                  //                 message: 'Something went wrong',
                  //                 context: context,
                  //               ),
                  //             );
                  //           }
                  //         }
                  //       } else {
                  //         isLoading.value = false;
                  //         unawaited(
                  //           FailureWidget.build(
                  //             title: 'Oops',
                  //             message: 'Something went wrong',
                  //             context: context,
                  //           ),
                  //         );
                  //       }
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path!);
      setState(() {
        selectedFiles.add(file);
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
        selectedImage.add(image);
      });
    } else {
      // User canceled the picker
    }
  }
}
