library game_runner;

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:toms_phone/models/notification.model.dart';

class GameRunner {
  late Isar isar;

  late BuildContext _context;

  GameRunner(context) {
    _context = context;

    workOnNotification();
  }

  assignIsarObject() async {
    isar = Isar.getInstance("default") ?? await Isar.open([NotificationModelSchema]);
  }

  workOnNotification() async {
    await assignIsarObject();
    watchNotification();
  }

  void watchNotification() async {
    Stream<void> notificationChanged = isar.collection<NotificationModel>().watchLazy();
    notificationChanged.listen((event) async {
      final result = await isar.notificationModels.where().findAll();
      showSnackBar();
    });
  }

  showSnackBar() {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        elevation: 30,
        // shape: StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: const <Widget>[
            Icon(
              Icons.close,
              color: Colors.white,
            ),
            Text("This is a text message"),
          ],
        ),
        duration: const Duration(milliseconds: 1500),
      )
    );
  }
}