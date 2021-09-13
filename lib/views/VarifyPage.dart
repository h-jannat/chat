import 'dart:async';
import 'package:chat/views/HomePage.dart';
import 'package:get/get.dart';

import '../utilities/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VarifyPage extends StatefulWidget {
  @override
  _VarifyPageState createState() => _VarifyPageState();
}

class _VarifyPageState extends State<VarifyPage> {
  final _loginController = Get.put(LoginController());
  Timer? _timer;
  @override
  void initState() {
    _loginController.varifyEmail();
    _timer = Timer.periodic(Duration(seconds: 10), (_timer) async {
      if (await _loginController.isVarifiredEmail()) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage("Home"),
          ),
        );
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text("Varifying page"),
      ),
    );
  }
}
