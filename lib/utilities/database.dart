import 'package:chat/models/Message.dart';
import 'package:chat/models/User.dart';
import 'package:chat/utilities/signIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
    print(users);
    return users;
  }

  getUserByEmail() async {
    final result = await FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: user.email)
        .get();
    print("get user");
    List<Map> currentUserList = result.docs.map((doc) => doc.data()).toList();
    _currentUser = UserModel(
        username: currentUserList[0]["name"],
        email: currentUserList[0]["email"],
        photoURL: currentUserList[0]["photoURL"] ?? "");
  }

  get currentUser => _currentUser;
  uploadUserData(userData) {
    FirebaseFirestore.instance.collection("users").add(userData);
  }

  _generateChatRoomId(List names) {
    names.sort((a, b) => a.compareTo(b));
    return names.reduce((value, element) => value + '-' + element);
  }

  createChatRoom(String targetUserEmail) {
    try {
      _chatRoomId = _generateChatRoomId([user.email, targetUserEmail]);

      Map<String, dynamic> data = {
        "users": [user.email, targetUserEmail],
        "chatRoomId": user.email + "-" + targetUserEmail
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
}
