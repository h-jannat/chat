
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

//SHA1: CA:37:3B:69:AF:06:1E:4B:3F:96:97:8F:5A:3C:7F:DF:B7:BD:EE:D5
//SHA256: CB:32:14:0B:DA:F1:06:87:7E:05:A4:9A:96:21:B5:79:8B:F0:5F:E9:17:3F:BA:07:CF:52:4E:60:B5:0D:30:DC
class LoginController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future signInEmailPass(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
    } catch (e) {
      print(e);
    }
  }

  Future signUpEmailPass(
      String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      print(result);

    } catch (e) {
      print(e);
    }
  }
void varifyEmail(){
  User? _user = _firebaseAuth.currentUser;
   _user?.sendEmailVerification();
}
Future isVarifiredEmail()async{
  try{
  User? _user = _firebaseAuth.currentUser;
  await _user?.reload();
  return _user?.emailVerified;
  }
  catch(e){
    print(e.toString());
    return false;
  }
}
  Future googleSignIn() async {
    final _googleUser = await _googleSignIn.signIn();
    print(_googleUser);
    if (_googleUser == null) return;
    final _googleAuth = await _googleUser.authentication;
    final _credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken, idToken: _googleAuth.idToken);
    await _firebaseAuth.signInWithCredential(_credential);
  }
}
