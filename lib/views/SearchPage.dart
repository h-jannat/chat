import 'package:chat/utilities/signIn.dart';
import 'package:chat/views/widgets/AppBarMain.dart';
import 'package:chat/views/widgets/Drawer.dart';
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
  TextEditingController _searchController = TextEditingController(text: "");
  OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(width: 1.0),
    borderRadius: BorderRadius.circular(25.0),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(),
      endDrawer: SideDrawer(_loginController),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: 50,
child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                border: inputBorder,
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                )),
          ),
          )
          
        ],
      )),
    );
  }
}
