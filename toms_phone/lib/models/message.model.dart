import 'package:isar/isar.dart';

import 'package:toms_phone/models/user.model.dart';

part 'message.model.g.dart';

@collection
class MessageModel {
  MessageModel({
    required this.text,
    required this.createdAt,
    required this.messageType,
    required this.incoming
  });

  Id? id;

  final String text;
  final DateTime createdAt;
  final bool incoming;

  @enumerated // same as EnumType.ordinal
  final MessageType messageType;

  final chatWith = IsarLink<UserModel>();
  bool read = false;
  bool delivered = false;
}

enum MessageType {
  message,
  socioMessage
}
