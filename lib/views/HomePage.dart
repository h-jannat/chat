import 'package:chat/utilities/signIn.dart';
import 'package:chat/views/SearchPage.dart';
import 'package:chat/views/SignInPage.dart';
import 'package:chat/views/widgets/AppBarMain.dart';
import 'package:chat/views/widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage(this.title);
  final _loginController = Get.put(LoginController());
  final title;

  @override
  Widget build(BuildContext context) {
    print(_loginController.user);
    return Scaffold(
      endDrawer: SideDrawer(_loginController),
      appBar: AppBarMain(),
      body: Center(
        child: Text("Chat"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => SearchPage(),
            ),
          );
        },
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}
