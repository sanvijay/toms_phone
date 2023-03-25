import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../models/message.model.dart';
import '../models/notification.model.dart';
import '../models/user.model.dart';

String username = 'User';
String email = 'user@example.com';
String messageText = '';

class MessageChatScreen extends StatefulWidget {
  late bool isMessenger;
  MessageChatScreen({Key? key, required this.isMessenger}) : super(key: key);

  @override
  _MessageChatScreenState createState() => _MessageChatScreenState(isMessenger: isMessenger);
}

class _MessageChatScreenState extends State<MessageChatScreen> {
  final chatMsgTextController = TextEditingController();
  final bool isMessenger;
  String? phoneNumber;
  late Isar isar;

  _MessageChatScreenState({
    required this.isMessenger
  });

  @override
  void initState() {
    super.initState();
    assignIsarObject();
    // getMessages();
  }

  assignIsarObject() async {
    isar = Isar.getInstance("default") ?? await Isar.open([NotificationModelSchema, MessageModelSchema, UserModelSchema]);
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

  String chatWithName() {
    UserModel? user = phoneNumber == null ? null : isar.userModels.filter().phoneNumberEqualTo(phoneNumber!).findFirstSync();

    return user == null ? '' : user.contactName ?? user.phoneNumber;
  }

  Widget chatMessages() {
    List<dynamic> allMessages = phoneNumber == null ? [] : isar.messageModels.filter().chatWith((q) => q.phoneNumberEqualTo(phoneNumber!)).findAllSync();

    var messageBubbles = phoneNumber == null ? [] : allMessages.map((msg) {
      return MessageBubble(
        msg: msg,
        isMessenger: isMessenger
      );
    }).toList();

    return ListView(
      reverse: true,
      children: [
        const SizedBox(height: 72,),
        ...messageBubbles,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    setState(() { phoneNumber = data['phoneNumber']; });

    return Scaffold(
      backgroundColor: isMessenger ? Colors.orangeAccent : Colors.white,
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
        title: Text(
          chatWithName(),
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
      body: Stack(
        children: [
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              width: MediaQuery.of(context).size.width,
              color: isMessenger ? Colors.grey[700] : Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: isMessenger ? Colors.white : Colors.black),
                      decoration: const InputDecoration(
                        hintText: "",
                        border: InputBorder.none,
                      ),
                    ),
                    // child: Material(
                    //   borderRadius: BorderRadius.circular(50),
                    //   color: Colors.white,
                    //   elevation:5,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left:8.0,top:2,bottom: 2),
                    //     child: TextField(
                    //       onChanged: (value) {
                    //         messageText = value;
                    //       },
                    //       controller: chatMsgTextController,
                    //       decoration: kMessageTextFieldDecoration,
                    //     ),
                    //   ),
                    // ),
                  ),
                  MaterialButton(
                    shape: const CircleBorder(),
                    color: isMessenger ? Colors.redAccent : Colors.green,
                    onPressed: () {
                      chatMsgTextController.clear();
                      // _firestore.collection('messages').add({
                      //   'sender': username,
                      //   'text': messageText,
                      //   'timestamp':DateTime.now().millisecondsSinceEpoch,
                      //   'senderemail': email
                      // });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.send,color: Colors.white,),
                    )
                    // Text(
                    //   'Send',
                    //   style: kSendButtonTextStyle,
                    // ),
                  ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool isMessenger;
  final MessageModel msg;

  MessageBubble({
    required this.msg,
    required this.isMessenger
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
        !msg.incoming ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: Text(DateFormat("MMMM d h:mm a").format(msg.createdAt)),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(isMessenger ? 40 : 12),
              topLeft: !msg.incoming ? Radius.circular(isMessenger ? 40 : 12) : const Radius.circular(0),
              bottomRight: Radius.circular(isMessenger ? 40 : 12),
              topRight: !msg.incoming ? const Radius.circular(0) : Radius.circular(isMessenger ? 40 : 12),
            ),
            color: !msg.incoming ? Colors.lightGreen : Colors.grey[400],
            elevation: isMessenger ? 4 : 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                msg.text,
                style: TextStyle(
                  color: !msg.incoming ? Colors.white : Colors.black,
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
