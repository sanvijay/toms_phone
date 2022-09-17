import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<dynamic> allMessages = [
    {
      "icon": "",
      "name": "Sandeep",
      "lastMessage": "This is a very long text I want to write to make a big paragraph but not enough so I am writing more to make it a big paragraph"
    },
    {
      "icon": "",
      "name": "Avyukth",
      "lastMessage": "You there?"
    },
    {
      "icon": "",
      "name": "Reethika",
      "lastMessage": "You there?"
    },
    {
      "icon": "",
      "name": "Ishanvi",
      "lastMessage": "You there?"
    },
    {
      "icon": "",
      "name": "Sruthi",
      "lastMessage": "You there?"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        children: allMessages.map((e) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/message');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                            Text(e["name"], style: const TextStyle(fontWeight: FontWeight.bold),),
                            const Text("2 PM")
                          ],
                        ),
                        const SizedBox(height: 4,),
                        Text(e["lastMessage"], maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
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
