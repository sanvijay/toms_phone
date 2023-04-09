import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import 'package:maxs_phone/constants/game_constants.dart';
import 'package:maxs_phone/libraries/game_logic.dart';
import 'package:maxs_phone/models/message.model.dart';
import 'package:maxs_phone/models/notification.model.dart';
import 'package:maxs_phone/models/user.model.dart';

import 'package:maxs_phone/pages/calculator_screen.dart';
import 'package:maxs_phone/pages/calendar_screen.dart';
import 'package:maxs_phone/pages/call_screen.dart';
import 'package:maxs_phone/pages/clock_screen.dart';
import 'package:maxs_phone/pages/contacts_screen.dart';
import 'package:maxs_phone/pages/gallery_screen.dart';
import 'package:maxs_phone/pages/game_menu_screen.dart';
import 'package:maxs_phone/pages/message_screen.dart';
import 'package:maxs_phone/pages/message_chat_screen.dart';
import 'package:maxs_phone/pages/home_screen.dart';
import 'package:maxs_phone/pages/phone_calling_screen.dart';
import 'package:maxs_phone/pages/phone_starting_screen.dart';
import 'package:maxs_phone/pages/settings_screen.dart';
import 'package:maxs_phone/pages/socio_profile_screen.dart';
import 'package:maxs_phone/pages/socio_screen.dart';
import 'package:maxs_phone/pages/sudoku_screen.dart';

import 'models/message_option.model.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//   runApp(const ChatterApp());
// }

void main() => runApp(const ChatterApp());

class ChatterApp extends StatefulWidget {
  const ChatterApp({Key? key}) : super(key: key);

  @override
  State<ChatterApp> createState() => _ChatterAppState();
}

class _ChatterAppState extends State<ChatterApp> with WidgetsBindingObserver {
  late Isar isar;
  OverlayState? overlayState;
  Timer? timer;
  bool _isInForeground = true;
  bool _isInGame = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    WidgetsBinding.instance.addObserver(this);
    workOnNotification();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;
  }

  workOnNotification() async {
    await assignIsarObject();

    timer = Timer.periodic(const Duration(seconds: pollingTimeInSecs), (Timer t) async {
      var prefs = await SharedPreferences.getInstance();
      _isInGame = prefs.getBool(inGamePref) ?? false;
      int runTime = prefs.getInt(gameRunTimePref) ?? 0;

      int notificationCount = isar.notificationModels.countSync();

      print("IsInForeground: $_isInForeground isInGame: $_isInGame gameRunTime: $runTime notificationCount: $notificationCount");
      if (_isInForeground && _isInGame) {
        GameLogic().executeGameLogic();
        prefs.setInt(gameRunTimePref, runTime + pollingTimeInSecs);
      }
    });
  }

  assignIsarObject() async {
    isar = Isar.getInstance("default") ?? await Isar.open([NotificationModelSchema, MessageModelSchema, UserModelSchema, MessageOptionModelSchema]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Max's Phone",
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      // home: ChatterHome(),
      initialRoute: '/',
      routes: {
        '/': (context) => const GameMenuScreen(),
        '/phone-starting': (context) => const PhoneStartingScreen(),
        '/home': (context) => const HomeScreen(),
        '/messages': (context) => const MessageScreen(isMessenger: false,),
        '/message': (context) => MessageChatScreen(isMessenger: false),
        '/calculator': (context) => const CalculatorScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/call': (context) => const CallScreen(),
        '/sudoku': (context) => const SudokuScreen(),
        '/phone-call': (context) => const PhoneCallingScreen(),
        '/contacts': (context) => const ContactsScreen(),
        '/socio': (context) => const SocioScreen(),
        '/socio-profile': (context) => const SocioProfileScreen(),
        '/messenger': (context) => const MessageScreen(isMessenger: true,),
        '/messenger_chat': (context) => MessageChatScreen(isMessenger: true),
        '/gallery': (context) => GalleryScreen(),
        '/calendar': (context) => CalendarScreen(),
        '/clock': (context) => ClockScreen(),
      },
    );
  }
}
