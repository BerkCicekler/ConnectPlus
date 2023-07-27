
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/message.dart';
import 'database.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseFireStoreMethods _firebaseFireStoreMethods = FirebaseFireStoreMethods(FirebaseFirestore.instance);

  Future<void> sendMessage(String receieverId, String senderId, String senderName, String receieverName, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(senderId: currentUserId, senderEmail: currentUserEmail, senderName: senderName, receieverId: receieverId, receieverName: receieverName, timestamp: timestamp, message: message);

    List<String> ids = [currentUserId, receieverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _fireStore.collection('chat_rooms').doc(chatRoomId).collection('messages').add(newMessage.toMap());
    _firebaseFireStoreMethods.UpdateLastMessage(receieverId, senderId, timestamp, message);
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId){
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore.collection("chat_rooms").doc(chatRoomId).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }


}