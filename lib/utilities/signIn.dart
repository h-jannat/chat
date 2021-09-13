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
  bool _isVarifiredEmail = false;
  Future signInEmailPass(String email, String password) async {
    print("Sign in email pass");
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
          print("result");
          
      print(result);
    } on FirebaseAuthException catch (e){  
      print(e);
    }
  }

  Future signUpEmailPass(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      print(result);
    } catch (e) {
     
      print(e);
    }
  }

  void varifyEmail() {
    User? _user = _firebaseAuth.currentUser;
    _user?.sendEmailVerification();
  }

  Future isVarifiredEmailFetch() async {
    try {
      User? _user = _firebaseAuth.currentUser;
      if (_user != null) {
        await _user.reload();
        _isVarifiredEmail = _user.emailVerified;
        print("user");
        print(_user);
        print( _isVarifiredEmail);
      }
    } catch (e) {
      print(e.toString());
    }
  }
get user => _firebaseAuth.currentUser;
  get isVarifiredEmail => _isVarifiredEmail;

  Future googleSignIn() async {
    final _googleUser = await _googleSignIn.signIn();
    print(_googleUser);
    if (_googleUser == null) return;
    final _googleAuth = await _googleUser.authentication;
    final _credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken, idToken: _googleAuth.idToken);
    await _firebaseAuth.signInWithCredential(_credential);
  }


  Future signOut() async {
    await _firebaseAuth.signOut();

    print('signout');
    print(_firebaseAuth.currentUser);
  }
}
