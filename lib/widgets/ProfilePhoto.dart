import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  final double radius;
  final String url;
  ProfilePhoto(this.url, this.radius);

  Widget build(BuildContext context) {
    print('photo');
    print(url);
    return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        backgroundImage: url != ""
            ? NetworkImage(url)
            : AssetImage(
                "assets/images/user.png",
              ) as ImageProvider);
  }
}
