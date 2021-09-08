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
      theme: ThemeData(
        primarySwatch: ctmMaterialColor(0),
        bottomAppBarColor: ctmMaterialColor(3),
        accentColor: ctmMaterialColor(2),
      ),
      home: SignInPage(),
    );
  }
}
