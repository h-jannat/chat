import 'package:chat/colors.dart';
import 'package:chat/models/User.dart';
import 'package:chat/utilities/database.dart';
import 'package:chat/views/widgets/AppBarMain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat';
  ChatPage(this.targetUserInfo);
  final User targetUserInfo;
  @override
  _ChatPageState createState() => _ChatPageState(targetUserInfo);
}

class _ChatPageState extends State<ChatPage> {
  _ChatPageState(this._targetUserInfo);
  final User _targetUserInfo;

  final _databaseController = Get.put(DatabaseController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBarMain(),
      body: Container(
          height: height,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                color: ctmColor(2),
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(_targetUserInfo.username),
                      Text(_targetUserInfo.email),
                    ],
                  ),
                ),
              ),
              Container(
               // padding: EdgeInsets.symmetric(horizontal: 10),
               alignment: Alignment.center,
               color: ctmColor(1),
                height: 100,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                    width: width * .75,
                    height: 100,
                    
                    child: TextField(
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
                      onPressed: () => {},
                    ),
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}
