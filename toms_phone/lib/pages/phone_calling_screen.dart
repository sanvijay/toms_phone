import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PhoneCallingScreen extends StatefulWidget {
  const PhoneCallingScreen({Key? key}) : super(key: key);

  @override
  State<PhoneCallingScreen> createState() => _PhoneCallingScreenState();
}

class _PhoneCallingScreenState extends State<PhoneCallingScreen> with TickerProviderStateMixin {
  bool micMuted = false;
  bool recordCall = true;
  bool outgoingCall = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTime();
    // playSound();
  }

  playSound() async {
    final player = AudioPlayer();

    const alarmAudioPath = "sounds/call_ends.wav";
    await player.play(AssetSource(alarmAudioPath));
    // await player.setSource();
  }

  startTime() async {
    timer = Timer(const Duration(seconds: 5,), route);
  }

  route() {
    Navigator.pop(context);
  }

  toggleRecordCall() {
    setState(() {
      recordCall = !recordCall;
    });
  }

  toggleMic() {
    setState(() {
      micMuted = !micMuted;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
            // Container(
            //   height: 100,
            //   width: 100,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //   ),
            //   child: Icon(
            //     Icons.person_outline,
            //     // color: Colors.white,
            //     size: 40,
            //   ),
            // ),
            const Icon(
              Icons.person_pin,
              color: Colors.white,
              size: 120,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "John Deo",
                  style: textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.014),
                Text(
                  false
                      ? "elapsedTime"
                      : "Calling",
                  style: textTheme.subtitle2!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          button(textTheme: textTheme, onPressed: () {}, iconData: Icons.dialpad, title: "Keypad"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      button(textTheme: textTheme, onPressed: toggleRecordCall, enabled: recordCall || !outgoingCall, iconData: Icons.voicemail, title: outgoingCall ? (recordCall ? "Ready" : "Record") : "Recording..."),
                      button(textTheme: textTheme, onPressed: () {}, enabled: true, iconData: true ? Icons.volume_up : Icons.volume_down, title: "Speaker"),
                      button(textTheme: textTheme, onPressed: toggleMic, enabled: micMuted, iconData: micMuted ? Icons.mic_off : Icons.mic, title: "Mute"),
                    ],
                  ),
                  outgoingCall ? const SizedBox.shrink() : SizedBox(height: size.height * 0.02),
                  outgoingCall ? const SizedBox.shrink() : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      button(textTheme: textTheme, onPressed: () {}, iconData: Icons.play_circle_fill, title: "On hold"),
                      button(textTheme: textTheme, onPressed: () {}, iconData: Icons.add_box, title: "Add call"),
                      button(textTheme: textTheme, onPressed: () {}, iconData: Icons.perm_contact_cal, title: "Contact"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
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
