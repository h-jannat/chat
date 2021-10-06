import 'package:chat/utilities/database.dart';
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
  final _databaseController = Get.put(DatabaseController());
  TextEditingController _searchController = TextEditingController(text: "");
  List<Map> _users =[];
  
  onSearch(username) async {
    List<Map> result = await _databaseController.getUserByUsername(username);
    print(result);
    setState(() {
      _users=result;
    });
    
  }

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
              SearchBox(onSearch, _searchController),
              Container(
                width: 1000,
                height: 600,
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) => UserCard(
                      _users[index]["name"], _users[index]["email"]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
