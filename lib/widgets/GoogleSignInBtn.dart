import 'package:chat/colors.dart';
import 'package:chat/utilities/database.dart';
import 'package:chat/utilities/signIn.dart';
import 'package:chat/views/HomePage.dart';
import 'package:chat/views/VarifyPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleSignInBtn extends StatelessWidget {
  final _loginController = Get.put(LoginController());
  final _databaseController = Get.put(DatabaseController());

  void _googleSignUp(context) async {
    print("sign up google");
    await _loginController.googleSignIn();
    await _databaseController.getUserByEmail();
    print("database user");
    print(_databaseController.currentUser);
    if (_databaseController.currentUser.username == "") {
      await _databaseController.uploadUserData({
        "username": _databaseController.user.displayName,
        "email": _databaseController.user.email
      });
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text("SIGN IN WITH GOOGLE"),
      onPressed: () {
        _googleSignUp(context);
      },
      style: ElevatedButton.styleFrom(
        primary: ctmColor(2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        minimumSize: Size(double.infinity,
            50), // double.infinity is the width and 30 is the height
      ),
    );
  }
}
