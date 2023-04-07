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

    for (var element in result) {
      bool canPush = await GameData().canPush(element);

      if (canPush && element.pushedAt == null) {
        element.pushedAt = DateTime.now();
        MessageModel? msgMdl;

        if (element.object == 'Message') {
          msgMdl = MessageModel(text: element.messageContent!,
              createdAt: element.messageCreatedAt ?? DateTime.now(),
              messageType: MessageType.message,
              incoming: element.messageIncoming!)
            ..delivered = true
            ..chatWith.value = element.messageChatWith.value!;
        }

        await isar.writeTxn(() async {
          await isar.notificationModels.put(element);

          if (element.object == 'Message') {
            await isar.messageModels.put(msgMdl!);
            msgMdl.chatWith.save();
          }
        });
      }
    }
  }
}
