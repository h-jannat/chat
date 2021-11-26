import 'dart:io';

import 'package:chat/models/Message.dart';
import 'package:chat/models/User.dart';
import 'package:chat/utilities/signIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseController extends LoginController {
  String _chatRoomId = "";
  int _shownMessagesCount = 10;
  List<Message> _messages = [];

  get messages => _messages;

  UserModel _currentUser = UserModel(username: "", email: "", photoURL: "");

  get shownMessagesCount => _shownMessagesCount;

  void increaseShownMessages() {
    _shownMessagesCount += 10;
  }

  getUsersByUsername(String term) async {
    final result = await FirebaseFirestore.instance
        .collection("users")
        .where('name', isGreaterThanOrEqualTo: term)
        .where('name', isLessThanOrEqualTo: term + '\uf8ff')
        .get();
    print("search in users");
    List<Map> users = result.docs.map((doc) => doc.data()).toList();
    users.removeWhere((element) => element["email"] == user.email);
    print(users);
    return users;
  }

  getUserByEmail() async {
    print("get user by email");
    final result = await FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: user.email)
        .get();
    print("get user");
    print(result);
    List<Map> currentUserList = result.docs.map((doc) => doc.data()).toList();
    print(currentUserList);
    if (currentUserList.isNotEmpty) {
      _currentUser = UserModel(
          username: currentUserList[0]["username"],
          email: currentUserList[0]["email"],
          photoURL: currentUserList[0]["photoURL"] ?? "");
    }
  }

  get currentUser => _currentUser;

  uploadUserData(userData) {
    FirebaseFirestore.instance.collection("users").doc(user.uid).set(userData);
  }

  get newMethod => user;

  _generateChatRoomId(List names) {
    names.sort((a, b) => a.compareTo(b));
    return names.reduce((value, element) => value + '-' + element);
  }

  createChatRoom(String targetUserName, String targetUserEmail) {
    try {
      _chatRoomId = _generateChatRoomId([user.email, targetUserEmail]);
      print("creat room");
      print(currentUser);
      Map<String, dynamic> data = {
        "time": Timestamp.now(),
        "names": [currentUser.username, targetUserName],
        "emails": [currentUser.email, targetUserEmail],
        "chatRoomId": currentUser.email + "-" + targetUserEmail
      };
      //FirebaseFirestore.instance.collection("chat-rooms").document(id).setData(data).catch(err=>print(err))
      FirebaseFirestore.instance
          .collection("chat-rooms")
          .doc(_chatRoomId)
          .set(data)
          .catchError((e) => print(e));
    } catch (e) {
      print(e);
    }
  }

  sendMessage(String message) async {
    FirebaseFirestore.instance
        .collection("chat-rooms")
        .doc(_chatRoomId)
        .collection("chat")
        .add({
      "message": message,
      "sender": user.email,
      "time": Timestamp.now()
    }).catchError((e) => print(e));
    FirebaseFirestore.instance
        .collection("chat-rooms")
        .doc(_chatRoomId)
        .update({"chatLength": FieldValue.increment(1)});
  }

  Stream<QuerySnapshot> getUserChatRooms(int size) {
    return FirebaseFirestore.instance
        .collection("chat-rooms")
        .where('emails', arrayContains: currentUser.email)
        //   .orderBy("time", descending: true)
        .snapshots();
  }

  getConversationMessages() async {
    final messagesSnaps = await FirebaseFirestore.instance
        .collection("chat-rooms")
        .doc(_chatRoomId)
        .collection("chat")
        .orderBy("time")
        .get()
        .catchError((e) => print(e));

    _messages = messagesSnaps.docs
        .map(
          (doc) => Message(
              message: doc.data()["message"],
              sender: doc.data()["sender"],
              time: doc.data()["time"]),
        )
        .toList();

    print(_messages);
  }

  Stream<QuerySnapshot> getMessagesStream(int allMessagesSize) {
    return FirebaseFirestore.instance
        .collection("chat-rooms")
        .doc(_chatRoomId)
        .collection("chat")
        .orderBy("time")
        .limit(_shownMessagesCount)
        .snapshots();
  }

  uploadFile(String destination, File file) async {
    try {
      final fireStorage = FirebaseStorage.instance.ref(destination);
      return fireStorage.putFile(file);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getURL(path) async {
    try {
      print("url");
      print(path);
      String downloadURL =
          await FirebaseStorage.instance.ref(path).getDownloadURL();
      return downloadURL;
      // Within your widgets:
      // Image.network(downloadURL);
    } catch (e) {
      print(e);
      return "";
    }
  }

  setUserPhotoURL() async {
    try {
      print("profileImages/${_currentUser.username}-profile-photo");
      String downloadURL = await FirebaseStorage.instance
          .ref("profileImages/${_currentUser.username}-profile-photo")
          .getDownloadURL();
      print(downloadURL);
      FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({"photoURL": downloadURL}).catchError((e) => print(e));
    } catch (e) {
      print(e);
    }
  }
}
