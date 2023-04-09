import 'package:isar/isar.dart';

import 'package:maxs_phone/models/message.model.dart';
import 'package:maxs_phone/models/user.model.dart';

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
  bool? messageIncoming;
  DateTime? messageCreatedAt;
  final messageChatWith = IsarLink<UserModel>();

  final DateTime created = DateTime.now();
}
