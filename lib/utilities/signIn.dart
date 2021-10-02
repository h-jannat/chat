import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  bool _isVarifiredEmail = false;
  get user => _firebaseAuth.currentUser;
  get isVarifiredEmail => _isVarifiredEmail;

  Future signInEmailPass(String email, String password) async {
    print("Sign in email pass");
    print(_firebaseAuth.currentUser);
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("result");

      print(result);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future signUpEmailPass(String email, String password) async {
    try {
      print("sign up");
      print(email+password);
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
        print(_isVarifiredEmail);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future googleSignIn() async {
    try {
      final _googleUser = await _googleSignIn.signIn();
      print(_googleUser);
      if (_googleUser == null) return;
      final _googleAuth = await _googleUser.authentication;
      final _credential = GoogleAuthProvider.credential(
          accessToken: _googleAuth.accessToken, idToken: _googleAuth.idToken);
      await _firebaseAuth.signInWithCredential(_credential);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();

    print('signout');
    print(_firebaseAuth.currentUser);
  }
}
