import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:maxs_phone/services/isar_service.dart';

import '../models/message.model.dart';
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
  late Timer timer;

  @override
  void initState() {
    super.initState();
    setDataFromDB();

    timer = Timer.periodic(const Duration(seconds: 3,), (Timer t) => checkNewData());
  }

  void checkNewData() {
    setDataFromDB();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void setDataFromDB() async {
    await assignIsarObject();
    allMessages = await isar.messageModels
        .filter()
        .messageTypeEqualTo(isMessenger ? MessageType.socioMessage : MessageType.message)
        .sortByCreatedAt()
        .findAll();

    setState(() { });
  }

  assignIsarObject() async {
    isar = await IsarService().db;
  }

  List<MessageModel> findLatestMessage() {
    Map<String, MessageModel> lastMessagesMap = Map<String, MessageModel>.fromIterable(allMessages, key: (item) => item.chatWith.value?.phoneNumber, value: (item) => item);

    return lastMessagesMap.values.sortedBy((e) => e.createdAt).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: isMessenger ? Colors.redAccent : Colors.white10,
        title: Text(
          isMessenger ? 'SocioMessenger' : 'Messages',
          style: const TextStyle(
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
            child: Container(
              color: e.read ? Colors.transparent : Colors.black12,
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
