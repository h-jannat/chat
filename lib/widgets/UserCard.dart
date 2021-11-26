import 'package:chat/models/User.dart';
import 'package:chat/utilities/database.dart';
import 'package:chat/widgets/ProfilePhoto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCard extends StatelessWidget {
  UserCard(this._username, this._email);
  final _username;
  final _email;
  final _databaseController = Get.put(DatabaseController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfilePhoto(_databaseController.currentUser.photoURL, 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_username),
              Text(_email),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                _databaseController.createChatRoom(_username, _email);
                print("arguments");
                print({"username": _username, "email": _email});
                Navigator.pushNamed(
                  context,
                  "/chat",
                  arguments: UserModel(
                      username: _username, email: _email, photoURL: ""),
                );
              },
              child: Text("Message"))
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
