import 'package:flutter/material.dart';

class AppBarMain extends StatelessWidget{
  

Widget build(BuildContext context) {
  return AppBar(
    title: Image.asset(
      "assets/images/logo.jpg",
      height: 50,
    ),
  );
}

}