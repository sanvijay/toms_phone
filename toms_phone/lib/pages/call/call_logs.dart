import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:maxs_phone/models/call_log.model.dart';

import '../../services/isar_service.dart';

class CallLogsWidget extends StatefulWidget {
  const CallLogsWidget({Key? key}) : super(key: key);

  @override
  State<CallLogsWidget> createState() => _CallLogsWidgetState();
}

class _CallLogsWidgetState extends State<CallLogsWidget> {
  List<CallLogModel> callLogs = [];
  late Isar isar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setDataFromDB();
  }

  void setDataFromDB() async {
    await assignIsarObject();
    callLogs = await isar.callLogModels
        .filter()
        .idIsNotNull()
        .sortByCreatedAtDesc()
        .findAll();

    setState(() { });
  }

  assignIsarObject() async {
    isar = await IsarService().db;
  }

  Widget groupCallLogs() {
    var groupedLogs = groupBy(callLogs, (CallLogModel obj) {
      int difference = DateTime.now().difference(obj.createdAt).inDays;

      if (difference == 0) { return "Today"; }
      else if (difference == 1) { return "Yesterday"; }
      else { return DateFormat("MMMM d").format(obj.createdAt); }
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
                      log.callType == CallType.outgoing ? Icons.phone_forwarded : (log.callType == CallType.incoming ? Icons.phone_callback : (log.callType == CallType.missed ? Icons.phone_missed : Icons.phone_disabled))
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/phone-call", arguments: { 'outgoingCall': true, 'phoneNumber': log.callWith.value!.phoneNumber, 'contactName': log.callWith.value!.contactName });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text((log.callWith.value!.contactName ?? log.callWith.value!.phoneNumber).toString()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(Icons.mic, color: Colors.grey, size: 16,),
                            const SizedBox(height: 4,),
                            Text(DateFormat("h:mm a").format(log.createdAt)),
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
