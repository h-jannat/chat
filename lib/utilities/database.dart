
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController{
  getUserByUsername(String username){

  }

  uploadUserData(userData){
    FirebaseFirestore.instance.collection("users")
    .add(userData);
  }
}