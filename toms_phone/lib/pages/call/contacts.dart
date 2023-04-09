import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:isar/isar.dart';
import 'package:maxs_phone/models/message.model.dart';
import 'package:maxs_phone/models/notification.model.dart';
import 'dart:math' as math;

import '../../models/message_option.model.dart';
import '../../models/user.model.dart';
import '../../services/isar_service.dart';

class ContactsWidget extends StatefulWidget {
  const ContactsWidget({Key? key}) : super(key: key);

  @override
  State<ContactsWidget> createState() => _ContactsWidgetState();
}

class _ContactsWidgetState extends State<ContactsWidget> {
  late Isar isar;
  List<UserModel> contactList = [];

  void setMessagesFromDB() async {
    await assignIsarObject();
    contactList = await isar.userModels
        .filter()
        .contactNameIsNotEmpty()
        .findAll();

    setState(() { });
  }

  assignIsarObject() async {
    isar = await IsarService().db;
  }

  @override
  void initState() {
    super.initState();

    setMessagesFromDB();
  }

  void somethingWentWrong() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        content: const Text("Something went wrong!", textAlign: TextAlign.center,),
        margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),
      )
    );
  }

  Widget groupContacts() {
    var groupedContacts = groupBy(contactList, (obj) {
      return (obj as UserModel).contactName![0];
    });

    List<Widget> logWidgets = [];

    groupedContacts.forEach((firstLetter, logs) {
      logWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(firstLetter, style: const TextStyle(fontWeight: FontWeight.bold),),
        )
      );

      List<Widget> dayLogWidgets = [];

      for (var log in logs) {
        dayLogWidgets.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: Icon(
                    Icons.person_pin,
                    color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                    size: 50,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/phone-call", arguments: { 'outgoingCall': true, 'phoneNumber': log.phoneNumber, "contactName": log.contactName });
                    },
                    child: Text(log.contactName.toString()),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (String? value) {},
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        onTap: () {
                          somethingWentWrong();
                        },
                        child: const Text("Edit"),
                      ),
                    ];
                  },
                ),
              ],
            ),
          )
        );
      }

      logWidgets.add(
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: dayLogWidgets,
            ),
          )
      );
    });

    return ListView(
      children: logWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            child: const Icon(Icons.person_add_alt_1, color: Colors.black,),
            onTap: () {
              somethingWentWrong();
            },
          ),
          const SizedBox(width: 20,),
        ],
        automaticallyImplyLeading: false,
        // iconTheme: const IconThemeData(color: Colors.deepPurple),
        elevation: 0,
        // bottom: PreferredSize(
        //   preferredSize: const Size(25, 10),
        //   child: Container(
        //     decoration: const BoxDecoration(
        //       // color: Colors.blue,
        //
        //       // borderRadius: BorderRadius.circular(20)
        //     ),
        //     constraints: const BoxConstraints.expand(height: 1),
        //     child: LinearProgressIndicator(
        //       valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        //       backgroundColor: Colors.blue[100],
        //     ),
        //   ),
        // ),
        backgroundColor: Colors.white10,
        // leading: Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: CircleAvatar(backgroundImage: NetworkImage('https://cdn.clipart.email/93ce84c4f719bd9a234fb92ab331bec4_frisco-specialty-clinic-vail-health_480-480.png'),),
        // ),
        title: const Text(
          'Contacts',
          style: TextStyle(
              fontSize: 16,
              color: Colors.black
          ),
        ),
      ),
      body: groupContacts(),
    );
  }
}
