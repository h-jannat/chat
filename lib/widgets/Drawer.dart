import 'package:chat/utilities/database.dart';
import 'package:chat/widgets/ProfilePhoto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer(this._loginController);
  final _loginController;
  final _databaseController = Get.put(DatabaseController());
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Column(
              children: [
                ProfilePhoto('', 50),
                Text(
                  _databaseController.currentUser.username,
                  style: TextStyle(fontSize: 17),
                ),
                Text(_databaseController.currentUser.email),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ListTile(
                  title: Text('Home'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                Divider(),
                ListTile(
                  title: const Text('Start new message'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                OutlinedButton(
                    child: Text("Edit profile photo"), onPressed: () => {})
              ],
            ),
          )
        ],
      ),
    );
  }
}
