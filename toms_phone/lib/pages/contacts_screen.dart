import 'package:flutter/material.dart';
import 'package:toms_phone/pages/call/contacts.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ContactsWidget(),
    );
  }
}
