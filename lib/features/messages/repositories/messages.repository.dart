// ignore_for_file: one_member_abstracts
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_aid/core/constants.dart';
import 'package:team_aid/core/entities/failure.dart';
import 'package:team_aid/core/entities/success.dart';
import 'package:team_aid/features/messages/entities/chat.model.dart';
import 'package:team_aid/features/messages/entities/message.model.dart';
import 'package:team_aid/main.dart';

/// The provider of MessagesRepository
final messagesProvider = Provider<MessagesRepository>((ref) {
  final http = ref.watch(httpProvider);
  const secureStorage = FlutterSecureStorage();
  return MessagesRepositoryImpl(http, secureStorage);
});

/// This class is responsible of the abstraction
abstract class MessagesRepository {
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
  Future<Either<Failure, Success>> changeMessageStatus(String messageId, String status);
}

/// This class is responsible for implementing the MessagesRepository
class MessagesRepositoryImpl implements MessagesRepository {
  /// Constructor
  MessagesRepositoryImpl(this.http, this.secureStorage);

  /// The http client
  final Client http;

  /// The secure storage
  final FlutterSecureStorage secureStorage;

  /// Get data from backend
  @override
  Future<Either<Failure, List<ChatModel>>> getData() async {
    final list = <ChatModel>[];
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/messages/chats',
      );
      final res = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error retrieving the contact list',
          ),
        );
      }

      final data = (jsonDecode(res.body) as Map)['data'] as List;

      for (final element in data) {
        final contact = ChatModel.fromMap(element as Map<String, dynamic>);
        list.add(contact);
      }

      return Right(list);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with TeamsRepositoyImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getChatMessages(String chatId) async {
    final list = <MessageModel>[];
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/messages/$chatId?limit=50&page=1',
      );
      final res = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error retrieving the contact list',
          ),
        );
      }

      final data = (jsonDecode(res.body) as Map)['data']['messages'] as List;

      for (final element in data) {
        final contact = MessageModel.fromMap(element as Map<String, dynamic>);
        list.add(contact);
      }

      return Right(list);
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with TeamsRepositoyImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> sendMessage(String chatId, String message) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/messages',
      );
      final res = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'message': message,
          'chatId': chatId,
        },
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error sending the message',
          ),
        );
      }

      return Right(Success(ok: true, message: 'Message sent'));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with TeamsRepositoyImpl',
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
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/messages/file',
      );
      final res = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'message': message,
          'chatId': chatId,
          'fileId': fileId,
        },
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error sending the message with file',
          ),
        );
      }

      return Right(Success(ok: true, message: 'Message sent'));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with TeamsRepositoyImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> startNewChat(String userId) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/messages/create-chat',
      );
      final res = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'id': userId},
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error starting a new chat',
          ),
        );
      }

      // ignore: avoid_dynamic_calls
      final id = (jsonDecode(res.body) as Map)['data']['id'] as String;
      return Right(Success(ok: true, message: id));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with TeamsRepositoyImpl',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Success>> changeMessageStatus(String chatId, String status) async {
    try {
      final token = await secureStorage.read(key: TAConstants.accessToken);
      final url = Uri.parse(
        '${dotenv.env['API_URL']}/messages/$chatId',
      );
      final res = await http.patch(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'messageStatus': status},
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        return Left(
          Failure(
            message: 'There was an error changing the chat status',
          ),
        );
      }

      return Right(Success(ok: true, message: 'Chat status changed'));
    } catch (e) {
      return Left(
        Failure(
          message: 'There was an error with TeamsRepositoyImpl',
        ),
      );
    }
  }
}
