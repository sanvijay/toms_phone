import 'package:flutter/material.dart';
import 'package:toms_phone/pages/socio/post_card.dart';

class SocioScreen extends StatefulWidget {
  const SocioScreen({Key? key}) : super(key: key);

  @override
  State<SocioScreen> createState() => _SocioScreenState();
}

class _SocioScreenState extends State<SocioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        automaticallyImplyLeading: false,
        title: const Text("Sociogram"),
        actions: [
          IconButton(onPressed: () { Navigator.pushNamed(context, "/messenger"); }, icon: const Icon(Icons.message)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List<Widget>.generate(3, (int index) => const PostCard(), growable: false),
        ),
      ),
    );
  }
}
