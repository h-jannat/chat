import 'package:chat/views/SignInPage.dart';
import 'package:flutter/material.dart';

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
  // This widget is the root of your application.
  // 1:Color.fromARGB(255, 0, 161, 157),
  //   2:Color.fromARGB(255,255, 248, 229),
  //   3:Color.fromARGB(255, 255, 179, 68),
  //   4: Color.fromARGB(255, 224, 93, 93),
// //#00A19D
// #FFF8E5
// #FFB344
// #E05D5D

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(
           primarySwatch: colorCustom,
           bottomAppBarColor: colorCustom
           ),
      home: SignInPage(),
    );
  }
}
