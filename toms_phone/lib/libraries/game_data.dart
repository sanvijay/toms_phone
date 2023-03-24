import 'dart:async';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toms_phone/models/message.model.dart';

import 'package:toms_phone/models/notification.model.dart';
import 'package:toms_phone/constants/game_constants.dart';
import 'package:toms_phone/models/user.model.dart';

class GameData {
  late Isar isar;
  Map<String, UserModel>? _userMap;

  assignIsarObject() async {
    isar = Isar.getInstance("default") ?? await Isar.open([NotificationModelSchema, MessageModelSchema, UserModelSchema]);
  }

  deleteAllData() async {
    await assignIsarObject();

    await isar.writeTxn(() async {
      isar.userModels.filter().phoneNumberIsNotEmpty().deleteAll();
      isar.notificationModels.filter().objectIsNotEmpty().deleteAll();
      isar.messageModels.filter().textIsEmpty().deleteAll();
    });
  }

  initializeAllData() async {
    await initializeUser();
    await initializeNotification();
    await initializeMessage();
  }

  initializeMessage() async {
    int messageCount = await isar.messageModels.filter().messageTypeEqualTo(MessageType.message).count();

    if (messageCount == initialMessageData().length) {
      return;
    }

    userMap();

    await isar.writeTxn(() async {
      isar.messageModels.filter().createdAtLessThan(DateTime.now()).deleteAll();
      isar.messageModels.filter().createdAtGreaterThan(DateTime.now()).deleteAll();

      for (var message in initialMessageData()) {
        await isar.messageModels.put(message);
        await message.chatWith.save();
      }
    });
  }

  Future<void> initializeNotification() async {
    await assignIsarObject();
    int notificationCount = await isar.notificationModels.count();

    if (notificationCount == initialNotificationData().length) {
      return;
    }

    await isar.writeTxn(() async {
      isar.notificationModels.filter().pushedAtIsNull().deleteAll();
      isar.notificationModels.filter().pushedAtIsNotNull().deleteAll();

      for (var notification in initialNotificationData()) {
        await isar.notificationModels.put(notification);
      }
    });
  }

  Future<void> initializeUser() async {
    await assignIsarObject();
    int userCount = await isar.userModels.count();

    if (userCount == initialUserData().length) {
      return;
    }

    await isar.writeTxn(() async {
      isar.userModels.filter().contactNameIsEmpty().deleteAll();
      isar.userModels.filter().contactNameIsNotEmpty().deleteAll();

      for (var user in initialUserData()) {
        await isar.userModels.put(user);
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

  List<NotificationModel> initialNotificationData() {
    return [
      NotificationModel(id: 1, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'I am trying to call you for a long time',
      NotificationModel(id: 2, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'Where are you both?',
      NotificationModel(id: 3, object: 'Message', canPushKey: 'firstMessages')..messageContent = "Don't try to fool around",
      NotificationModel(id: 4, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'Call me back soon!',
      NotificationModel(id: 5, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'I am going to call the police.',
    ];
  }

  List<MessageModel> initialMessageData() {
    return [
      MessageModel(text: 'Message', createdAt: DateTime.now(), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['unknown']!,
      MessageModel(text: 'Message', createdAt: DateTime.now(), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['unknown']!,
      MessageModel(text: 'Message', createdAt: DateTime.now(), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['edgar']!,
      MessageModel(text: 'Message', createdAt: DateTime.now(), incoming: false, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['edgar']!,
      MessageModel(text: 'Message', createdAt: DateTime.now(), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['edgar']!,
    ];
  }

  Map<String, UserModel> userMap() {
    if (_userMap != null) return _userMap!;

    _userMap = {
      'unknown': isar.userModels.filter().phoneNumberEqualTo('123456789').findFirstSync()!,
      'edgar': isar.userModels.filter().phoneNumberEqualTo('987654321').findFirstSync()!,
    };

    return _userMap!;
  }

  List<UserModel> initialUserData() {
    return [
      UserModel(phoneNumber: '123456789', createdAt: DateTime.now()),
      UserModel(phoneNumber: '987654321', createdAt: DateTime.now())..contactName = 'Edgar',
    ];
  }
}
