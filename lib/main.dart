import 'package:chat/views/signInPage.dart';

import 'package:flutter/material.dart';
import './colors.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(GetMaterialApp(home: MyApp()));
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
        buttonTheme: ButtonThemeData(
      buttonColor: ctmColor(2),     //  <-- dark color
      textTheme: ButtonTextTheme.accent, //  <-- this auto selects the right color
    )
      ),
      home: SignInPage(),
    );
  }
}
