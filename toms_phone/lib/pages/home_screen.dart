import 'package:flutter/material.dart';
import 'package:toms_phone/pages/message_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Route _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          alignment: Alignment.bottomRight,
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        );
      },
    );
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
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(icon: Image.asset("assets/images/phone_icon_64.png", width: 56,), label: 'Phone'),
            BottomNavigationBarItem(icon: Image.asset("assets/images/gallery_icon_64.png", width: 56,), label: 'Gallery'),
            BottomNavigationBarItem(icon: Image.asset("assets/images/message_icon_64.png", width: 56,), label: 'Messages'),
            BottomNavigationBarItem(icon: Image.asset("assets/images/camera2_icon_64.png", width: 56,), label: 'Camera'),
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
                Navigator.of(context).push(_createRoute(const MessageScreen()));
              }
              break;
              case 3: {
                Navigator.of(context).push(_createRoute(const MessageScreen()));
              }
              break;
              default: {}
              break;
            }
          },
        ),
      ),
    );
  }
}
