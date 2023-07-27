import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId, senderEmail, senderName, receieverId, receieverName, message;
  final Timestamp timestamp;
  Message({
    required this.senderId,
    required this.senderEmail,
    required this.senderName,
    required this.receieverId,
    required this.receieverName,
    required this.timestamp,
    required this.message
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'senderName': senderName,
      'receieverId': receieverId,
      'receieverName': receieverName,
      'message': message,
      'timestamp': timestamp
    };
  }
}