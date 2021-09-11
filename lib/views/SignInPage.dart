import 'package:chat/views/widget.dart';
import 'package:flutter/material.dart';
import '../colors.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = new GlobalKey<FormState>();
  //border styles
  OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(width: 2.0),
    borderRadius: BorderRadius.circular(25.0),
  );
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
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: inputBorder,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
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
                ElevatedButton(
                  child: Text("SIGN IN"),
                  onPressed: () => {},
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
                  onPressed: () => {},
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
