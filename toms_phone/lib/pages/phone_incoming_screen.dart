import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/game_constants.dart';
import '../models/call_log.model.dart';
import '../models/message_option.model.dart';
import '../models/notification.model.dart';
import '../models/user.model.dart';
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

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    setEdgarCalledPref();

    assignIsarObject();

    initializeMessageOptions();

    startTime();
    playRingtone();
  }

  void setEdgarCalledPref() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(triggerCallFromEdgarPref, 'called');
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
    timer = Timer(const Duration(seconds: 20,), missCall);
  }

  missCall() {
    insertCallLog(phoneNumber, CallType.missed);
    routeAway();
  }

  Future<void> initializeMessageOptions() async {
    await assignIsarObject();

    await isar.writeTxn(() async {
      for (var messageOption in initialMessageOptionData()) {
        await isar.messageOptionModels.put(messageOption);
      }
    });
  }

  List<MessageOptionModel> initialMessageOptionData() {
    return [
      MessageOptionModel(contactName: 'Edgar', response: "Don't you know who I am? Give back the money now.", question: 'Who are you?', displayQuestion: 'I am sorry, who are you? I am not sure what you are speaking about?'),
      MessageOptionModel(contactName: 'Edgar', response: "Is this a new lie? Don't think you will get away from this.", question: 'Found this phone on the street', displayQuestion: "I am not the person you are looking for. I found this phone from the street while I was walking around."),
      MessageOptionModel(contactName: 'Edgar', response: "Don't make fun.", question: 'I will give this phone to you.', displayQuestion: "I have a lost phone. If you know the owner of this phone, ask him to pick this up from me."),
      MessageOptionModel(contactName: 'Colt', response: "", question: 'Found this phone on the street', displayQuestion: 'I found this phone on the street. Could you inform your friend and ask him to pick the phone?'),
      MessageOptionModel(contactName: 'Colt', response: "", question: 'Are you the one Edgar is speaking about?', displayQuestion: 'I am getting a lot of messages from Edgar. Is he speaking about you? Could you call him?'),
      MessageOptionModel(contactName: 'Jessie', response: "Hi Sweetie! Where are you?", question: 'Hi!', displayQuestion: 'Hi!'),
    ];
  }

  // TODO: Only work for Edgar.
  routeAway() {
    var currentUser = isar.userModels.filter().phoneNumberEqualTo(phoneNumber).findFirstSync()!;

    var responseNotification = NotificationModel(
        object: 'Message',
        canPushKey: 'after4sec'
    )
      ..messageContent = 'Why are you not picking up the call. call me back or I will call the police.'
      ..messageIncoming = true
      ..messageChatWith.value = currentUser;

    isar.writeTxn(() async {
      await isar.notificationModels.put(responseNotification);
      await responseNotification.messageChatWith.save();
    });

    Navigator.pop(context);
    audioPlayer.release();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
    audioPlayer.release();
  }

  insertCallLog(phoneNumber, callType) async {
    await assignIsarObject();

    UserModel? user;

    user = isar.userModels.filter().phoneNumberEqualTo(phoneNumber).findFirstSync();

    if (user == null) {
      await isar.writeTxn(() async {
        await isar.userModels.put(UserModel(phoneNumber: phoneNumber, createdAt: DateTime.now()));
      });

      user = isar.userModels.filter().phoneNumberEqualTo(phoneNumber).findFirstSync();
    }

    var callLog = CallLogModel(callType: callType, createdAt: DateTime.now())..callWith.value = user!;

    await isar.writeTxn(() async {
      await isar.callLogModels.put(callLog);
      await callLog.callWith.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    setState(() {
      phoneNumber = data['phoneNumber'];
      contactName = data['contactName'];
    });

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                          insertCallLog(phoneNumber, CallType.incoming);

                          Navigator.pushReplacementNamed(context, "/phone-call", arguments: { 'outgoingCall': false, 'phoneNumber': '+1 202-918-2132', 'contactName': 'Edgar' });
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
                          insertCallLog(phoneNumber, CallType.rejected);
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
