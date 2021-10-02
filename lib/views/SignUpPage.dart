import 'package:chat/views/HomePage.dart';
import 'package:chat/views/SignInPage.dart';
import 'package:chat/views/widgets/AppBarMain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../colors.dart';
import '../utilities/signIn.dart';
import 'package:chat/views/VarifyPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController reEnterPasswordController =
      TextEditingController(text: "");
  final _loginController = Get.put(LoginController());
  bool _error = false;
  bool _isObscure = true;
  //border styles
  OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(width: 2.0),
    borderRadius: BorderRadius.circular(25.0),
  );

  void _runAfterSignUp() async {
    if (_loginController.user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => VarifyPage(),
        ),
      );
    } else {
      setState(() {
        _error = true;
      });
    }
  }

  void _signUp(context) async {
    if (_formKey.currentState!.validate()) {
      await _loginController.signUpEmailPass(
          usernameController.text, passwordController.text);
     _runAfterSignUp();
    }
  }

  _passwordValidator(value) {
    if (value.length < 6) {
      return "Password length should be more than 5 characters";
    } else
      return null;
  }

  _emailValidator(value) {
    if (value == null || value == "") {
      return "Email can't be empty";
    } else if (!value.contains("@") || !value.contains(".")) {
      return "Input should be an email";
    } else
      return null;
  }

  _equalValidator(value, mainValue) {
    print("equality");
    print(value);
    print(mainValue);
    if (value != mainValue) {
      return "Values are not matched";
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarMain(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 100, left: 50, right: 50),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(_error ? "Sign up error" : ""),
                TextFormField(
                  controller: usernameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: inputBorder,
                  ),
                  validator: (value) => _emailValidator(value),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: 'Password', border: inputBorder),
                  validator: (value) => _passwordValidator(value),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: reEnterPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Re-Enter Password',
                    border: inputBorder,
                  ),
                  validator: (value) =>
                      _equalValidator(value, passwordController.text),
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
                ElevatedButton(
                  child: Text("SIGN Up"),
                  onPressed: () {
                    print("signUp");
                    _signUp(context);
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
                  child: Text("SIGN UP WITH GOOGLE"),
                  onPressed: () => {_loginController.googleSignIn()},
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
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => SignInPage())),
                      child: Text("SIGN IN"),
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
