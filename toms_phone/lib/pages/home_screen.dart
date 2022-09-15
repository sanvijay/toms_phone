import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toms_phone/pages/message_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime now = DateTime.now();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(minutes: 1,), (Timer t) => checkForNewTime());
  }

  void checkForNewTime() {
    setState(() {
      now = DateTime.now();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Route _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        // show the confirm dialog
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Are you sure want to leave?'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    willLeave = true;
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('No')
                )
              ],
            ));
        return willLeave;
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/wallpaper.png"), fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 140,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 48,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${DateFormat("h").format(now)}:${DateFormat("mm").format(now)}",
                            style: const TextStyle(
                                fontSize: 48.0,
                                // fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            DateFormat("a").format(now),
                            style: const TextStyle(
                                fontSize: 16.0,
                                // fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          DateFormat("EEE").format(now),
                          style: const TextStyle(
                              fontSize: 16.0,
                              // fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          DateFormat("MMM d").format(now),
                          style: const TextStyle(
                              fontSize: 16.0,
                              // fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            items: [
              BottomNavigationBarItem(icon: iconWidget(label: "", icon: const Icon(Icons.phone), iconColor: Colors.green, context: context, onPressed: () { Navigator.pushNamed(context, "/call"); }, ), label: ''),
              BottomNavigationBarItem(icon: iconWidget(label: "", icon: const Icon(Icons.photo), iconColor: Colors.pinkAccent, context: context, ), label: ''),
              // BottomNavigationBarItem(icon: iconWidget(label: "", icon: const Icon(Icons.apps_rounded), color: Colors.grey, iconColor: Colors.white, context: context, onPressed: () { Navigator.of(context).push(_createRoute(const AppDrawerScreen())); }, ), label: ''),
              BottomNavigationBarItem(icon: Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 20), child: Image.asset("assets/images/drawer_icon_512.png", width: 64,),), label: ''),
              BottomNavigationBarItem(icon: iconWidget(label: "", icon: const Icon(Icons.message), iconColor: Colors.blueAccent, context: context, onPressed: () { Navigator.pushNamed(context, "/messages"); }, ), label: ''),
              BottomNavigationBarItem(icon: iconWidget(label: "", icon: const Icon(Icons.photo_camera), iconColor: Colors.redAccent, context: context, ), label: ''),
            ],
            onTap: (index) {
              switch(index) {
                case 0: {
                  Navigator.of(context).push(_createRoute(const MessageScreen()));
                }
                break;
                case 1: {
                  Navigator.of(context).push(_createRoute(const MessageScreen()));
                }
                break;
                case 2: {
                  Navigator.of(context).push(_createRoute(const AppDrawerScreen()));
                }
                break;
                case 3: {
                  Navigator.of(context).push(_createRoute(const MessageScreen()));
                }
                break;
                case 4: {
                  Navigator.of(context).push(_createRoute(const MessageScreen()));
                }
                break;
                default: {}
                break;
              }
            },
          ),
        ),
      ),
    );
  }
}

class AppDrawerScreen extends StatelessWidget {
  const AppDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/wallpaper.png"), fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.4),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            // Generate 100 widgets that display their index in the List.
            children: [
              iconWidget(label: "Phone", icon: const Icon(Icons.phone), iconColor: Colors.green, context: context, ),
              iconWidget(label: "Mail", icon: const Icon(Icons.mail), iconColor: Colors.blue, context: context, ),
              iconWidget(label: "Browser", icon: const Icon(Icons.language_rounded), iconColor: Colors.brown, context: context, ),
              iconWidget(label: "Compass", icon: const Icon(Icons.explore_outlined), iconColor: Colors.pink, context: context, ),
              iconWidget(label: "Maps", icon: const Icon(Icons.fmd_good_rounded), iconColor: Colors.amber, context: context, ),
              iconWidget(label: "Audio Player", icon: const Icon(Icons.headphones_rounded), iconColor: Colors.indigo, context: context, ),
              iconWidget(label: "My files", icon: const Icon(Icons.folder), iconColor: Colors.orangeAccent, context: context, ),
              iconWidget(label: "Camera", icon: const Icon(Icons.photo_camera), iconColor: Colors.redAccent, context: context, ),
              iconWidget(label: "Messages", icon: const Icon(Icons.message), iconColor: Colors.blueAccent, context: context, onPressed: () { Navigator.pushNamed(context, "/messages"); }, ),
              iconWidget(label: "Clock", icon: const Icon(Icons.alarm), iconColor: Colors.deepPurpleAccent, context: context, ),
              iconWidget(label: "Contacts", icon: const Icon(Icons.person), iconColor: Colors.deepOrangeAccent, context: context, ),
              iconWidget(label: "Calculator", icon: const Icon(Icons.calculate), iconColor: Colors.lightGreen, context: context, onPressed: () { Navigator.pushNamed(context, "/calculator"); }, ),
              iconWidget(label: "Radio", icon: const Icon(Icons.radio), iconColor: Colors.purple, context: context, ),
              iconWidget(label: "Weather", icon: const Icon(Icons.cloudy_snowing), iconColor: Colors.blueAccent, context: context, ),
              iconWidget(label: "Calendar", icon: const Icon(Icons.calendar_month), iconColor: Colors.blueGrey, context: context, ),
              iconWidget(label: "Gallery", icon: const Icon(Icons.photo), iconColor: Colors.pinkAccent, context: context, ),
              iconWidget(label: "Settings", icon: const Icon(Icons.settings), iconColor: Colors.grey, context: context, onPressed: () { Navigator.pushNamed(context, "/settings"); }, ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 56,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                    ),
                    child: GestureDetector(
                      onTap: () { Navigator.pushNamed(context, "/sudoku"); },
                      child: Image.asset("assets/images/sudoku_icon.png", width: 60,),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Text(
                    "Sudoku Solver",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget iconWidget({ required String label, required Icon icon, required Color iconColor, VoidCallback? onPressed, required BuildContext context, color = Colors.white }) {
  VoidCallback onPressEvent = onPressed ?? () => showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('ERROR!'),
      content: const Text('Error in application'),
      actions: <Widget>[
        // TextButton(
        //   onPressed: () => Navigator.pop(context, 'Cancel'),
        //   child: const Text('Cancel'),
        // ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );

  return Column(
    children: [
      Ink(
        decoration: ShapeDecoration(
          color: iconColor,
          shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
        ),
        child: IconButton(
          icon: icon,
          iconSize: 40,
          color: color,
          onPressed: onPressEvent,
        ),
      ),
      const SizedBox(height: 5,),
      Text(
        label,
        style: const TextStyle(
            fontSize: 12,
            color: Colors.white
        ),
      ),
    ],
  );
}
