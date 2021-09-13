import 'package:chat/utilities/signIn.dart';
import 'package:chat/views/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage(this.title);
  final _loginController = Get.put(LoginController());
  final title;
  void _logOut(BuildContext context) async {
    await _loginController.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => _logOut(context),
            child: Text(
              "Log out",
              style: TextStyle(color: Colors.yellow),
            ),
          ),
        ],
        title: Text(title),
      ),
      body: Center(
        child: Text("Chat"),
      ),
    );
  }
}
