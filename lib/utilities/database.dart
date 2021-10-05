import 'package:chat/utilities/signIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DatabaseController extends LoginController {
  getUserByUsername(String term) async {
    final result = await FirebaseFirestore.instance
        .collection("users")
        .where('name', isGreaterThanOrEqualTo: term)
        .where('name', isLessThanOrEqualTo: term + '\uf8ff')
        .get();
    print("search in users");
    List<Map> users = result.docs.map((doc) => doc.data()).toList();
    print(users);
    return users;
  }

  uploadUserData(userData) {
    FirebaseFirestore.instance.collection("users").add(userData);
  }

  createChatRoom(String targetUserEmail) {
    try{
      //FirebaseFirestore.instance.collection("chat-rooms").document(id).setData(data).catch(err=>print(err))
    FirebaseFirestore.instance.collection("chat-rooms").add({
      "users": [user.email, targetUserEmail],
      "chatRoomId": user.email + "-" + targetUserEmail
    });
    }catch(e){
      print(e);
    }
  }
}
