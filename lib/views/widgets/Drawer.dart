import 'package:flutter/material.dart';
import '../../colors.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer(this.user);
  final user;
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: ctmColor(1),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL, ),
                    radius: 50,
                  ),
                  Text(user.displayName),
                  Text(user.email)
                ],
              )),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Divider(),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
