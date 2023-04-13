import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maxs_phone/libraries/game_data.dart';
import 'dart:math' as math;

import 'package:maxs_phone/libraries/notification_watcher.dart';
import 'package:maxs_phone/constants/game_constants.dart';

import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class GameMenuScreen extends StatefulWidget {
  const GameMenuScreen({Key? key}) : super(key: key);

  @override
  State<GameMenuScreen> createState() => _GameMenuScreenState();
}

class _GameMenuScreenState extends State<GameMenuScreen> {
  @override
  void initState() {
    () async {
      var prefs = await SharedPreferences.getInstance();
      prefs.setBool(inGamePref, false);
    }();

    Future.delayed(Duration.zero,() {
      NotificationWatcher(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SimpleUserCard(
              userName: "Max's Phone",
              userProfilePic: const AssetImage("assets/images/profile_image.png"),
              imageRadius: 100,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "You got a mobile from somewhere and it is your job to return this phone to the right owner. Click 'Start' to switch on the phone.",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ),
            const SizedBox(height: 40,),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    Navigator.pushNamed(context, "/phone-starting");
                  },
                  icons: Icons.play_arrow,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.blueAccent,
                  ),
                  title: 'Start',
                  subtitle: "Continue the game where you left",
                ),
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(_createRoute(const GameSettingsScreen()));
                  },
                  icons: Icons.settings,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Settings',
                  subtitle: "Sound • Factory Reset",
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(_createRoute(const AboutTheGameScreen()));
                  },
                  icons: Icons.warning_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.green,
                  ),
                  title: 'About the Game',
                  subtitle: "Learn more • Disclaimer",
                ),
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(_createRoute(const CreditsScreen()));
                  },
                  icons: Icons.handshake_sharp,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.deepOrange,
                  ),
                  title: 'Credits',
                  subtitle: "And Special Thanks",
                ),
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(_createRoute(SupportScreen()));
                  },
                  icons: Icons.favorite,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'Support Us',
                  subtitle: "Feedback • Support",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: "Exit",
                  trailing: const SizedBox.shrink(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget creditSection(
    {required IconData icons, required IconStyle iconStyle, required String title, required String subtitle}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Ink(
              decoration: ShapeDecoration(
                color: iconStyle.backgroundColor,
                shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
              child: IconButton(
                icon: Icon(icons),
                iconSize: 40,
                color: Colors.white,
                onPressed: () {},
              ),
            )
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(subtitle, style: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

class SupportScreen extends StatelessWidget {
  final InAppReview inAppReview = InAppReview.instance;

  SupportScreen({super.key});

  void openPlayStore() {
    inAppReview.openStoreListing();
  }

  Future openEmail() async {
    String email = Uri.encodeComponent("team.finsey@gmail.com");
    String subject = Uri.encodeComponent("Feedback about Max's Phone");
    Uri mail = Uri.parse("mailto:$email?subject=$subject");
    await launchUrl(mail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          'Feedback',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.black
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Send us Feedback', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  const Text('Send us your feedback to', style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () async { await openEmail(); },
                    child: const Text('team.finsey@gmail.com', style: TextStyle(fontSize: 16))
                  )
                ]
              ),
            ),
            const SizedBox(height: 16.0,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Rate us on store', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                onPressed: () { openPlayStore(); },
                child: const Text('Click here to rate our app in the store', style: TextStyle(fontSize: 16)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutTheGameScreen extends StatelessWidget {
  const AboutTheGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          'About the Game',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.black
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('About the game', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('''
Max's Phone is a unique game that emulates a mobile phone interface to provide players with a realistic experience. The objective of the game is to return a lost phone to its rightful owner by navigating through various apps, contacts, and messages.
              ''', style: TextStyle(fontSize: 16)
              ),
            ),
            SizedBox(height: 16.0,),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Disclaimer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('''
Max's Phone interface looks exactly like a phone. But it does not collect any personal data or information from players, ensuring that the game is entirely safe and secure to play.
              ''', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          'Credits',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.black
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Special thanks to these opensource projects', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            ),
            creditSection(
              icons: Icons.alarm,
              iconStyle: IconStyle(
                iconsColor: Colors.white,
                withBackground: true,
                backgroundColor: Colors.red,
              ),
              title: 'Clock',
              subtitle: "https://github.com/leonamtv/minimalist-clock-flutter",
            ),
            // creditSection(
            //   icons: Icons.settings,
            //   iconStyle: IconStyle(
            //     iconsColor: Colors.white,
            //     withBackground: true,
            //     backgroundColor: Colors.red,
            //   ),
            //   title: 'Settings page',
            //   subtitle: "https://pub.dev/packages/babstrap_settings_screen",
            // ),
            creditSection(
              icons: Icons.calculate,
              iconStyle: IconStyle(
                iconsColor: Colors.white,
                withBackground: true,
                backgroundColor: Colors.red,
              ),
              title: 'Calculator',
              subtitle: "https://github.com/Wahid551/flutter_cal",
            ),
            // creditSection(
            //   icons: Icons.calendar_month,
            //   iconStyle: IconStyle(
            //     iconsColor: Colors.white,
            //     withBackground: true,
            //     backgroundColor: Colors.red,
            //   ),
            //   title: 'Calendar',
            //   subtitle: "https://pub.dev/packages/table_calendar",
            // ),
            creditSection(
              icons: Icons.gamepad,
              iconStyle: IconStyle(
                iconsColor: Colors.white,
                withBackground: true,
                backgroundColor: Colors.red,
              ),
              title: 'Sudoku',
              subtitle: "https://github.com/HeveshL/Sudoku-Solver",
            ),
            creditSection(
              icons: Icons.photo,
              iconStyle: IconStyle(
                iconsColor: Colors.white,
                withBackground: true,
                backgroundColor: Colors.red,
              ),
              title: 'Gallery',
              subtitle: "https://github.com/shahbajjamil/Gallery",
            ),
            creditSection(
              icons: Icons.dialpad,
              iconStyle: IconStyle(
                iconsColor: Colors.white,
                withBackground: true,
                backgroundColor: Colors.red,
              ),
              title: 'Dialpad',
              subtitle: "https://github.com/eopeter/flutter_dialpad",
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('And thank you', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            ),
            creditSection(
              icons: Icons.music_note,
              iconStyle: IconStyle(
                iconsColor: Colors.white,
                withBackground: true,
                backgroundColor: Colors.red,
              ),
              title: 'Sound effects obtained from',
              subtitle: "https://www.zapsplat.com",
            ),
          ],
        ),
      ),
    );
  }
}

class GameSettingsScreen extends StatelessWidget {
  const GameSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          'Settings',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.black
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.volume_down,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Sound',
                  subtitle: "TBD",
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Your data will be lost. Are you sure you want to reset your game?'),
                          actions: [
                            ElevatedButton(
                                onPressed: () async {
                                  await GameData().deleteAllData();

                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes')
                            ),
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('No')
                            )
                          ],
                        );
                      }
                    );
                  },
                  icons: Icons.refresh_sharp,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.purple,
                  ),
                  title: 'Factory Reset',
                  subtitle: "Delete all your data",
                ),
                // SettingsItem(
                //   onTap: () {},
                //   icons: Icons.dark_mode_rounded,
                //   iconStyle: IconStyle(
                //     iconsColor: Colors.white,
                //     withBackground: true,
                //     backgroundColor: Colors.red,
                //   ),
                //   title: 'Dark mode',
                //   subtitle: "Automatic",
                //   trailing: Switch.adaptive(
                //     value: false,
                //     onChanged: (value) {},
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRoute(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}