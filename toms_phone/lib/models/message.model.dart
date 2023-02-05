import 'package:isar/isar.dart';

import 'package:toms_phone/models/notification.model.dart';

part 'message.model.g.dart';

@collection
class MessageModel {
  MessageModel({
    required this.text,
    required this.created,
    required this.messageType
  });

  Id? id;

  final String text;

  @enumerated // same as EnumType.ordinal
  final MessageType messageType;

  bool read = false;
  bool delivered = false;

  final DateTime created;
}

enum MessageType {
  message,
  socioMessage
}