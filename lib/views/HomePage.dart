import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage(this.title);
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