// ignore_for_file: one_member_abstracts
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/messages/entities/chat.model.dart';
import 'package:team_aid/features/messages/entities/message.model.dart';
import 'package:team_aid/features/messages/repositories/messages.repository.dart';

/// The provider of MessagesService
final messagesServiceProvider = Provider<MessagesServiceImpl>((ref) {
  final messagesRepository = ref.watch(messagesProvider);
  return MessagesServiceImpl(messagesRepository);
});

/// This class is responsible of the abstraction
abstract class MessagesService {
  /// Get data
  Future<Either<Failure, List<ChatModel>>> getData();

  /// Get chat messages
  Future<Either<Failure, List<MessageModel>>> getChatMessages(String chatId);

  /// Send message
  Future<Either<Failure, Success>> sendMessage(String chatId, String message);

  /// Send message with file
  Future<Either<Failure, Success>> sendMessageWithFile(String chatId, String message, String fileId);

  /// Start a new chat
  Future<Either<Failure, Success>> startNewChat(String userId);

  /// Change chat status
  Future<Either<Failure, Success>> changeMessageStatus(String chatId, String status);
}

/// This class is responsible for implementing the MessagesService
class MessagesServiceImpl implements MessagesService {
  /// Constructor
  MessagesServiceImpl(this.messagesRepository);

  /// The messages Repository that is injected
  final MessagesRepository messagesRepository;

  @override
  Future<Either<Failure, List<ChatModel>>> getData() async {
    try {
      final result = await messagesRepository.getData();

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with MessagesServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getChatMessages(String chatId) async {
    try {
      final result = await messagesRepository.getChatMessages(chatId);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with MessagesServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> sendMessage(String chatId, String message) async {
    try {
      final result = await messagesRepository.sendMessage(chatId, message);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with MessagesServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> sendMessageWithFile(
    String chatId,
    String message,
    String fileId,
  ) async {
    try {
      final result = await messagesRepository.sendMessageWithFile(chatId, message, fileId);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with MessagesServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> startNewChat(String userId) async {
    try {
      final result = await messagesRepository.startNewChat(userId);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with MessagesServiceImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> changeMessageStatus(String messageId, String status) async {
    try {
      final result = await messagesRepository.changeMessageStatus(messageId, status);

      return result.fold(Left.new, Right.new);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was a problem with MessagesServiceImpl',
        ),
      );
    }
  }
}
