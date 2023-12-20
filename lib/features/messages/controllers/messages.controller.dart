import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:team_aid/core/entities/response_failure.model.dart';
import 'package:team_aid/features/messages/services/messages.service.dart';
import 'package:team_aid/features/messages/state/messages.state.dart';

/// A dependency injection.
final messagesControllerProvider = StateNotifierProvider.autoDispose<MessagesController, MessagesScreenState>((ref) {
  return MessagesController(
    const MessagesScreenState(
      chats: AsyncValue.loading(),
      messages: AsyncValue.loading(),
      toId: '',
    ),
    ref,
    ref.watch(messagesServiceProvider),
  );
});

/// The `ServicesHistoryController` class is responsible for retrieving and setting the services history
/// in the state of the application.
class MessagesController extends StateNotifier<MessagesScreenState> {
  /// Constructor
  MessagesController(super.state, this.ref, this._messagesService);

  /// Riverpod reference
  final Ref ref;

  final MessagesService _messagesService;

  /// This function retrieves the total earnings and returns a response indicating success or failure.
  ///
  /// Returns:
  ///   A `Future` object that will eventually return a `ResponseFailureModel` object.
  Future<ResponseFailureModel> getData() async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _messagesService.getData();

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {
          state = state.copyWith(chats: AsyncValue.data(success));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(message: 'There was a problem with MessagesService');
    }
  }

  /// The function `getChatMessages` retrieves chat messages for a given chat ID and returns a
  /// `ResponseFailureModel` indicating success or failure.
  ///
  /// Args:
  ///   chatId (String): The chatId parameter is a unique identifier for a specific chat. It is used to
  /// retrieve the chat messages associated with that chat.
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> getChatMessages(String chatId) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _messagesService.getChatMessages(chatId);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) {
          state = state.copyWith(messages: AsyncValue.data(success));
          return response = response.copyWith(ok: true);
        },
      );
    } catch (e) {
      return response = response.copyWith(message: 'There was a problem with MessagesService');
    }
  }

  /// The function `sendMessage` sends a message to a specific chat and returns a `ResponseFailureModel`
  /// indicating success or failure.
  /// Args:
  ///  chatId (String): The chatId parameter is a unique identifier for a specific chat. It is used to
  /// retrieve the chat messages associated with that chat.
  /// message (String): The message parameter is the message that will be sent to the chat.
  /// Returns:
  ///  a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> sendMessage({
    required String chatId,
    required String message,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _messagesService.sendMessage(chatId, message);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) => response = response.copyWith(ok: true),
      );
    } catch (e) {
      return response = response.copyWith(message: 'There was a problem with MessagesService');
    }
  }

  /// The function sends a message with a file to a chat and returns a response indicating success or
  /// failure.
  ///
  /// Args:
  ///   chatId (String): The chatId parameter is a required String that represents the ID of the chat
  /// where the message will be sent.
  ///   message (String): The `message` parameter is a required string that represents the content of the
  /// message to be sent. It is the text that will be included in the message.
  ///   fileId (String): The `fileId` parameter is a required string that represents the unique identifier
  /// of the file that you want to send in the message.
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> sendMessageWithFile({
    required String chatId,
    required String message,
    required String fileId,
  }) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _messagesService.sendMessageWithFile(chatId, message, fileId);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) => response = response.copyWith(ok: true),
      );
    } catch (e) {
      return response = response.copyWith(message: 'There was a problem with MessagesService');
    }
  }

  /// The function sets the "toId" property of the state object to the provided value.
  ///
  /// Args:
  ///   toId (String): The `toId` parameter is a string that represents the ID of an object or entity.
  void setToId(String toId) {
    state = state.copyWith(toId: toId);
  }

  /// The function `startNewChat` attempts to start a new chat using the `_messagesService` and returns
  /// a `ResponseFailureModel` indicating success or failure.
  ///
  /// Args:
  ///   userId (String): The `userId` parameter is a string that represents the unique identifier of a
  /// user. It is used as a parameter for the `_messagesService.startNewChat()` method, which is
  /// responsible for starting a new chat for the specified user.
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> startNewChat(String userId) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _messagesService.startNewChat(userId);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) => response = response.copyWith(ok: true, message: success.message),
      );
    } catch (e) {
      return response = response.copyWith(message: 'There was a problem with MessagesService');
    }
  }

  /// The function `changeChatStatus` changes the status of a chat and returns a `ResponseFailureModel`
  /// indicating the success or failure of the operation.
  ///
  /// Args:
  ///   chatId (String): The chatId parameter is a string that represents the unique identifier of a
  /// chat. It is used to identify the specific chat that needs its status changed.
  ///   status (String): The "status" parameter in the "changeChatStatus" function is a string that
  /// represents the new status of a chat. It could be values like "active", "inactive", "closed", etc.,
  /// depending on the specific implementation and requirements of the application.
  ///
  /// Returns:
  ///   a `Future<ResponseFailureModel>`.
  Future<ResponseFailureModel> changeMessageStatus(String messageId, String status) async {
    var response = ResponseFailureModel.defaultFailureResponse();
    try {
      final result = await _messagesService.changeMessageStatus(messageId, status);

      return result.fold(
        (failure) => response = response.copyWith(message: failure.message),
        (success) => response = response.copyWith(ok: true, message: success.message),
      );
    } catch (e) {
      return response = response.copyWith(message: 'There was a problem with MessagesService');
    }
  }
}
