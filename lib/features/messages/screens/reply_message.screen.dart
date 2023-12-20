import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/core/extensions.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/common/widgets/failure.widget.dart';
import 'package:team_aid/features/messages/controllers/messages.controller.dart';
import 'package:team_aid/features/messages/entities/chat.model.dart';
import 'package:team_aid/features/travels/controllers/travels.controller.dart';

/// The statelessWidget that handles the current screen
class ReplyMessageScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const ReplyMessageScreen({
    required this.chat,
    super.key,
  });

  /// The key.
  final ChatModel? chat;

  @override
  ConsumerState<ReplyMessageScreen> createState() => _ReplyMessageScreenState();
}

class _ReplyMessageScreenState extends ConsumerState<ReplyMessageScreen> {
  File? selectedFile;
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    final id = useState('');
    final toController = useTextEditingController();
    final toId = ref.watch(messagesControllerProvider).toId;

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (widget.chat == null) {
            /// Split the following pattern string into a list of strings: id;firstname lastname
            final split = toId.split(';');
            id.value = split.first;
            toController.text = split.last;
          } else {
            if (widget.chat!.sender) {
              toController.text = '${widget.chat!.userChatReceiver.firstName.capitalize()} ${widget.chat!.userChatReceiver.lastName.capitalize()}';
              ref.read(messagesControllerProvider.notifier).setToId(widget.chat!.userChatReceiver.id);
            } else {
              toController.text = '${widget.chat!.userChatCreator.firstName.capitalize()} ${widget.chat!.userChatCreator.lastName.capitalize()}';
              ref.read(messagesControllerProvider.notifier).setToId(widget.chat!.userChatCreator.id);
            }
            id.value = widget.chat!.id;
          }
        });
      },
    );

    final messageController = useTextEditingController();

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
                      text: 'Messages',
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
                    TAContainer(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                      padding: EdgeInsets.zero,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Iconsax.sms_notification5,
                                        color: TAColors.purple,
                                      ),
                                      const SizedBox(width: 14),
                                      TATypography.paragraph(
                                        text: 'To: ',
                                        color: TAColors.grey1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      context.push(
                                        Uri(
                                          path: AppRoutes.contactList,
                                          queryParameters: {
                                            'id': '',
                                            'name': '',
                                            'action': 'message',
                                          },
                                        ).toString(),
                                      );
                                    },
                                    child: IgnorePointer(
                                      child: TAPrimaryInput(
                                        label: '',
                                        isReadOnly: true,
                                        textEditingController: toController,
                                        placeholder: '',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Row(
                                    children: [
                                      TATypography.paragraph(
                                        text: 'Subject:',
                                        color: TAColors.grey1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: TAPrimaryInput(
                                    label: '',
                                    placeholder: 'Enter Subject',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Divider(),
                          ColoredBox(
                            color: const Color(0xffFAFCFE),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // const SizedBox(height: 10),
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: TATypography.paragraph(
                                  //     text: 'Choose file from:',
                                  //     color: TAColors.color2,
                                  //   ),
                                  // ),
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
                                  // const Divider(),
                                  // const SizedBox(height: 20),
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
                                ],
                              ),
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              cursorColor: TAColors.color2,
                              controller: messageController,
                              inputFormatters: const [],
                              keyboardType: TextInputType.multiline,
                              maxLines: 8,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.5.h),
                                fillColor: Colors.white,
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                labelStyle: GoogleFonts.poppins(
                                  color: TAColors.color1,
                                ),
                                hintStyle: GoogleFonts.poppins(
                                  color: TAColors.color1,
                                ),
                                hintText: 'Enter Message',
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: TATypography.paragraph(
                                      text: 'Cancel',
                                      underline: true,
                                    ),
                                  ),
                                ),
                                HookConsumer(
                                  builder: (context, ref, child) {
                                    final isLoading = useState(false);
                                    return SizedBox(
                                      width: 114,
                                      child: TAPrimaryButton(
                                        text: 'SEND ',
                                        padding: EdgeInsets.zero,
                                        icon: Iconsax.send_2,
                                        isLoading: isLoading.value,
                                        height: 50,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        onTap: () async {
                                          var fileId = '';

                                          /// If theres a file or an image we upload it
                                          if (selectedFile != null || selectedImage != null) {
                                            File newFile;
                                            if (selectedFile != null) {
                                              newFile = selectedFile!;
                                            } else {
                                              newFile = File(selectedImage!.path);
                                            }
                                            isLoading.value = true;

                                            /// First upload the file
                                            final res = await ref.read(travelsControllerProvider.notifier).uploadFile(
                                                  file: newFile,
                                                  isAgnostic: true,
                                                );

                                            if (!res.ok && mounted) {
                                              unawaited(
                                                FailureWidget.build(
                                                  title: 'Oops',
                                                  message: 'Something went wrong while trying to upload the file',
                                                  context: context,
                                                ),
                                              );
                                            } else {
                                              fileId = res.message;
                                            }
                                          }

                                          isLoading.value = true;
                                          ResponseFailureModel result;
                                          var chatId = '';

                                          /// If it's a new chat we send the request to start a new chat
                                          if (widget.chat == null) {
                                            final newChatResult = await ref.read(messagesControllerProvider.notifier).startNewChat(id.value);
                                            if (!mounted) return;
                                            if (newChatResult.ok) {
                                              chatId = newChatResult.message;
                                            } else {
                                              isLoading.value = false;
                                              unawaited(
                                                FailureWidget.build(
                                                  title: 'Oops',
                                                  message: 'Something went wrong while trying to start a new chat',
                                                  context: context,
                                                ),
                                              );
                                            }
                                          } else {
                                            chatId = widget.chat!.id;
                                          }

                                          if (fileId.isNotEmpty) {
                                            result = await ref.read(messagesControllerProvider.notifier).sendMessageWithFile(
                                                  chatId: chatId,
                                                  message: messageController.text,
                                                  fileId: fileId,
                                                );
                                          } else {
                                            result = await ref.read(messagesControllerProvider.notifier).sendMessage(
                                                  chatId: chatId,
                                                  message: messageController.text,
                                                );
                                          }
                                          await ref.read(messagesControllerProvider.notifier).getData();
                                          isLoading.value = false;
                                          if (!context.mounted) return;
                                          if (result.ok) {
                                            ref.read(messagesControllerProvider.notifier).setToId('');
                                            context.pop();
                                          } else {
                                            unawaited(
                                              FailureWidget.build(
                                                title: 'Something went wrong!',
                                                message: 'There was an error sending the message.',
                                                context: context,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
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
