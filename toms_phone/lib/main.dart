import 'package:flutter/material.dart';
import 'package:toms_phone/pages/calculator_screen.dart';
import 'package:toms_phone/pages/call_screen.dart';
import 'package:toms_phone/pages/game_menu_screen.dart';
import 'package:toms_phone/pages/message_screen.dart';
import 'package:toms_phone/pages/message_chat_screen.dart';
import 'package:toms_phone/pages/home_screen.dart';
import 'package:toms_phone/pages/phone_calling_screen.dart';
import 'package:toms_phone/pages/phone_starting_screen.dart';
import 'package:toms_phone/pages/settings_screen.dart';
import 'package:toms_phone/pages/sudoku_screen.dart';

void main() => runApp(const ChatterApp());

class ChatterApp extends StatelessWidget {
  const ChatterApp({Key? key}) : super(key: key);

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
        '/messages': (context) => const MessageScreen(),
        '/message': (context) => const MessageChatScreen(),
        '/calculator': (context) => const CalculatorScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/call': (context) => const CallScreen(),
        '/sudoku': (context) => const SudokuScreen(),
        '/phone-call': (context) => const PhoneCallingScreen(),
      },
    );
  }
}
