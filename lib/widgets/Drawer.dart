import 'package:flutter/material.dart';
import '../../colors.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer(this._loginController);
  final _loginController;
  Widget build(BuildContext context) {
    return Drawer(
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
