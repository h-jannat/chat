import 'package:chat/utilities/database.dart';
import 'package:chat/utilities/signIn.dart';
import 'package:chat/widgets/AppBarMain.dart';
import 'package:chat/widgets/Drawer.dart';
import 'package:chat/widgets/UserCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final _loginController = Get.put(LoginController());
  final _databaseController = Get.put(DatabaseController());

  void initState() {
    _databaseController.getUserByEmail();
  }

  Widget room(roomMap) {
    print("roooom");
    print(roomMap);
    String contactName = roomMap['names'].firstWhere(
        (name) => name != _databaseController.currentUser.username,
        orElse: () => null);
    String contactEmail = roomMap['emails'].firstWhere(
        (email) => email != _databaseController.currentUser.email,
        orElse: () => null);
    return Container(
      child: UserCard(contactName, contactEmail),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int allMessagesSize = 10;
    print(_loginController.user);
    return Scaffold(
      endDrawer: SideDrawer(_loginController),
      appBar: AppBarMain(),
      body: Center(
        child: Container(
          height: height - 200,
          child: StreamBuilder<QuerySnapshot>(
              stream: _databaseController.getUserChatRooms(allMessagesSize),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text('Loading...');
                {
                  return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                    // print(document.metadata.isFromCache
                    //     ? "From cache"
                    //     : "from network");
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    print("rrrrr");
                    print(data);
                    return room(data);
                  }).toList());
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/search");
        },
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}
