import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  getUserByUserName(String userName) async {
    return await Firestore.instance.collection('users')
        .where('name', isEqualTo: userName)
        .getDocuments();
  }

  getUserByUserEmail(String userEmail) async {
    return await Firestore.instance.collection('users')
        .where('email', isEqualTo: userEmail)
        .getDocuments();
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance.collection('ChatRoom')
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
          print(e.toString());
    });
  }
  uploadUserInfo(userMap) {
    Firestore.instance.collection('users')
        .add(userMap)
    .catchError((e) {
      print(e.toString());
    });
  }
}