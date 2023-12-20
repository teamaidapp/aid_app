import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:team_aid/features/messages/entities/chat.model.dart';
import 'package:team_aid/features/messages/entities/message.model.dart';

/// State of the messages screen
@immutable
class MessagesScreenState {
  /// Constructor
  const MessagesScreenState({
    required this.chats,
    required this.messages,
    required this.toId,
  });

  /// The function returns a new instance of MessagesScreenState with the provided chats value, or the
  /// existing chats value if it is not provided.
  ///
  /// Args:
  ///   chats (AsyncValue<List<ChatModel>>): An optional `AsyncValue` object that represents a list of
  /// `ChatModel` objects.
  ///
  /// Returns:
  ///   The `MessagesScreenState` object is being returned.
  MessagesScreenState copyWith({
    AsyncValue<List<ChatModel>>? chats,
    AsyncValue<List<MessageModel>>? messages,
    String? toId,
  }) {
    return MessagesScreenState(
      chats: chats ?? this.chats,
      messages: messages ?? this.messages,
      toId: toId ?? this.toId,
    );
  }

  /// The list of chats
  final AsyncValue<List<ChatModel>> chats;

  /// The list of messages
  final AsyncValue<List<MessageModel>> messages;

  /// The id of the person the user is going to start
  /// a conversation with
  final String toId;
}
