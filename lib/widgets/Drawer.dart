import 'dart:io';
import 'package:chat/utilities/database.dart';
import 'package:chat/widgets/ProfilePhoto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideDrawer extends StatefulWidget {
  @override
  SideDrawerState createState() {
    return SideDrawerState();
  }
}

class SideDrawerState extends State<SideDrawer> {
  final _databaseController = Get.put(DatabaseController());
  Future selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result == null) return;
      final path = result.files.single.path;
      if (path == null) return;
      File file = File(path);
      final String fileName =
          "${_databaseController.currentUser.username}-profile-photo";
      final destination = 'profileImages/$fileName';
      await _databaseController.uploadFile(destination, file);
      await _databaseController.setUserPhotoURL();
    } catch (e) {
      print(e);
    }
  }

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
                ProfilePhoto(_databaseController.currentUser.photoURL, 50),
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
                    child: Text("Edit profile photo"), onPressed: selectFile)
              ],
            ),
          )
        ],
      ),
    );
  }
}
