import 'package:flutter/material.dart';
import 'package:toms_phone/pages/call/call_logs.dart';
import 'package:toms_phone/pages/call/dialpad.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreen,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'Keypad',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'Logs',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'Contacts',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentScreen = index;
          });
        },
      ),
      body: currentScreen == 0 ? DialPad() : (currentScreen == 1 ? const CallLogsScreen() : SizedBox.shrink()),
    );
  }
}
