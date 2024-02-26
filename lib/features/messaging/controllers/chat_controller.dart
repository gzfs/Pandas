import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandas/features/core/controllers/bluetooth_controller.dart';
import 'package:pandas/features/messaging/models/message_model.dart';

class ChatController extends GetxController with StateMixin {
  static ChatController get instance => Get.find();

  TextEditingController messageController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String message, String receiverId, String senderIdSike) async {
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timeStamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
      message: message,
      senderId: BluetoothState.instance.userID!,
      senderEmail: currentUserEmail,
      receiverId: receiverId == BluetoothState.instance.userID!
          ? senderIdSike
          : receiverId,
      timestamp: timeStamp,
    );

    List<String> ids = [receiverId, senderIdSike];

    String chatRoomId = ids.join("-");

    await _firestore
        .collection("Room")
        .doc(chatRoomId)
        .collection("Chats")
        .add(newMessage.toJson());
  }

  Stream<QuerySnapshot> getMessages(String receiverId, String senderId) {
    List<String> ids = [receiverId, senderId];

    String chatRoomId = ids.join("-");

    return _firestore
        .collection("Room")
        .doc(chatRoomId)
        .collection("Chats")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
