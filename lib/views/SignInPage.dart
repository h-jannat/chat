import 'package:chat/views/widget.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget{
  @override
 _SignInPageState createState()=> _SignInPageState();
}
class _SignInPageState extends State<SignInPage>{
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar:  PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child:appBarMain(context),

    ),
  );
}
}