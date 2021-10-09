import 'dart:async';

import 'package:chat/colors.dart';
import 'package:chat/models/Message.dart';
import 'package:chat/models/User.dart';
import 'package:chat/utilities/database.dart';
import 'package:chat/views/widgets/AppBarMain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat';
  ChatPage(this.targetUserInfo);
  final UserModel targetUserInfo;
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _databaseController = Get.put(DatabaseController());
  List<Message> messages = [];
  final _messageController = TextEditingController(text: "");
  bool _isActiveSendBtn = false;
  List infoHead = [];
  final _scrollListControler = ScrollController();
  getMessages() async {
    await _databaseController.getConversationMessages();
    setState(() {
      messages = _databaseController.messages;
    });
  }

  getInitData() async {
    await getMessages();

    infoHead = [
      Text(widget.targetUserInfo.username),
      Text(widget.targetUserInfo.email),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getInitData();
  }

  _send() async {
    if (_messageController.text != "") {
      _databaseController.sendMessage(_messageController.text);
      await getMessages();
      _messageController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Timer(
      Duration(seconds: 1),
      () => _scrollListControler
          .jumpTo(_scrollListControler.position.maxScrollExtent),
    );
    return Scaffold(
      appBar: AppBarMain(),
      body: Container(
          height: height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                color: ctmColor(1),
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      height: height - 200,
                      // child: ListView.builder(
                      //     controller: _scrollListControler,
                      //     itemCount: messages.length + 2,
                      //     itemBuilder: (context, index) {
                      //       if (index < 2) {
                      //         return infoHead[index];
                      //       } else {
                      //         print("current");
                      //         print(_databaseController.user.email);

                      //         bool isCurrentUser =
                      //             _databaseController.user.email ==
                      //                 messages[index - 2].sender;
                      //         print(messages[index - 2].sender);
                      //         return Align(
                      //             alignment: isCurrentUser
                      //                 ? Alignment.centerRight
                      //                 : Alignment.centerLeft,
                      //             child: Container(
                      //               margin: EdgeInsets.symmetric(
                      //                   horizontal: 10, vertical: 5),
                      //               padding: EdgeInsets.all(10),
                      //               decoration: BoxDecoration(
                      //                 color: isCurrentUser
                      //                     ? ctmColor(2)
                      //                     : ctmColor(3),
                      //               ),
                      //               child: Text(
                      //                 messages[index - 2].message,
                      //                 style: TextStyle(
                      //                   color: Colors.white,
                      //                   fontSize: 20,
                      //                 ),
                      //               ),
                      //             ));
                      //       }
                      //     }),

                      child: StreamBuilder<QuerySnapshot>(
                          stream: _databaseController.getMessagesStream(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return new Text('Loading...');
                            return ListView.builder(
                                controller: _scrollListControler,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  bool isCurrentUser =
                                      _databaseController.user.email ==
                                          snapshot.data?.docs[index];
                                  print(snapshot.data?.docs[index]);
                                  return Align(
                                    alignment: isCurrentUser
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: isCurrentUser
                                            ? ctmColor(2)
                                            : ctmColor(3),
                                      ),
                                      child: Text(
                                        messages[index - 2].message,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                    ),
                  ]),
                ),
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                color: Colors.white,
                height: 100,
                width: width,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    width: width * .75,
                    height: 100,
                    child: TextField(
                      controller: _messageController,
                      onChanged: (text) => setState(() {
                        _isActiveSendBtn = text != "";
                      }),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _isActiveSendBtn ? _send : null,
                    ),
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}
