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
      "lastMessage": "You there?"
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.person),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(e["name"]),
                              const Text("2 PM")
                            ],
                          ),
                          Row(
                            children: [
                              Text(e["lastMessage"]),
                            ],
                          )
                        ],
                      ),
                    ],
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
