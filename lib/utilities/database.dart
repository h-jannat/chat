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

  _generateChatRoomId(List names) {
    names.sort((a, b) => a.compareTo(b));
    return names.reduce((value, element) => value + '-' + element);
  }

  createChatRoom(String targetUserEmail) {
    try {
      String id = _generateChatRoomId([user.email, targetUserEmail]);
      Map<String, dynamic> data = {
        "users": [user.email, targetUserEmail],
        "chatRoomId": user.email + "-" + targetUserEmail
      };
      //FirebaseFirestore.instance.collection("chat-rooms").document(id).setData(data).catch(err=>print(err))
      FirebaseFirestore.instance
          .collection("chat-rooms")
          .doc(id)
          .set(data)
          .catchError((e) => print(e));
    } catch (e) {
      print(e);
    }
  }
}
