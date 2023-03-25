import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:toms_phone/models/user.model.dart';

import '../models/message.model.dart';
import '../models/notification.model.dart';

import 'package:timeago/timeago.dart' as timeago;

class MessageScreen extends StatefulWidget {
  final bool isMessenger;
  const MessageScreen({Key? key, required this.isMessenger}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState(isMessenger: isMessenger);
}

class _MessageScreenState extends State<MessageScreen> {
  bool isMessenger;
  late Isar isar;

  List<MessageModel> allMessages = [];

  _MessageScreenState({
    required this.isMessenger
  });

  void setDataFromDB() async {
    await assignIsarObject();
    allMessages = await isar.messageModels
        .filter()
        .messageTypeEqualTo(isMessenger ? MessageType.socioMessage : MessageType.message)
        .sortByCreatedAt()
        .findAll();

    setState(() { });
  }

  @override
  void initState() {
    super.initState();

    setDataFromDB();
  }

  assignIsarObject() async {
    isar = Isar.getInstance("default") ?? await Isar.open([NotificationModelSchema, MessageModelSchema, UserModelSchema]);
  }

  List<MessageModel> findLatestMessage() {
    Map<String, MessageModel> lastMessagesMap = Map<String, MessageModel>.fromIterable(allMessages, key: (item) => item.chatWith.value?.phoneNumber, value: (item) => item);

    return lastMessagesMap.values.sortedBy((e) => e.createdAt).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isMessenger ? Colors.orangeAccent : Colors.white,
      appBar: AppBar(
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
          'Messages',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.black
          ),
        ),
      ),
      body: ListView(
        children: findLatestMessage().map((e) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(isMessenger ? '/messenger_chat' : '/message', arguments: { 'phoneNumber': e.chatWith.value?.phoneNumber });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Ink(
                      padding: const EdgeInsets.all(4),
                      decoration: const ShapeDecoration(
                        color: Colors.grey,
                        shape: CircleBorder(),
                      ),
                      child: const Icon(Icons.person, color: Colors.white, size: 24,),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.chatWith.value?.contactName ?? e.chatWith.value?.phoneNumber ?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                            // const Text("2 PM")
                            Text(timeago.format(e.createdAt))
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Text(e.text, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      )
    );
  }
}
