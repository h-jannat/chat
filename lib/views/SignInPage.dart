import 'package:chat/views/HomePage.dart';
import 'package:chat/views/SignUpPage.dart';
import 'package:chat/views/widgets/AppBarMain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  TextEditingController _usernameController = TextEditingController(text: "");
  TextEditingController _passwordController = TextEditingController(text: "");
  bool _error = false;
  bool _isObscure = true;
  bool _saveLogin = false;
  final _loginController = Get.put(LoginController());
  final storage = new FlutterSecureStorage();
  //border styles
  Future getStoredInfo() async {
    bool _isSaved = await storage.read(key: "isSaved") == "true";
    setState(() {
      _saveLogin = _isSaved;
    });
    var savedUsername = await storage.read(key: "username");
    var savedPassword = await storage.read(key: "password");
    _usernameController.text = savedUsername != null ? savedUsername : "";
    _passwordController.text = savedPassword != null ? savedPassword : "";
  }

  @override
  void initState() {
    super.initState();
    getStoredInfo();
    print("ssssss");
    print(_saveLogin);
  }

  void runAfterSignIn() async {
    if (_loginController.user != null) {
      await _loginController.isVarifiredEmailFetch();
      if (_loginController.isVarifiredEmail) {
        storage.write(key: 'isLoggedIn', value: "true");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage("Home"),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => VarifyPage(),
          ),
        );
      }
    } else {
      setState(() {
        _error = true;
      });
    }
  }

  void _signIn(context) async {
    await _loginController.signInEmailPass(
        _usernameController.text, _passwordController.text);

    runAfterSignIn();
  }

  void _googleSignIn(context) async {
    print("google");
    await _loginController.googleSignIn();
    runAfterSignIn();
  }

  OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(width: 2.0),
    borderRadius: BorderRadius.circular(25.0),
  );
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
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: inputBorder,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: inputBorder,
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => {},
                    child: Text("Forget password?"),
                  ),
                ),
                Row(
                  children: [
                    Text("Save login info"),
                    Checkbox(
                        value: _saveLogin,
                        onChanged: (value) async {
                          if (value != null) if (value) {
                            setState(() {
                              _saveLogin = true;
                            });
                            storage.write(key: "isSaved", value: "true");
                            storage.write(
                                key: "username",
                                value: _usernameController.text);
                            storage.write(
                                key: "password",
                                value: _passwordController.text);
                          } else {
                            setState(() {
                              _saveLogin = false;
                            });
                            storage.delete(key: "isSaved");
                            storage.delete(key: "username");
                            storage.delete(key: "password");
                          }
                        }),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                _error ? Text("Login error") : SizedBox(),
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
                  onPressed: () => _googleSignIn(context),
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
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      ),
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
