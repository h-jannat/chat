import 'dart:async';
import 'package:chat/colors.dart';
import 'package:chat/models/Message.dart';
import 'package:chat/models/User.dart';
import 'package:chat/utilities/database.dart';
import 'package:chat/widgets/AppBarMain.dart';
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
  final _scrollListController = ScrollController();
  int allMessagesSize = 10;

  getInitData() {
    infoHead = [
      Text(widget.targetUserInfo.username),
      Text(widget.targetUserInfo.email),
    ];
  }

  @override
  void initState() {
    super.initState();
    getInitData();

    _scrollListController.addListener(() {
      if (_scrollListController.position.atEdge) {
        if (_scrollListController.position.pixels == 0) {
          print("get more messages");
          _databaseController.increaseShownMessages();
          setState(() {
            allMessagesSize = _databaseController.shownMessagesCount;
          });
        }
      }
    });
  }

  _send() async {
    if (_messageController.text != "") {
      _databaseController.sendMessage(_messageController.text);

      _messageController.text = "";
    }
  }

  Widget message(messageMap) {
    bool isCurrentUser = _databaseController.user.email == messageMap["sender"];

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isCurrentUser ? ctmColor(2) : ctmColor(0),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topLeft: isCurrentUser ? Radius.circular(8.0) : Radius.zero,
            topRight: isCurrentUser ? Radius.zero : Radius.circular(8.0),
          ),
        ),
        child: Text(
          messageMap["message"],
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (allMessagesSize == 10) {
      Timer(
        Duration(seconds: 1),
        () => _scrollListController
            .jumpTo(_scrollListController.position.maxScrollExtent),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.targetUserInfo.username),
      ),
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
                      child: StreamBuilder<QuerySnapshot>(
                          stream: _databaseController
                              .getMessagesStream(allMessagesSize),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return new Text('Loading...');
                            {
                              return ListView(
                                  controller: _scrollListController,
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    // print(document.metadata.isFromCache
                                    //     ? "From cache"
                                    //     : "from network");
                                    Map<String, dynamic> data =
                                        document.data() as Map<String, dynamic>;
                                    return message(data);
                                  }).toList());
                            }
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
