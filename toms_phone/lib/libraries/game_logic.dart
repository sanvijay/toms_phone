import 'package:isar/isar.dart';
import 'package:maxs_phone/libraries/game_data.dart';
import 'package:maxs_phone/models/message.model.dart';

import 'package:maxs_phone/models/notification.model.dart';
import 'package:maxs_phone/services/isar_service.dart';

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
        element.pushedAt = DateTime.now();
        MessageModel? msgMdl;

        if (element.object == 'Message' || element.object == 'SocioMessage') {
          msgMdl = MessageModel(text: element.messageContent!,
              createdAt: element.messageCreatedAt ?? DateTime.now(),
              messageType: element.object == 'Message' ? MessageType.message : MessageType.socioMessage,
              incoming: element.messageIncoming!)
            ..delivered = true
            ..chatWith.value = element.messageChatWith.value!;
        } else if (element.object == 'IncomingCall') {
          // TODO: incoming call
        }

        await isar.writeTxn(() async {
          await isar.notificationModels.put(element);

          if (element.object == 'Message' || element.object == 'SocioMessage') {
            await isar.messageModels.put(msgMdl!);
            msgMdl.chatWith.save();
          }
        });
      }
    }
  }
}
