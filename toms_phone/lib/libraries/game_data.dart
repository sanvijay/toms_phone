import 'dart:async';
import 'package:intl/intl.dart';
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

    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(gameRunTimePref, 0);
    prefs.setBool(gameStartedBoolPref, false);

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

    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(gameStartedBoolPref, true);
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
        await notification.messageChatWith.save();
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
      NotificationModel(id: 1, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'I am trying to call you for a long time'..messageIncoming = true..messageChatWith.value = userMap()['edgar']!,
      NotificationModel(id: 2, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'Where are you both?'..messageIncoming = true..messageChatWith.value = userMap()['edgar']!,
      NotificationModel(id: 3, object: 'Message', canPushKey: 'firstMessages')..messageContent = "Don't try to fool around"..messageIncoming = true..messageChatWith.value = userMap()['edgar']!,
      NotificationModel(id: 4, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'Call me back soon!'..messageIncoming = true..messageChatWith.value = userMap()['edgar']!,
      NotificationModel(id: 5, object: 'Message', canPushKey: 'firstMessages')..messageContent = 'I am going to call the police.'..messageIncoming = true..messageChatWith.value = userMap()['edgar']!,
    ];
  }

  List<MessageModel> initialMessageData() {
    return [
      MessageModel(text: 'Your a/c no. xxxx2468 is credited by \$10,000.00 Avl. Bal: \$10,329.00', createdAt: DateTime.now().subtract(const Duration(days: 40)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['cityBank']!..read = true,
      MessageModel(text: 'Dear Customer, \$10,000 is debited from A/c xxxx2468. Call 4321 if not done by you.', createdAt: DateTime.now().subtract(const Duration(days: 39)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['cityBank']!..read = true,
      MessageModel(text: 'Recharge of \$10.00 is successful for your ABCnet number 143-92837465. Dial 192, to know your current balance, validity, plan details and for exciting recharge plans.', createdAt: DateTime.now().subtract(const Duration(days: 100)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['abcNet']!..read = true,
      MessageModel(text: 'Plan expired! Recharge now with \$20.00 get exciting prizes.', createdAt: DateTime.now().subtract(const Duration(days: 82)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['abcNet']!..read = true,
      MessageModel(text: 'Recharge of \$10.00 is successful for your ABCnet number 143-92837465. Dial 192, to know your current balance, validity, plan details and for exciting recharge plans.', createdAt: DateTime.now().subtract(const Duration(days: 78)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['abcNet']!..read = true,
      MessageModel(text: 'Recharge of \$10.00 is successful for your ABCnet number 143-92837465. Dial 192, to know your current balance, validity, plan details and for exciting recharge plans.', createdAt: DateTime.now().subtract(const Duration(days: 42)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['abcNet']!..read = true,
      MessageModel(text: 'Dear Customer, You have 13 missed call. The last missed call was at 09:58 PM on ${DateFormat('MMM d').format(DateTime.now().subtract(const Duration(days: 1)))}. Thank you, Team ABCNet', createdAt: DateTime.now().subtract(const Duration(days: 1)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['edgar']!..read = true,
    ];
  }

  Map<String, UserModel> userMap() {
    if (_userMap != null) return _userMap!;

    _userMap = {
      'cityBank': isar.userModels.filter().phoneNumberEqualTo('City Bank').findFirstSync()!,
      'abcNet': isar.userModels.filter().phoneNumberEqualTo('ABC-Net').findFirstSync()!,
      'edgar': isar.userModels.filter().phoneNumberEqualTo('987654321').findFirstSync()!,
    };

    return _userMap!;
  }

  List<UserModel> initialUserData() {
    return [
      UserModel(phoneNumber: 'City Bank', createdAt: DateTime.now()),
      UserModel(phoneNumber: 'ABC-Net', createdAt: DateTime.now()),
      UserModel(phoneNumber: '987654321', createdAt: DateTime.now())..contactName = 'Edgar',
      UserModel(phoneNumber: '987654321', createdAt: DateTime.now())..contactName = 'Edgar',
    ];
  }
}
