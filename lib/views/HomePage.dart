import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage(this.title);
  final title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(title),
      ),
      body: Center(
       child: Text("Chat"),
      ),
      
    );
  }
}