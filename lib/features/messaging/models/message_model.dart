import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String senderId;
  final String receiverId;
  final Timestamp timestamp;
  final String senderEmail;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
    required this.senderEmail,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      timestamp: json['timestamp'],
      senderEmail: json['senderEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'senderEmail': senderEmail,
    };
  }
}
