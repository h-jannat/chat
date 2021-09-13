import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

//SHA1: CA:37:3B:69:AF:06:1E:4B:3F:96:97:8F:5A:3C:7F:DF:B7:BD:EE:D5
//SHA256: CB:32:14:0B:DA:F1:06:87:7E:05:A4:9A:96:21:B5:79:8B:F0:5F:E9:17:3F:BA:07:CF:52:4E:60:B5:0D:30:DC
//SHA1: 84:70:11:37:FC:7D:19:34:50:CC:4E:17:54:17:0B:6B:44:09:D5:CE
//       SHA256: C8:C8:0E:E6:B5:56:22:A4:76:F4:2C:52:4A:A5:56:6D:EA:CD:1C:B8:39:58:11:AA:4A:09:5D:A6:10:20:23:A1

class LoginController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  bool _isVarifiredEmail = false;
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

  get user => _firebaseAuth.currentUser;
  get isVarifiredEmail => _isVarifiredEmail;

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

    print('signout');
    print(_firebaseAuth.currentUser);
  }
}
