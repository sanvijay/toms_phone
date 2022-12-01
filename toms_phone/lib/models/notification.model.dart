import 'package:isar/isar.dart';

part 'notification.model.g.dart';

@collection
class NotificationModel {
  NotificationModel({
    required this.object,
    required this.objectId,
    required this.read
  }) : id = Isar.autoIncrement;

  final Id id;

  final String object;

  final int objectId;

  final bool read;
}
