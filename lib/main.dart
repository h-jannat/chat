import 'package:chat/views/SignInPage.dart';
import 'package:flutter/material.dart';
import './colors.dart';

void main() {
  runApp(MyApp());
}

const Map<int, Color> color = {
  50: Color.fromRGBO(0, 161, 157, .1),
  100: Color.fromRGBO(0, 161, 157, .2),
  200: Color.fromRGBO(0, 161, 157, .3),
  300: Color.fromRGBO(0, 161, 157, .4),
  400: Color.fromRGBO(0, 161, 157, .5),
  500: Color.fromRGBO(0, 161, 157, .6),
  600: Color.fromRGBO(0, 161, 157, .7),
  700: Color.fromRGBO(0, 161, 157, .8),
  800: Color.fromRGBO(0, 161, 157, .9),
  900: Color.fromRGBO(0, 161, 157, 1),
};
MaterialColor colorCustom = MaterialColor(0xFF00A19D, color);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: ctmColor(0), bottomAppBarColor: colorCustom),
      home: SignInPage(),
    );
  }
}
