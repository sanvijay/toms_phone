import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:isar/isar.dart';

import '../services/isar_service.dart';

class PhoneIncomingScreen extends StatefulWidget {
  const PhoneIncomingScreen({Key? key}) : super(key: key);

  @override
  State<PhoneIncomingScreen> createState() => _PhoneIncomingScreenState();
}

class _PhoneIncomingScreenState extends State<PhoneIncomingScreen> with TickerProviderStateMixin {
  String phoneNumber = "";
  String? contactName;
  late Timer timer;
  late Isar isar;

  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();

    assignIsarObject();
    audioPlayer = AudioPlayer();

    startTime();
    playRingtone();
  }

  assignIsarObject() async {
    isar = await IsarService().db;
  }

  playRingtone() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    // TODO: mention credit
    // “Sound effects obtained from https://www.zapsplat.com“
    const alarmAudioPath = "sounds/ringtone.mp3";
    await audioPlayer.play(AssetSource(alarmAudioPath));
    // await player.setSource();
  }

  startTime() async {
    timer = Timer(const Duration(seconds: 20,), routeAway);
  }

  routeAway() {
    // TODO: Fix this
    // var responseNotification = NotificationModel(
    //     object: isMessenger ? 'SocioMessage' :'Message',
    //     canPushKey: 'after4sec'
    // )
    //   ..messageContent = e.response
    //   ..messageIncoming = true
    //   ..messageChatWith.value = currentUser!;
    //
    // isar.writeTxn(() async {
    //   await isar.notificationModels.put(responseNotification);
    //   await responseNotification.messageChatWith.save();
    // });

    Navigator.pop(context);
    audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
    audioPlayer.setReleaseMode(ReleaseMode.stop);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff05d5c5),
              Color(0xff0085a4),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40,),
            const Icon(
              Icons.person_pin,
              color: Colors.white,
              size: 120,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                contactName == null ? const SizedBox.shrink() : Text(
                  contactName!,
                  style: textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  phoneNumber,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.014),
                Text(
                  "Incoming Call...",
                  style: textTheme.subtitle2!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Expanded(
              flex: 4,
              child: SizedBox.shrink()
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.green,
                      ),
                      child: const Icon(
                        Icons.call_sharp,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      "Accept",
                      style: textTheme.subtitle2!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        routeAway();
                      },
                      style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.red,
                      ),
                      child: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      "Decline",
                      style: textTheme.subtitle2!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }

  Widget button({
    required TextTheme textTheme,
    required VoidCallback onPressed,
    required IconData iconData,
    required String title,
    enabled = false,
  }) {
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            shape: const CircleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 2,
                )
            ),
            padding: const EdgeInsets.all(20),
            backgroundColor: enabled ? Colors.white : Colors.transparent,
          ),
          child: Icon(
            iconData,
            color: enabled ? const Color(0xff0085a4) : Colors.white,
          ),
        ),
        const SizedBox(height: 5,),
        Text(
          title,
          style: textTheme.subtitle2!.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
