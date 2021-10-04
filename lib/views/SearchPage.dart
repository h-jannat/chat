import 'package:chat/utilities/signIn.dart';
import 'package:chat/views/widgets/AppBarMain.dart';
import 'package:chat/views/widgets/Drawer.dart';
import 'package:chat/views/widgets/SearchBox.dart';
import 'package:chat/views/widgets/UserCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _loginController = Get.put(LoginController());
  List _results = [{"username": "user", "email": "as@hkj.com"}, {"username": "user1", "email": "as1@hkj.com"}, {"username": "user2", "email": "as2@hkj.com"}];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(),
      endDrawer: SideDrawer(_loginController),
      body: SingleChildScrollView(
        child: Container(
          width: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchBox((term) {
                print(term);
              }),
              Container(
                width: 1000,
                height: 600,
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) => 
                  UserCard(_results[index]["username"], _results[index]["email"]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
