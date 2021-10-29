import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  ProfilePhoto(this.photoURL);
  final photoURL;
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: photoURL != null && photoURL != ""
            ? NetworkImage(photoURL)
            : AssetImage(
                "assets/images/user.png",
              ) as ImageProvider);
  }
}
