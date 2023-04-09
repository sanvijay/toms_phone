import 'dart:async';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:maxs_phone/constants/game_constants.dart';

import 'package:maxs_phone/models/message.model.dart';
import 'package:maxs_phone/models/notification.model.dart';
import 'package:maxs_phone/models/user.model.dart';
import 'package:maxs_phone/models/message_option.model.dart';

class GameData {
  late Isar isar;
  Map<String, UserModel>? _userMap;

  assignIsarObject() async {
    isar = Isar.getInstance("default") ?? await Isar.open([NotificationModelSchema, MessageModelSchema, UserModelSchema, MessageOptionModelSchema]);
  }

  deleteAllData() async {
    await assignIsarObject();

    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(gameRunTimePref, 0);
    prefs.setBool(gameStartedBoolPref, false);

    await isar.writeTxn(() async {
      isar.clear();
    });
  }

  initializeAllData() async {
    var prefs = await SharedPreferences.getInstance();
    bool gameStarted = prefs.getBool(gameStartedBoolPref) ?? false;

    if (gameStarted) {
      return;
    }

    await initializeUser();
    await initializeNotification();
    await initializeMessage();
    await initializeMessageOption();

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

  Future<void> initializeMessageOption() async {
    await assignIsarObject();

    await isar.writeTxn(() async {
      isar.messageOptionModels.filter().contactNameIsNotEmpty().deleteAll();

      for (var messageOption in initialMessageOptionData()) {
        await isar.messageOptionModels.put(messageOption);
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
      // Bank messages
      MessageModel(text: 'Your a/c no. xxxx2468 is credited by \$50,000.00 Avl. Bal: \$50,329.00', createdAt: DateTime.now().subtract(const Duration(days: 40)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['cityBank']!..read = true,
      MessageModel(text: 'Dear Customer, \$50,000 is debited from A/c xxxx2468. Call 4321 if not done by you.', createdAt: DateTime.now().subtract(const Duration(days: 39)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['cityBank']!..read = true,

      // Mobile recharge
      MessageModel(text: 'Recharge of \$10.00 is successful for your ABCnet number *****4321. Dial 192, to know your current balance, validity, plan details and for exciting recharge plans.', createdAt: DateTime.now().subtract(const Duration(days: 100)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['abcNet']!..read = true,
      MessageModel(text: 'Plan expired! Recharge now with \$20.00 get exciting prizes.', createdAt: DateTime.now().subtract(const Duration(days: 82)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['abcNet']!..read = true,
      MessageModel(text: 'Recharge of \$10.00 is successful for your ABCnet number *****4321. Dial 192, to know your current balance, validity, plan details and for exciting recharge plans.', createdAt: DateTime.now().subtract(const Duration(days: 78)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['abcNet']!..read = true,
      MessageModel(text: 'Recharge of \$10.00 is successful for your ABCnet number *****4321. Dial 192, to know your current balance, validity, plan details and for exciting recharge plans.', createdAt: DateTime.now().subtract(const Duration(days: 42)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['abcNet']!..read = true,

      // Edgar
      MessageModel(text: 'Dear Customer, You have 13 missed call. The last missed call was at 09:58 PM on ${DateFormat('MMM d').format(DateTime.now().subtract(const Duration(days: 1)))}. Thank you, Team ABCNet', createdAt: DateTime.now().subtract(const Duration(days: 1)), incoming: true, messageType: MessageType.message)..delivered = true..chatWith.value = userMap()['edgar']!..read = true,

      // Jessie
      MessageModel(text: 'Hey, how was your meeting with your business partner today?', createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: 'It went really well, thanks for asking.', createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "That's great to hear. What kind of business does he do?", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "He's in the oil industry, which is our business.", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Oh, that sounds interesting. When do I get to meet him?", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Actually, I was thinking about inviting him over for dinner next weekend. Would you be okay with that?", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Of course, I'd love to meet them. Where should we go for dinner?", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Maybe we can try that new Italian restaurant that just opened up.", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Sounds perfect. I'll make a reservation. I'm excited to meet your business partner.", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Me too. I think you'll really like him.", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,

      MessageModel(text: "Hey beautiful, how's your day going?", createdAt: DateTime.now().subtract(const Duration(days: 57)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Hi handsome, it's going alright. How about yours?", createdAt: DateTime.now().subtract(const Duration(days: 57)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "It's good, but it would be even better if I was with you right now.", createdAt: DateTime.now().subtract(const Duration(days: 57)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Aww, that's sweet of you to say. I wish I could be there too.", createdAt: DateTime.now().subtract(const Duration(days: 57)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Yeah, me too. Hey, how about we go out for a romantic dinner tonight?", createdAt: DateTime.now().subtract(const Duration(days: 57)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "I would love that! Where should we go?", createdAt: DateTime.now().subtract(const Duration(days: 57)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Let's try that new Italian place we went last time.", createdAt: DateTime.now().subtract(const Duration(days: 57)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Sounds perfect. What time should I meet you there?", createdAt: DateTime.now().subtract(const Duration(days: 57)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "How about 7 PM?", createdAt: DateTime.now().subtract(const Duration(days: 57)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Perfect. I can't wait!", createdAt: DateTime.now().subtract(const Duration(days: 57)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Me neither. You always make everything better.", createdAt: DateTime.now().subtract(const Duration(days: 57)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,

      MessageModel(text: "Hey, how's work going?", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "It's going pretty well!", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "In fact, I have some exciting news.", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "What is it?", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "We just got a new investment of \$50,000 for our business!", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Wow, that's amazing!", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Who is lending you the money?", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "One of our contacts in the industry.", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "He's been keeping an eye on our progress and believes in our business model.", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "That's so great!", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "What are your plans for the money?", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "We're planning on using it to expand our operations and hire more people.", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "That sounds like a solid plan.", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "I'm really happy for you!", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Thanks, babe!", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "It's been a lot of hard work, but it's starting to pay off.", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "I'm proud of you.", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Let's celebrate this weekend!", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,
      MessageModel(text: "Let's go out and have some fun!", createdAt: DateTime.now().subtract(const Duration(days: 43)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['jessie']!..read = true,

      // Colt
      MessageModel(text: "Tomorrow coffee shop at 4 PM. Let's meet there.", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,
      MessageModel(text: "We discuss about the next future of our business.", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,
      MessageModel(text: "Will introduce someone tomorrow.", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,
      MessageModel(text: "Sure mate!", createdAt: DateTime.now().subtract(const Duration(days: 63)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,

      MessageModel(text: "Hey, how's it going?", createdAt: DateTime.now().subtract(const Duration(days: 1)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,
      MessageModel(text: "Not bad, thanks for asking. What's up?", createdAt: DateTime.now().subtract(const Duration(days: 1)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,
      MessageModel(text: "Calling you! Just a min.", createdAt: DateTime.now().subtract(const Duration(days: 1)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,
      MessageModel(text: "As mentioned, bring some copies of our business plan and any other relevant documents. We'll go over everything with John and see if he's interested in investing.", createdAt: DateTime.now().subtract(const Duration(days: 1)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,
      MessageModel(text: "Got it. I'll see you tomorrow at 2 PM.", createdAt: DateTime.now().subtract(const Duration(days: 1)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,
      MessageModel(text: "See you then!", createdAt: DateTime.now().subtract(const Duration(days: 1)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,

      MessageModel(text: "As discussed over phone, here is the account details. \nAcc No: 132457869012\nSort Code: 457683", createdAt: DateTime.now().subtract(const Duration(days: 1)), incoming: true, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,
      MessageModel(text: "Well, I trust your judgment.", createdAt: DateTime.now().subtract(const Duration(days: 1)), incoming: false, messageType: MessageType.socioMessage)..delivered = true..chatWith.value = userMap()['colt']!..read = true,
      MessageModel(text: "Great, thanks so much. This investment is going to be a game-changer for our business, and I appreciate your support.", createdAt: DateTime.now().subtract(const Duration(days: 1)), incoming: false, messageType: MessageType.socioMessage)..delivered = false..chatWith.value = userMap()['colt']!..read = true,
    ];
  }

  Map<String, UserModel> userMap() {
    if (_userMap != null) return _userMap!;

    _userMap = {
      'cityBank': isar.userModels.filter().phoneNumberEqualTo('City Bank').findFirstSync()!,
      'abcNet': isar.userModels.filter().phoneNumberEqualTo('ABC-Net').findFirstSync()!,
      'edgar': isar.userModels.filter().phoneNumberEqualTo('+1 202-918-2132').findFirstSync()!,
      'jessie': isar.userModels.filter().phoneNumberEqualTo('+1 520-978-5420').findFirstSync()!,
      'colt': isar.userModels.filter().phoneNumberEqualTo('+1 203-476-0535').findFirstSync()!,
    };

    return _userMap!;
  }

  List<UserModel> initialUserData() {
    return [
      UserModel(phoneNumber: 'City Bank', createdAt: DateTime.now()),
      UserModel(phoneNumber: 'ABC-Net', createdAt: DateTime.now()),
      UserModel(phoneNumber: '+1 520-978-5420', createdAt: DateTime.now())..contactName = 'Jessie',
      UserModel(phoneNumber: '+1 202-918-2132', createdAt: DateTime.now())..contactName = 'Edgar',
      UserModel(phoneNumber: '+1 203-476-0535', createdAt: DateTime.now())..contactName = 'Colt',
    ];
  }

  List<MessageOptionModel> initialMessageOptionData() {
    return [
      MessageOptionModel(contactName: 'Edgar', response: "Don't you know who I am? Give back the money now.", question: 'Who are you?', displayQuestion: 'Who are you?'),
    ];
  }
}
