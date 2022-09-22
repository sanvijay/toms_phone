import 'package:flutter/material.dart';
import 'package:toms_phone/pages/socio/post_card.dart';

class SocioProfileScreen extends StatefulWidget {
  const SocioProfileScreen({Key? key}) : super(key: key);

  @override
  State<SocioProfileScreen> createState() => _SocioProfileState();
}

class _SocioProfileState extends State<SocioProfileScreen> with TickerProviderStateMixin {
  Widget FriendComponent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Icon(
              Icons.person_pin,
              size: 50,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/socio-profile");
              },
              child: Text("Sandeep"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        automaticallyImplyLeading: false,
        title: const Text("Sociogram"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.person),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sandeep", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Text("0 posts", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(width: 8,),
                            Text("|"),
                            SizedBox(width: 8,),
                            Text("0 followers", style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        )
                      ],
                    )
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () { Navigator.pushNamed(context, "/messenger_chat"); }, child: const Text("Message")),
          ),
          TabBar(
            controller: tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Posts"),
              Tab(text: "Friends",)
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: List<Widget>.generate(3, (int index) => const PostCard(), growable: false),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: List<Widget>.generate(3, (int index) => FriendComponent(), growable: false),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
