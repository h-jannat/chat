import 'package:flutter/material.dart';
import 'package:chat/utilities/database.dart';
import 'package:chat/colors.dart';
import 'package:get/get.dart';

class MessageItem extends StatelessWidget {
  final _databaseController = Get.put(DatabaseController());
  Map<String, dynamic> messageMap;

  MessageItem(
    this.messageMap,
  );

  Widget build(BuildContext context) {
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
}
