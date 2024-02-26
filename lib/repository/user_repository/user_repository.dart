import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandas/features/authentication/models/user_model.dart';

class UserRepository {
  static UserRepository get instance => Get.find();

  final _fireDB = FirebaseFirestore.instance;

  createUser(UserModel userData) async {
    await _fireDB.collection("Users").add(userData.toJson()).whenComplete(
        () => Get.snackbar("Success", "User Created Successfully"));
  }

  Future<Map<String, dynamic>> getUserByEmail(String? userEmail) async {
    return await _fireDB
        .collection("Users")
        .where("email", isEqualTo: userEmail)
        .get()
        .then((value) => value.docs.first.data())
        .catchError((e) {
      return {
        "Message": "User not found",
      };
    });
  }

  getUserById(String? userId) {
    return _fireDB
        .collection("Users")
        .where("id", isEqualTo: userId)
        .get()
        .then((value) => value.docs.first.data());
  }

  createMessageRequest(String? senderId, String? receiverId,
      String? senderImage, String? senderName) async {
    await _fireDB.collection("Messages").add({
      "senderId": senderId,
      "receiverId": receiverId,
      "status": "pending",
      "senderImage": senderImage,
      "senderName": senderName,
      "timestamp": FieldValue.serverTimestamp()
    }).whenComplete(() => Get.snackbar("Success", "Message Request Sent",
        backgroundColor: Colors.amber));
  }

  isRequested(String? senderId, String? receiverId) async {
    return await _fireDB
        .collection("Messages")
        .where("senderId", isEqualTo: senderId)
        .where("receiverId", isEqualTo: receiverId)
        .get()
        .then((value) => value.docs.isNotEmpty);
  }

  getMessages(String? userId) {
    return _fireDB
        .collection("Messages")
        .where(Filter.or(Filter("receiverId", isEqualTo: userId),
            Filter("senderId", isEqualTo: userId)))
        .snapshots();
  }

  acceptMessageRequest(String? receiverId, String? senderId) async {
    await _fireDB
        .collection("Messages")
        .where("receiverId", isEqualTo: receiverId)
        .where("senderId", isEqualTo: senderId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _fireDB
            .collection("Messages")
            .doc(element.id)
            .update({"status": "accepted"});
      });
    });
  }
}
