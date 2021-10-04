import 'package:chat/utilities/signIn.dart';
import 'package:chat/views/widgets/AppBarMain.dart';
import 'package:chat/views/widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final _loginController = Get.put(LoginController());


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
          Navigator.pushNamed(context, "/search");
        },
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
}
