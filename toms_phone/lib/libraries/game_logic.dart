import 'package:isar/isar.dart';
import 'package:maxs_phone/libraries/game_data.dart';
import 'package:maxs_phone/models/message.model.dart';

import 'package:maxs_phone/models/notification.model.dart';
import 'package:maxs_phone/services/isar_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/game_constants.dart';

class GameLogic {
  late Isar isar;

  assignIsarObject() async {
    isar = await IsarService().db;
  }

  executeGameLogic() async {
    await assignIsarObject();

    var result = await isar.notificationModels
        .filter()
        .pushedAtIsNull()
        .findAll();

    for (var element in result) {
      bool canPush = await GameData().canPush(element);

      if (canPush && element.pushedAt == null) {
        NotificationModel? notificationToCreate;

        element.pushedAt = DateTime.now();
        MessageModel? msgMdl;

        if (element.object == 'Message' || element.object == 'SocioMessage') {
          msgMdl = MessageModel(text: element.messageContent!,
              createdAt: element.messageCreatedAt ?? DateTime.now(),
              messageType: element.object == 'Message' ? MessageType.message : MessageType.socioMessage,
              incoming: element.messageIncoming!)
            ..delivered = true
            ..chatWith.value = element.messageChatWith.value!;
        } else if (element.object == 'EdgarIncomingCall') {
          var prefs = await SharedPreferences.getInstance();
          prefs.setString(triggerCallFromEdgarPref, 'callNow');
        }

        if (element.canPushKey == 'firstMessages') {
          var not = isar.notificationModels.filter().objectEqualTo('EdgarIncomingCall').findFirstSync();

          if (not == null) {
            notificationToCreate = NotificationModel(object: 'EdgarIncomingCall', canPushKey: 'after4sec');
          }
        }

        await isar.writeTxn(() async {
          await isar.notificationModels.put(element);

          if (element.object == 'Message' || element.object == 'SocioMessage') {
            await isar.messageModels.put(msgMdl!);
            msgMdl.chatWith.save();
          }

          if (notificationToCreate != null) {
            await isar.notificationModels.put(notificationToCreate);
          }
        });
      }
    }
  }
}
