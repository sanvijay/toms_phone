import 'package:flutter/material.dart';
import 'package:toms_phone/constants/constants.dart';

String username = 'User';
String email = 'user@example.com';
String messageText = '';

class MessageChatScreen extends StatefulWidget {
  const MessageChatScreen({Key? key}) : super(key: key);

  @override
  _MessageChatScreenState createState() => _MessageChatScreenState();
}

class _MessageChatScreenState extends State<MessageChatScreen> {
  final chatMsgTextController = TextEditingController();

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
    {
      "icon": "",
      "name": "Sruthi",
      "lastMessage": "You there?"
    },
    {
      "icon": "",
      "name": "Sruthi",
      "lastMessage": "You there?"
    },
    {
      "icon": "",
      "name": "Sruthi",
      "lastMessage": "You there?"
    },
    {
      "icon": "",
      "name": "Sruthi",
      "lastMessage": "You there?"
    },
  ];

  @override
  void initState() {
    super.initState();
    // getMessages();
  }

  // void getMessages()async{
  //   final messages=await _firestore.collection('messages').getDocuments();
  //   for(var message in messages.documents){
  //     print(message.data);
  //   }
  // }

  // void messageStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     snapshot.documents;
  //   }
  // }

  List<Widget> chatMessages() {
    return allMessages.map((msg) {
      return MessageBubble(
        msgText: "message text message text message text message text message text message text message text message text",
        msgSender: msg["name"],
        user: msg["name"] == "Sandeep"
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
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
          'Sandeep',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.black
          ),
        ),
        // actions: <Widget>[
        //   GestureDetector(
        //     child: const Icon(Icons.more_vert),
        //   )
        // ],
      ),
      body: ListView(
        children: <Widget>[
          ...chatMessages(),
          Container(
            padding: const EdgeInsets.symmetric(vertical:10,horizontal: 10),
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    elevation:5,
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0,top:2,bottom: 2),
                      child: TextField(
                        onChanged: (value) {
                          messageText = value;
                        },
                        controller: chatMsgTextController,
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  shape: const CircleBorder(),
                  color: Colors.blue,
                  onPressed: () {
                    chatMsgTextController.clear();
                    // _firestore.collection('messages').add({
                    //   'sender': username,
                    //   'text': messageText,
                    //   'timestamp':DateTime.now().millisecondsSinceEpoch,
                    //   'senderemail': email
                    // });
                  },
                  child:const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.send,color: Colors.white,),
                  )
                  // Text(
                  //   'Send',
                  //   style: kSendButtonTextStyle,
                  // ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class ChatStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final messages = snapshot.data.documents.reversed;
//           List<MessageBubble> messageWidgets = [];
//           for (var message in messages) {
//             final msgText = message.data['text'];
//             final msgSender = message.data['sender'];
//             // final msgSenderEmail = message.data['senderemail'];
//             final currentUser = "Tom"; // TODO: Change this later
//
//             // print('MSG'+msgSender + '  CURR'+currentUser);
//             final msgBubble = MessageBubble(
//                 msgText: msgText,
//                 msgSender: msgSender,
//                 user: currentUser == msgSender);
//             messageWidgets.add(msgBubble);
//           }
//           return Expanded(
//             child: ListView(
//               reverse: true,
//               padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//               children: messageWidgets,
//             ),
//           );
//         } else {
//           return Center(
//             child:
//             CircularProgressIndicator(backgroundColor: Colors.deepPurple),
//           );
//         }
//       },
//     );
//   }
// }

class MessageBubble extends StatelessWidget {
  final String msgText;
  final String msgSender;
  final bool user;

  MessageBubble({
    required this.msgText,
    required this.msgSender,
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
        user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              msgSender,
              style: const TextStyle(
                  fontSize: 13, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(50),
              topLeft: user ? const Radius.circular(50) : const Radius.circular(0),
              bottomRight: const Radius.circular(50),
              topRight: user ? const Radius.circular(0) : const Radius.circular(50),
            ),
            color: user ? Colors.blue : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                msgText,
                style: TextStyle(
                  color: user ? Colors.white : Colors.blue,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
