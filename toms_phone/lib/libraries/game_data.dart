import 'dart:async';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toms_phone/models/message.model.dart';

import 'package:toms_phone/models/notification.model.dart';
import 'package:toms_phone/constants/game_constants.dart';

class GameData {
  late Isar isar;

  assignIsarObject() async {
    isar = Isar.getInstance("default") ?? await Isar.open([NotificationModelSchema, MessageModelSchema]);
  }

  deleteAllData() async {
    await assignIsarObject();

    await isar.writeTxn(() async {
      isar.notificationModels.filter().createdLessThan(DateTime.now()).deleteAll();
    });
  }

  initializeNotification() async {
    await assignIsarObject();
    int notificationCount = await isar.notificationModels.count();

    if (notificationCount == initialData().length) {
      return;
    }

    await isar.writeTxn(() async {
      isar.notificationModels.filter().pushedAtIsNull().deleteAll();
      isar.notificationModels.filter().pushedAtIsNotNull().deleteAll();

      for (var notification in initialData()) {
        await isar.notificationModels.put(notification);
      }
    });
  }

  Future<bool> canPush(NotificationModel element) async {
    if (element.pushedAt != null) {
      return false;
    }

    var prefs = await SharedPreferences.getInstance();
    int gameRunTime = prefs.getInt(gameRunTimePref) ?? 0;

    switch (element.canPushKey) {
      case 'firstMessages':
        return gameRunTime > 12;
      default:
        return false;
    }
  }

  List<NotificationModel> initialData() {
    return [
      NotificationModel(id: 1, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'I am trying to call you for a long time',
      NotificationModel(id: 2, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'Where are you both?',
      NotificationModel(id: 3, object: 'Message', canPushKey: 'firstMessages')..messageContent = "Don't try to fool around",
      NotificationModel(id: 4, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'Call me back soon!',
      NotificationModel(id: 5, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'I am going to call the police.',
    ];
  }
}
