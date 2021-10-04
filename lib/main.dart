import 'package:chat/utilities/signIn.dart';
import 'package:chat/views/HomePage.dart';
import 'package:chat/views/SearchPage.dart';
import 'package:chat/views/SignInPage.dart';
import 'package:chat/views/SignUpPage.dart';
import 'package:chat/views/VarifyPage.dart';

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
  final _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:  TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(),
    ).apply(
      bodyColor: Colors.grey[800], 
      displayColor: Colors.blue, 
    ),
        primarySwatch: ctmMaterialColor(0),
        bottomAppBarColor: ctmMaterialColor(3),
        accentColor: ctmMaterialColor(2),
        buttonTheme: ButtonThemeData(
      buttonColor: ctmColor(2),     //  <-- dark color
      textTheme: ButtonTextTheme.accent, //  <-- this auto selects the right color
    )
      ),
      home: _loginController.user ==null? SignInPage(): HomePage(),
       
  routes: {
    '/home': (context) =>  HomePage(),
    '/signIn': (context) => SignInPage(),
    '/signUp': (context) => SignUpPage(),
    '/search': (context) => SearchPage(),
    '/varify': (context) => VarifyPage(),
  },
    );
  }
}
