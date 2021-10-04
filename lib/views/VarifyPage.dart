import 'dart:async';
import 'package:get/get.dart';

import '../utilities/signIn.dart';
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
  
    super.initState();
  }
  void varify(){
      _loginController.varifyEmail();
    _timer = Timer.periodic(Duration(seconds: 10), (_timer) async {
      await _loginController.isVarifiredEmailFetch();
      if (_loginController.isVarifiredEmail) {
        _timer.cancel();
        Navigator.of(context).pushReplacementNamed("/home");
      }
    });
  }
@override
void dispose(){
  _timer?.cancel();
  super.dispose();
}
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(onPressed: varify, child: Text("Send varification link")),
      ),
    );
  }
}

