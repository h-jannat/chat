import 'package:chat/views/HomePage.dart';
import 'package:chat/views/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors.dart';
import '../utilities/signIn.dart';
import 'package:chat/views/VarifyPage.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  bool _error = false;
  final _loginController = Get.put(LoginController());
  //border styles
  OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(width: 2.0),
    borderRadius: BorderRadius.circular(25.0),
  );
  void _signIn(context) async {
    await _loginController.signInEmailPass(
        usernameController.text, passwordController.text);
    await _loginController.isVarifiredEmailFetch();
    print(_loginController.isVarifiredEmail);
    if (_loginController.isVarifiredEmail) {
      print(_loginController.isVarifiredEmail);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage("Home"),
        ),
      );
    } else {
      _error = true;
    }
  }
  void _googleSignIn(context) async {
    await _loginController.googleSignIn();
    await _loginController.isVarifiredEmailFetch();
    if(_loginController.user != null){
    print(_loginController.isVarifiredEmail);
    if (_loginController.isVarifiredEmail) {
      print(_loginController.isVarifiredEmail);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage("Home"),
        ),
      );
    }
    else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => VarifyPage(),
        ),
      );
    }
    } else {
      _error = true;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBarMain(context),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 100, left: 50, right: 50),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: inputBorder,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password', border: inputBorder),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => {},
                    child: Text("Forget password?"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                _error ? Text("Login errror") : SizedBox(),
                ElevatedButton(
                  child: Text("SIGN IN"),
                  onPressed: () {
                    print("signIn");
                    _signIn(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    minimumSize: Size(double.infinity,
                        50), // double.infinity is the width and 30 is the height
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text("SIGN IN WITH GOOGLE"),
                  onPressed: () => _googleSignIn,
                  style: ElevatedButton.styleFrom(
                    primary: ctmColor(2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    minimumSize: Size(double.infinity,
                        50), // double.infinity is the width and 30 is the height
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not registered yet?"),
                    TextButton(
                      onPressed: () => {},
                      child: Text("SIGN UP"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
