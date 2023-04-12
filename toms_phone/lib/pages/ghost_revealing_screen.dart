import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/game_constants.dart';

class GhostRevealingScreen extends StatefulWidget {
  GhostRevealingScreen({Key? key}) : super(key: key);

  @override
  _GhostRevealingScreenState createState() => _GhostRevealingScreenState();
}

class _GhostRevealingScreenState extends State<GhostRevealingScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    setGameRevealed();
    timer = Timer(const Duration(seconds: 15,), route);
  }

  route() {
    Navigator.pop(context);
  }

  setGameRevealed() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(ghostRevealedPref, true);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30.0,
            fontFamily: 'Agne',
          ),
          child: AnimatedTextKit(
            totalRepeatCount: 1,
            animatedTexts: [
              TypewriterAnimatedText('I am the owner of this phone.', cursor: '|', textAlign: TextAlign.center),
              TypewriterAnimatedText('I am killed by someone.', cursor: '|', textAlign: TextAlign.center),
              TypewriterAnimatedText('Now I am able to communicate with you via this phone.', cursor: '|', textAlign: TextAlign.center),
              TypewriterAnimatedText('Please help to find the killer.', cursor: '|', textAlign: TextAlign.center),
            ],
          ),
        ),
      )
    );
  }
}
