import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/extensions.dart';
import 'package:team_aid/core/routes.dart';
import 'package:team_aid/design_system/components/buttons/secondary_button.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/messages/controllers/messages.controller.dart';
import 'package:team_aid/features/messages/entities/chat.model.dart';

/// The statelessWidget that handles the current screen
class MessagesScreen extends StatefulHookConsumerWidget {
  /// The constructor.
  const MessagesScreen({super.key});

  @override
  ConsumerState<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends ConsumerState<MessagesScreen> {
  List<ChatModel> filteredChats = [];
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messagesControllerProvider.notifier).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final chats = ref.watch(messagesControllerProvider).chats;
    final email = useState('');

    useEffect(
      () {
        SharedPreferences.getInstance().then((prefs) {
          final emailFromStorage = prefs.getString(TAConstants.email) ?? '';
          email.value = emailFromStorage;
        });
        return () {};
      },
      [],
    );
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
              child: chats.when(
                data: (data) {
                  final list = filteredChats.isEmpty || _query.isEmpty ? data : filteredChats;
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TAPrimaryInput(
                                label: '',
                                placeholder: 'Search team...',
                                onChanged: (v) {
                                  if (v != null) {
                                    search(v, data);
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 16.w,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: TAPrimaryButton(
                                text: 'NEW',
                                mainAxisAlignment: MainAxisAlignment.center,
                                onTap: () {
                                  context.push(AppRoutes.replyMessage, extra: null);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      Expanded(
                        child: list.isNotEmpty
                            ? ListView.builder(
                                padding: const EdgeInsets.only(bottom: 80),
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  final chat = list[index];
                                  var name = '';

                                  if (chat.sender) {
                                    name = 'me';
                                  } else {
                                    if (chat.userChatCreator.email == email.value) {
                                      name = '${chat.userChatReceiver.firstName} ${chat.userChatReceiver.lastName}';
                                    } else {
                                      name = '${chat.userChatCreator.firstName} ${chat.userChatCreator.lastName}';
                                    }
                                  }

                                  return _MessageItem(
                                    title: chat.team.teamName,
                                    subtitle: name,
                                    date: DateTime.parse(chat.createdAt).toLocal(),
                                    body: chat.lastMessage.message,
                                    onTap: () {
                                      ref.read(messagesControllerProvider.notifier).changeMessageStatus(chat.lastMessage.id, 'READ');
                                      ref.read(messagesControllerProvider.notifier).getChatMessages(chat.id);
                                      _showBottomSheet(
                                        context,
                                        chat,
                                      );
                                    },
                                  );
                                },
                              )
                            : Center(
                                child: TATypography.paragraph(
                                  text: 'No messages',
                                  color: TAColors.textColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return const SizedBox();
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show bottom sheet
  void _showBottomSheet(BuildContext context, ChatModel chat) {
    final date = DateTime.parse(chat.createdAt).toLocal();
    final formattedDate = DateFormat('dd MMM').format(date).toUpperCase();
    final time = DateFormat('hh:mm a').format(date);
    showModalBottomSheet<void>(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.sms_notification5, color: TAColors.purple),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TATypography.paragraph(
                                text: chat.team.teamName,
                                color: TAColors.textColor,
                                fontWeight: FontWeight.w600,
                              ),
                              TATypography.paragraph(
                                text: '${chat.userChatReceiver.firstName} ${chat.userChatReceiver.lastName}',
                                color: TAColors.grey1,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TATypography.paragraph(
                                text: formattedDate,
                                color: TAColors.grey1,
                              ),
                              TATypography.paragraph(
                                text: time,
                                color: TAColors.grey1,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Divider(color: Colors.black.withOpacity(0.25)),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 30.h,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final messages = ref.watch(messagesControllerProvider).messages;
                            return messages.when(
                              data: (data) {
                                data = data.reversed.toList();
                                return ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final message = data[index];
                                    // final messageDate = DateFormat('dd MMM').format(DateTime.parse(message.createdAt)).toUpperCase();
                                    if (message.isFile) {
                                      return Column(
                                        children: [
                                          BubbleNormal(
                                            text: message.message,
                                            isSender: message.sender,
                                            color: message.sender ? TAColors.purple : Colors.white,
                                            textStyle: TextStyle(
                                              color: message.sender ? Colors.white : TAColors.textColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                          BubbleNormalImage(
                                            id: message.fileId!.id,
                                            image: Image.network(message.fileId!.fileKey),
                                            color: TAColors.purple,
                                            delivered: true,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return BubbleNormal(
                                        text: message.message,
                                        isSender: message.sender,
                                        color: message.sender ? TAColors.purple : Colors.white,
                                        textStyle: TextStyle(
                                          color: message.sender ? Colors.white : TAColors.textColor,
                                          fontSize: 16,
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                              error: (error, stackTrace) {
                                return const SizedBox();
                              },
                              loading: () {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          HookConsumer(
                            builder: (context, ref, child) {
                              // final isLoading = useState(false);
                              return Expanded(
                                child: TASecondaryButton(
                                  text: 'Delete',
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  onTap: () async {},
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TAPrimaryButton(
                              text: 'Reply',
                              mainAxisAlignment: MainAxisAlignment.center,
                              onTap: () {
                                context.push(AppRoutes.replyMessage, extra: chat);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
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
    );
  }

  void search(String query, List<ChatModel> data) {
    setState(
      () {
        _query = query;

        filteredChats = data
            .where(
              (item) => item.team.teamName.contains(query.toLowerCase()),
            )
            .toList();
      },
    );
  }
}

class _MessageItem extends StatelessWidget {
  const _MessageItem({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.body,
    required this.onTap,
  });

  final String title;

  final String subtitle;

  final DateTime date;

  final String body;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM').format(date).toUpperCase();
    final time = DateFormat('hh:mm a').format(date);
    return GestureDetector(
      onTap: onTap,
      child: TAContainer(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Iconsax.sms_notification5, color: TAColors.purple),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TATypography.paragraph(
                        text: title.capitalize(),
                        color: TAColors.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                      TATypography.paragraph(
                        text: subtitle.capitalize(),
                        color: TAColors.grey1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TATypography.paragraph(
                      text: formattedDate,
                      color: TAColors.grey1,
                    ),
                    TATypography.paragraph(
                      text: time,
                      color: TAColors.grey1,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.black.withOpacity(0.25)),
            const SizedBox(height: 10),
            TATypography.subparagraph(
              text: body,
              textAlign: TextAlign.start,
              color: TAColors.grey1,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
