import 'package:isar/isar.dart';

import 'package:toms_phone/models/message.model.dart';

part 'notification.model.g.dart';

@collection
class NotificationModel {
  NotificationModel({
    required this.id,
    required this.object,
    required this.canPushKey
  });

  final Id id;

  final String object;

  final String canPushKey;

  bool read = false;

  DateTime? pushedAt;

  final message = IsarLink<MessageModel>();

  String? messageContent;

  final DateTime created = DateTime.now();
}
