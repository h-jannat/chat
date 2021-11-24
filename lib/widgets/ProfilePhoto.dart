import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  ProfilePhoto(this.photoURL, this.radius);
  final photoURL;
  final double radius;
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        backgroundImage: photoURL != null && photoURL != ""
            ? NetworkImage(photoURL)
            : AssetImage(
                "assets/images/user.png",
              ) as ImageProvider);
  }
}
