import 'package:flutter/material.dart';
import 'package:toms_phone/pages/message_screen.dart';
import 'package:toms_phone/pages/message_chat_screen.dart';
import 'package:toms_phone/pages/home_screen.dart';

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
        '/': (context) => const HomeScreen(),
        '/messages': (context) => const MessageScreen(),
        '/message': (context) => const MessageChatScreen(),
      },
    );
  }
}
