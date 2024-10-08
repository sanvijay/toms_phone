import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maxs_phone/libraries/game_data.dart';

import '../constants/game_constants.dart';

class PhoneStartingScreen extends StatefulWidget {
  const PhoneStartingScreen({Key? key}) : super(key: key);

  @override
  State<PhoneStartingScreen> createState() => _PhoneStartingScreenState();
}

class _PhoneStartingScreenState extends State<PhoneStartingScreen> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 5);

    var prefs = await SharedPreferences.getInstance();
    bool gameStarted = prefs.getBool(gameStartedBoolPref) ?? false;

    if (!gameStarted) {
      await GameData().initializeAllData();
    }
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/wallpaper.png"), fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Max's phone is starting",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: LinearProgressIndicator(
                  value: controller.value,
                  semanticsLabel: 'Linear progress indicator',
                  color: Colors.grey,
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
