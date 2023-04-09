library game_runner;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:maxs_phone/models/message.model.dart';
import 'package:maxs_phone/models/notification.model.dart';
import 'package:maxs_phone/models/user.model.dart';
import 'package:maxs_phone/services/isar_service.dart';

import '../models/message_option.model.dart';

class NotificationWatcher {
  late Isar isar;

  late BuildContext _context;

  NotificationWatcher(context) {
    _context = context;

    watchNotification();
  }

  assignIsarObject() async {
    isar = await IsarService().db;
  }

  void watchNotification() async {
    await assignIsarObject();

    Stream<List<NotificationModel>> notificationChanged = isar.collection<NotificationModel>()
        .filter()
        .pushedAtGreaterThan(
          DateTime.now().subtract(const Duration(seconds: 3))
        )
        .sortByPushedAtDesc()
        .limit(1)
        .watch();

    notificationChanged.listen((result) async {
      for (var element in result) {
        showSnackBar(element.object);
      }
    });
  }

  showSnackBar(String appName) {
    SystemSound.play(SystemSoundType.alert);

    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black38,
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        elevation: 30,
        // shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: <Widget>[
            const Icon(
              Icons.close,
              color: Colors.white,
            ),
            Text("New notification from $appName"),
          ],
        ),
        duration: const Duration(milliseconds: 1500),
      )
    );
  }
}