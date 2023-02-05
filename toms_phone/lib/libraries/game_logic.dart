import 'dart:async';
import 'package:isar/isar.dart';
import 'package:toms_phone/libraries/game_data.dart';
import 'package:toms_phone/models/message.model.dart';

import 'package:toms_phone/models/notification.model.dart';

class GameLogic {
  late Isar isar;

  assignIsarObject() async {
    isar = Isar.getInstance("default") ?? await Isar.open([NotificationModelSchema, MessageModelSchema]);
  }

  executeGameLogic() async {
    await assignIsarObject();

    var result = await isar.notificationModels
        .filter()
        .pushedAtIsNull()
        .findAll();

    List<NotificationModel> toUpdateElements = [];

    for (var element in result) {
      bool canPush = await GameData().canPush(element);

      if (canPush && element.pushedAt == null) {
        element.pushedAt = DateTime.now();
        toUpdateElements.add(element);
      }

      await isar.writeTxn(() async {
        await isar.notificationModels.putAll(toUpdateElements);
      });
    }
  }
}
