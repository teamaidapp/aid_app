// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:team_aid/features/calendar/entities/event.model.dart';

class EventShared extends CalendarEvent {
  const EventShared({
    required super.id,
    required super.isOwner,
    required super.status,
    required super.event,
    required super.dateKey,
    required this.inviteUser,
  });

  final InviteUserModel inviteUser;
}

class InviteUserModel {
  const InviteUserModel({
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });
  final String firstName;
  final String lastName;
  final String avatar;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
    };
  }

  factory InviteUserModel.fromMap(Map<String, dynamic> map) {
    return InviteUserModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      avatar: map['avatar'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InviteUserModel.fromJson(String source) => InviteUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
