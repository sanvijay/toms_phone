import 'dart:async';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toms_phone/models/notification.model.dart';

import 'package:toms_phone/pages/calculator_screen.dart';
import 'package:toms_phone/pages/calendar_screen.dart';
import 'package:toms_phone/pages/call_screen.dart';
import 'package:toms_phone/pages/clock_screen.dart';
import 'package:toms_phone/pages/contacts_screen.dart';
import 'package:toms_phone/pages/gallery_screen.dart';
import 'package:toms_phone/pages/game_menu_screen.dart';
import 'package:toms_phone/pages/message_screen.dart';
import 'package:toms_phone/pages/message_chat_screen.dart';
import 'package:toms_phone/pages/home_screen.dart';
import 'package:toms_phone/pages/phone_calling_screen.dart';
import 'package:toms_phone/pages/phone_starting_screen.dart';
import 'package:toms_phone/pages/settings_screen.dart';
import 'package:toms_phone/pages/socio_profile_screen.dart';
import 'package:toms_phone/pages/socio_screen.dart';
import 'package:toms_phone/pages/sudoku_screen.dart';

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

    timer = Timer.periodic(const Duration(seconds: 4), (Timer t) async {
      var prefs = await SharedPreferences.getInstance();
      _isInGame = prefs.getBool('inGame') ?? false;
      print("IsInForeground: $_isInForeground isInGame: $_isInGame");
      if (_isInForeground && _isInGame) {
        // await insertNotification();
      }
    });
  }

  assignIsarObject() async {
    isar = Isar.getInstance("default") ?? await Isar.open([NotificationModelSchema]);
  }

  insertNotification() async {
    await isar.writeTxn(() async {
      final notification = NotificationModel(object: (['Messages', 'Radio', 'Clock']..shuffle()).first, objectId: 1, read: false);
      await isar.collection<NotificationModel>().put(notification);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tom's Phone",
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
        '/messages': (context) => MessageScreen(isMessenger: false,),
        '/message': (context) => MessageChatScreen(isMessenger: false,),
        '/calculator': (context) => const CalculatorScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/call': (context) => const CallScreen(),
        '/sudoku': (context) => const SudokuScreen(),
        '/phone-call': (context) => const PhoneCallingScreen(),
        '/contacts': (context) => const ContactsScreen(),
        '/socio': (context) => const SocioScreen(),
        '/socio-profile': (context) => const SocioProfileScreen(),
        '/messenger': (context) => MessageScreen(isMessenger: true,),
        '/messenger_chat': (context) => MessageChatScreen(isMessenger: true),
        '/gallery': (context) => GalleryScreen(),
        '/calendar': (context) => CalendarScreen(),
        '/clock': (context) => ClockScreen(),
      },
    );
  }
}
