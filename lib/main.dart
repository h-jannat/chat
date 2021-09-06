import 'package:chat/views/SignInPage.dart';
import 'package:flutter/material.dart';
import './colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: ctmColor(0), bottomAppBarColor: ctmColor(3)),
      home: SignInPage(),
    );
  }
}
