import 'package:chat/utilities/signIn.dart';
import 'package:chat/views/HomePage.dart';
import 'package:chat/views/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarMain extends StatelessWidget with PreferredSizeWidget{

  Widget build(BuildContext context) {
    final _loginController = Get.put(LoginController());
    void _logOut(BuildContext context) async {
      await _loginController.signOut();
      Navigator.pushReplacementNamed(context, "/signIn");
         
    }

    return AppBar(
      actions: [
        TextButton(
          onPressed: () => _logOut(context),
          child: Text(
            "Log out",
            style: TextStyle(color: Colors.yellow),
          ),
        ),
        Builder(builder: (context) {
          return GestureDetector(
            child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: _loginController.user.photoURL != null
                    ? NetworkImage(_loginController.user.photoURL)
                    : AssetImage(
                        "assets/images/user.png",
                      ) as ImageProvider),
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
          );
        }),
      ],
      title: GestureDetector (child: Text("Chat"),
      onTap: ()=> Navigator.pushReplacementNamed(context, "/home")
           
          
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
