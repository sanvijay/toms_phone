import 'package:isar/isar.dart';

import '../models/message.model.dart';
import '../models/message_option.model.dart';
import '../models/notification.model.dart';
import '../models/user.model.dart';
import '../models/call_log.model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([
        UserModelSchema,
        NotificationModelSchema,
        MessageModelSchema,
        MessageOptionModelSchema,
        CallLogModelSchema
      ]);
    }

    return Future.value(Isar.getInstance());
  }
}