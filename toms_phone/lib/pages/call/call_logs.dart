import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';

class CallLogsWidget extends StatefulWidget {
  const CallLogsWidget({Key? key}) : super(key: key);

  @override
  State<CallLogsWidget> createState() => _CallLogsWidgetState();
}

class _CallLogsWidgetState extends State<CallLogsWidget> {
  List<dynamic> callLogs = [
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "incoming"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "outgoing"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "missed"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "rejected"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "incoming"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "incoming"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "incoming"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "incoming"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "incoming"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "incoming"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "incoming"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now(),
      "callStatus": "incoming"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now().subtract(Duration(days:1)),
      "callStatus": "incoming"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now().subtract(Duration(days:2)),
      "callStatus": "incoming"
    },
    {
      "phoneNumber": "+91 9042186832",
      "dateTime": DateTime.now().subtract(Duration(days:2)),
      "callStatus": "incoming"
    },
  ];

  Widget groupCallLogs() {
    var groupedLogs = groupBy(callLogs, (obj) {
      int difference = DateTime.now().difference((obj as Map)["dateTime"]).inDays;

      if (difference == 0) { return "Today"; }
      else if (difference == 1) { return "Yesterday"; }
      else { return DateFormat("MMMM d").format(obj["dateTime"]); }
    });

    List<Widget> logWidgets = [];

    groupedLogs.forEach((date, logs) {
      logWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(date),
        )
      );

      List<Widget> dayLogWidgets = [];

      for (var log in logs) {
        dayLogWidgets.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                      log["callStatus"] == "outgoing" ? Icons.phone_forwarded : (log["callStatus"] == "incoming" ? Icons.phone_callback : (log["callStatus"] == "missed" ? Icons.phone_missed : Icons.phone_disabled))
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/phone-call", arguments: { 'outgoingCall': true, 'phoneNumber': log["phoneNumber"] });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(log["phoneNumber"].toString()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(Icons.mic, color: Colors.grey, size: 16,),
                            const SizedBox(height: 4,),
                            Text(DateFormat("h:mm a").format(log["dateTime"])),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (String? value) {},
                  itemBuilder: (BuildContext context) {
                    return {'Logout', 'Settings'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
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
          'Phone',
          style: TextStyle(
              fontSize: 16,
              color: Colors.black
          ),
        ),
      ),
      body: groupCallLogs(),
    );
  }
}
