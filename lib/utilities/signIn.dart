import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signInEmailPass(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
    } catch (e) {
      print(e);
    }
  }
}
