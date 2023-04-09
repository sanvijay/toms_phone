import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maxs_phone/libraries/game_data.dart';

import 'package:maxs_phone/libraries/notification_watcher.dart';
import 'package:maxs_phone/constants/game_constants.dart';

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
                    Navigator.of(context).push(_createRoute(const CreditsScreen()));
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'Credits',
                  subtitle: "Learn more about Max's mobile game",
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
          'Sandeep',
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
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Appearance',
                  subtitle: "Make Ziar'App yours",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Dark mode',
                  subtitle: "Automatic",
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
                    Navigator.of(context).push(_createRoute(const CreditsScreen()));
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'Credits',
                  subtitle: "Learn more about Ziar'App",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.delete,
                  title: "Delete account",
                  titleStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
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